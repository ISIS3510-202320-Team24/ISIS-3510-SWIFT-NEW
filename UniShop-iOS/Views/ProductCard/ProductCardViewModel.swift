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
    @Published var recommendedProducts = [Product]()
    @Published var isLoading: Bool = false
    @Published var loadingMessage: String = ""
    
    private let allProductsKey = "allProducts"
    private let recommendedProductsKey = "recommendedProducts"

    init() {
        loadFromLocalStorage()
    }
    
    // smart algorithm
    func fetchRecommendedProducts() {
        if !self.products.isEmpty && !self.recommendedProducts.isEmpty && UserDefaults.standard.data(forKey: recommendedProductsKey) != nil {
            self.products = self.recommendedProducts
            return
        }
        
        self.products = []
        self.recommendedProducts = []
        self.isLoading = true
        self.loadingMessage = "Searching for products that suit you..."
        
        // similar degrees mapping
        let similarDegrees: [String: [String]]  = [
            "ALL": ["ISIS", "IELE", "MATE", "ADMIN", "IIND", "ARQUI", "ARTE", "DISE", "DERE", "HIST"],
            "ISIS": ["ISIS", "IELE", "MATE", "ADMIN", "IIND"],
            "IELE": ["ISIS", "IELE", "MATE"],
            "MATE": ["ISIS", "MATE", "ADMIN", "IIND"],
            "ADMIN": ["ADMIN", "IIND", "DERE"],
            "IIND": ["ISIS", "IELE", "MATE", "ADMIN", "IIND"],
            "ARQUI": ["ARQUI", "ARTE", "DISE"],
            "ARTE": ["ARQUI", "ARTE", "DISE"],
            "DISE": ["ARQUI", "ARTE", "DISE"],
            "DERE": ["ADMIN", "DERE", "HIST"],
            "HIST": ["DERE", "HIST"]
        ]
        
        let userDegree = UserDefaults.standard.string(forKey: "userDegree") ?? "ALL"
        
        let relevantDegrees = similarDegrees[userDegree] ?? [userDegree]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
            self.products = self.allProducts.filter { product in
                return relevantDegrees.contains(product.degree)
            }
            self.recommendedProducts = self.products
            self.saveToLocalStorageRecommended()
            self.isLoading = false
        }
    }

    func fetchBargainProducts() {
        self.isLoading = true
        self.products = self.allProducts.sorted {
            let price0 = Double($0.price.replacingOccurrences(of: "[^0-9.]", with: "", options: .regularExpression)) ?? 0
            let price1 = Double($1.price.replacingOccurrences(of: "[^0-9.]", with: "", options: .regularExpression)) ?? 0
            return price0 < price1
        }
        self.isLoading = false
    }
    
    func fetchProducts() {
        if !products.isEmpty && !self.allProducts.isEmpty && UserDefaults.standard.data(forKey: allProductsKey) != nil {
            self.products = self.allProducts
            return
        }
        
        self.allProducts = []
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
                    self.products = response.post
                    self.allProducts = self.products
                    self.saveToLocalStorageAll()
                    self.isLoading = false
                }
            } catch {
                print("Decoding error: \(error)")
            }
        }.resume()
    }
    
    private func saveToLocalStorageAll() {
        do {
            let encodedData = try JSONEncoder().encode(allProducts)
            UserDefaults.standard.set(encodedData, forKey: allProductsKey)
        } catch {
            print("Failed to save all products to local storage:", error)
        }
    }
    
    private func saveToLocalStorageRecommended() {
        do {
            let encodedData = try JSONEncoder().encode(recommendedProducts)
            UserDefaults.standard.set(encodedData, forKey: recommendedProductsKey)
        } catch {
            print("Failed to save reccommended products to local storage:", error)
        }
    }
    
    private func loadFromLocalStorage() {
        self.products = []
        self.allProducts = []
        self.recommendedProducts = []
        
        guard let allData = UserDefaults.standard.data(forKey: allProductsKey) else {
            return
        }
        
        guard let recommendedData = UserDefaults.standard.data(forKey: recommendedProductsKey) else {
            return
        }

        do {
            self.allProducts = try JSONDecoder().decode([Product].self, from: allData)
            self.recommendedProducts = try JSONDecoder().decode([Product].self, from: recommendedData)
        } catch {
            print("Failed to decode from local storage:", error)
        }
    }
}

