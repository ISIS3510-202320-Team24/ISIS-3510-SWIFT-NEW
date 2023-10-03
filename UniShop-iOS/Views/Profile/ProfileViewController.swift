import Foundation
import SwiftUI

struct Alert: Codable {
    var danger: Int
    var latitude: String
    var longitude: String
    var user_id: String
}

import Foundation
import SwiftUI
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    private var locationManager = CLLocationManager()
    @Published var location: CLLocation?
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func requestWhenInUseAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last
    }
    
    // This delegate method is called if the app is unable to retrieve a location value.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // You might handle them somehow, perhaps with an alert that tells the user what is wrong.
        // Perhaps guide them to settings app if location services are restricted or denied.
        // You would do this by opening a URL to app settings like so:
        // UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
    }
    
    // Handling when the user changes the authorization for location usage
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted, .denied:
            // Here you might present an alert to the user explaining why you need location services and encourage them to go to settings and turn on location services.
            break
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        default:
            break
        }
    }
}


class ProfileViewController: ObservableObject {
    
    @Published var showingAlert = false
    @Published var alertMessage = ""
    @Published var locationManager = LocationManager()
    
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
            "user_id": "4e8287ff-397b-4c28-ba38-310b81dcdf1a"
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

