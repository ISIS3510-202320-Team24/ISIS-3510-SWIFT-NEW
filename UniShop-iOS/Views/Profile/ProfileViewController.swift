import Foundation
import SwiftUI
import CoreLocation
import MapKit

struct Alert: Codable {
    var danger: Int
    var latitude: String
    var longitude: String
    var user_id: String
}


class ProfileViewController: ObservableObject {
    @Published var showingAlert = false
    @Published var alertMessage = ""
    @Published var nextScreen: String? = nil
    private var locationManager = LocationManager()
    
    var latitude: String {
        return "\(locationManager.location?.coordinate.latitude ?? 4.60142035)"
    }
    
    var longitude: String {
        return "\(locationManager.location?.coordinate.longitude ?? 74.0649170096208)"
    }

    func sendAlertAPI() {
        let urlString = "https://creative-mole-46.hasura.app/api/rest/alert/create"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        let alertObject: [String: Any] = [
            "danger": 5,
            "latitude": latitude,
            "longitude": longitude,
            "user_id": UserDefaults.standard.string(forKey: "userID") ?? "id"
        ]
            
        let requestBody: [String: Any] = ["object": alertObject]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
            
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("mmjEW9L3cf3SZ0cr5pb6hnnnFp1ud4CB4M6iT1f0xYons16k2468G9SqXS9KgdAZ", forHTTPHeaderField: "x-hasura-admin-secret")
            request.httpMethod = "POST"
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode {
                    DispatchQueue.main.async {
                        self.alertMessage = "Your alert has been sent to all nearby users. We have been notified about your situation and help is on the way. Stay calm and stay safe."
                        self.showingAlert = true
                    }
                } else if let error = error {
                    print("HTTP request failed: \(error)")
                    DispatchQueue.main.async {
                        self.alertMessage = "There was a problem sending your alert. Please check your internet connection and try again."
                        self.showingAlert = true
                    }
                } else {
                    print("HTTP request failed: unknown error")
                    DispatchQueue.main.async {
                        self.alertMessage = "There was a problem sending your alert. Please try again."
                        self.showingAlert = true
                    }
                }
            }.resume()
            
        } catch {
            print("JSON encoding failed: \(error)")
            DispatchQueue.main.async {
                self.alertMessage = "There was a problem sending your alert. Please try again."
                self.showingAlert = true
            }
        }
    }
}

