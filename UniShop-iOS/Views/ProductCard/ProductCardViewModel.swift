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
    @Published var allProducts = [Product]()
    @Published var isLoading: Bool = false
    @Published var loadingMessage: String = ""

    // smart algorithm
    func fetchRecommendedProducts() {
        self.products = []
        self.isLoading = true
        self.loadingMessage = "Searching for products that suit you..."
        
        // similar degrees mapping
        let similarDegrees: [String: [String]]  = [
            "ALL": ["ISIS", "IELE", "MATE", "ADMIN", "IIND", "ARQUI", "ARTE", "DISE"],
            "ISIS": ["ISIS", "IELE", "MATE", "ADMIN", "IIND"],
            "IELE": ["ISIS", "IELE", "MATE"],
            "MATE": ["ISIS", "MATE", "ADMIN", "IIND"],
            "ADMIN": ["ADMIN", "IIND"],
            "IIND": ["ISIS", "IELE", "MATE", "ADMIN", "IIND"],
            "ARQUI": ["ARQUI", "ARTE", "DISE"],
            "ARTE": ["ARQUI", "ARTE", "DISE"],
            "DISE": ["ARQUI", "ARTE", "DISE"]
        ]
        
        let userDegree = UserDefaults.standard.string(forKey: "userDegree") ?? "ALL"
        
        let relevantDegrees = similarDegrees[userDegree] ?? [userDegree]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.products = self.allProducts.filter { product in
                return relevantDegrees.contains(product.degree)
            }
            self.isLoading = false
        }
    }

    func fetchBargainProducts() {
        self.products = self.allProducts.sorted {
            let price0 = Double($0.price.replacingOccurrences(of: "[^0-9.]", with: "", options: .regularExpression)) ?? 0
            let price1 = Double($1.price.replacingOccurrences(of: "[^0-9.]", with: "", options: .regularExpression)) ?? 0
            return price0 < price1
        }
    }
    
    func fetchProducts() {
        self.products = []
        self.loadingMessage = "Loading products..."
        self.isLoading = true
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
                    self.allProducts = response.post
                    self.products = self.allProducts
                    self.isLoading = false
                }
            } catch {
                print("Decoding error: \(error)")
            }
        }.resume()
    }
}

