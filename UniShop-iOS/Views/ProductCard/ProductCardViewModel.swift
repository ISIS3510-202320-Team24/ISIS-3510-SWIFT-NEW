import Foundation
import SwiftUI

struct Response: Codable {
    let post: [Product]
}

struct ProductResponse: Codable {
    let data: ProductData
}

struct ProductData: Codable {
    let post: [Product]
}

struct Product: Codable {
    let id: String
    let degree: String
    let description: String
    let new: Bool
    let price: String
    let recycled: Bool
    let subject: String
    let urlsImages: String
    let date: String
    let name: String
    let user: User
}

struct User: Codable {
    let name: String
    let username: String
}

class ProductCardViewModel: ObservableObject {
    @Published var products = [Product]()

    func fetchProducts() {
        guard let url = URL(string: "https://creative-mole-46.hasura.app/api/rest/post/all") else { return }

        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("mmjEW9L3cf3SZ0cr5pb6hnnnFp1ud4CB4M6iT1f0xYons16k2468G9SqXS9KgdAZ", forHTTPHeaderField: "x-hasura-admin-secret")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Network error: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let response = try JSONDecoder().decode(Response.self, from: data)
                DispatchQueue.main.async {
                    self.products = response.post
                    print("Products fetched: \(self.products)")  // Debugging output
                }
            } catch {
                print("Decoding error: \(error)")
            }
        }.resume()
    }
}

