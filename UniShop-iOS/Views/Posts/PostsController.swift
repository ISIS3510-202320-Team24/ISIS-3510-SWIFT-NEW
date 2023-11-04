import Foundation
import SwiftUI

class PostsController: ObservableObject {
    @Published var userProducts = [Product]()
    @Published var isLoading: Bool = false
    @Published var loadingMessage: String = ""
    
    private let userProductsKey = "userPosts"
    
    init() {
        loadFromLocalStorage()
    }
    
    func fetchProductsByUserID(id: String) {
        if !userProducts.isEmpty && UserDefaults.standard.data(forKey: userProductsKey) != nil {
            return
        }
        
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
                if !(200...299).contains(httpResponse.statusCode) {
                    print("Server returned an error status code.")
                }
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let response = try JSONDecoder().decode(Response.self, from: data)
                DispatchQueue.main.async {
                    self.userProducts = response.post.reversed()
                    self.saveToLocalStorage()
                }
            } catch {
                print("Decoding error: \(error)")
                
                if let bodyStr = String(data: data, encoding: .utf8) {
                    print("Response Body: \(bodyStr)")
                }
            }
        }.resume()
    }
    
    func deletePostById(id: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "https://creative-mole-46.hasura.app/api/rest/post/delete") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("mmjEW9L3cf3SZ0cr5pb6hnnnFp1ud4CB4M6iT1f0xYons16k2468G9SqXS9KgdAZ", forHTTPHeaderField: "x-hasura-admin-secret")
        
        let body: [String: Any] = ["id": id]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Network error: \(error)")
                completion(false)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if (200...299).contains(httpResponse.statusCode) {
                    completion(true)
                } else {
                    print("Server returned an error status code.")
                    completion(false)
                }
            } else {
                completion(false)
            }
            
            let defaults = UserDefaults.standard;
            defaults.removeObject(forKey: "userPosts")
            defaults.removeObject(forKey: "allProducts")
            defaults.removeObject(forKey: "recommendedProducts")
            defaults.removeObject(forKey: "userFavorites")
            DispatchQueue.main.async {
                self.fetchProductsByUserID(id: id)
            }

            
        }.resume()
    }
    
    func sold(user_id: String, post_id: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "https://creative-mole-46.hasura.app/api/rest/sold") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("mmjEW9L3cf3SZ0cr5pb6hnnnFp1ud4CB4M6iT1f0xYons16k2468G9SqXS9KgdAZ", forHTTPHeaderField: "x-hasura-admin-secret")
        
        let body: [String: Any] = ["post_id": post_id, "user_id": user_id, "soldDate": Date.now.description]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Network error: \(error)")
                completion(false)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if (200...299).contains(httpResponse.statusCode) {
                    completion(true)
                } else {
                    print("Server returned an error status code.")
                    completion(false)
                }
            } else {
                completion(false)
            }
            let defaults = UserDefaults.standard;
            defaults.removeObject(forKey: "userPosts")
            defaults.removeObject(forKey: "allProducts")
            defaults.removeObject(forKey: "recommendedProducts")    
            defaults.removeObject(forKey: "userFavoriteProducts")
            DispatchQueue.main.async {
                self.fetchProductsByUserID(id: user_id)
            }
        }.resume()
        
    }
    
    func unsold(user_id: String, post_id: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "https://creative-mole-46.hasura.app/api/rest/notsold") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("mmjEW9L3cf3SZ0cr5pb6hnnnFp1ud4CB4M6iT1f0xYons16k2468G9SqXS9KgdAZ", forHTTPHeaderField: "x-hasura-admin-secret")
        
        let body: [String: Any] = ["post_id": post_id, "user_id": user_id]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Network error: \(error)")
                completion(false)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if (200...299).contains(httpResponse.statusCode) {
                    completion(true)
                } else {
                    print("Server returned an error status code.")
                    completion(false)
                }
            } else {
                completion(false)
            }
            let defaults = UserDefaults.standard;
            defaults.removeObject(forKey: "userPosts")
            defaults.removeObject(forKey: "allProducts")
            defaults.removeObject(forKey: "recommendedProducts")
            defaults.removeObject(forKey: "userFavoriteProducts")
            DispatchQueue.main.async {
                self.fetchProductsByUserID(id: user_id)
            }        }.resume()
        
    }
    
    private func saveToLocalStorage() {
        do {
            let encodedData = try JSONEncoder().encode(userProducts)
            UserDefaults.standard.set(encodedData, forKey: userProductsKey)
        } catch {
            print("Failed to save user products to local storage:", error)
        }
    }
    
    private func loadFromLocalStorage() {
        self.userProducts = []
        
        guard let encodedData = UserDefaults.standard.data(forKey: userProductsKey) else {
            return
        }
        
        do {
            self.userProducts = try JSONDecoder().decode([Product].self, from: encodedData)
        } catch {
            print("Failed to decode user products from local storage:", error)
        }
    }
}

