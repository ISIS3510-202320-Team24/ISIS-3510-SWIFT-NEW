import Foundation
import SwiftUI

struct Response2: Codable {
    let post: [Product2]
}

struct Product2: Codable {
    let id: String?
    let degree: String?
    let description: String?
    let new: Bool?
    let price: String?
    let recycled: Bool?
    let subject: String?
    let urlsImages: String?
    let date: String?
    let name: String?
    let user: User2?
}

struct User2: Codable {
    let email: String?
    let username: String?
}


class PostsController: ObservableObject {
    @Published var userProducts = [Product2]()
    @Published var isLoading: Bool = false
    @Published var loadingMessage: String = ""
    
    func fetchProductsByUserID(id: String) {
        self.userProducts = []
        self.loadingMessage = "Loading your posts..."
        self.isLoading = true
        
        guard let url = URL(string: "https://creative-mole-46.hasura.app/api/rest/post/user") else {
            self.isLoading = false
            print("Error: Unable to construct URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("mmjEW9L3cf3SZ0cr5pb6hnnnFp1ud4CB4M6iT1f0xYons16k2468G9SqXS9KgdAZ", forHTTPHeaderField: "x-hasura-admin-secret")
        
        let body: [String: Any] = ["id": id]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        URLSession.shared.dataTask(with: request) { data, response, error in
            defer {
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
            
            if let error = error {
                print("Network error: \(error)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
                if !(200...299).contains(httpResponse.statusCode) {
                    print("Server returned an error status code.")
                }
            }
            
            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let response = try JSONDecoder().decode(Response2.self, from: data)
                DispatchQueue.main.async {
                    self.userProducts = response.post.reversed()
                }
            } catch {
                print("Decoding error: \(error)")
                
                if let bodyStr = String(data: data, encoding: .utf8) {
                    print("Response Body: \(bodyStr)")
                }
            }
        }.resume()
    }

}

