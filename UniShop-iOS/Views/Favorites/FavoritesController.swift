import Foundation
import SwiftUI


class FavoritesController: ObservableObject {
    @Published var userFavoriteProducts = [Product]()
    @Published var isLoading: Bool = false
    @Published var loadingMessage: String = ""
    
    private let userFavoritesKey = "userFavorites"
    
    init() {
        loadFromLocalStorage()
    }
    
    func fetchFavoriteProductsByUserID(id: String) {
        if !userFavoriteProducts.isEmpty && UserDefaults.standard.data(forKey: userFavoritesKey) != nil {
            return
        }
        
        self.userFavoriteProducts = []
        self.loadingMessage = "Loading your favorites..."
        self.isLoading = true
        
        guard let url = URL(string: "https://creative-mole-46.hasura.app/api/rest/favorites/user") else {
            self.isLoading = false
            print("Error: Unable to construct URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("mmjEW9L3cf3SZ0cr5pb6hnnnFp1ud4CB4M6iT1f0xYons16k2468G9SqXS9KgdAZ", forHTTPHeaderField: "x-hasura-admin-secret")
        
        let body: [String: Any] = ["user_id": id]
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
                let response = try JSONDecoder().decode(FavoritesResponse.self, from: data)
                DispatchQueue.main.async {
                    print(response)
                    let productsList = response.favorites.map { $0.post }
                    self.userFavoriteProducts = productsList.reversed()
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
    
    func deleteFavoritesPostById(post_id: String, user_id: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "https://creative-mole-46.hasura.app/api/rest/favorites/delete") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("mmjEW9L3cf3SZ0cr5pb6hnnnFp1ud4CB4M6iT1f0xYons16k2468G9SqXS9KgdAZ", forHTTPHeaderField: "x-hasura-admin-secret")
        
        let body: [String: Any] = ["post_id": post_id, "user_id":user_id]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Network error: \(error)")
                completion(false)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
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
            defaults.removeObject(forKey: "userFavoriteProducts")
        }.resume()
    }

    private func saveToLocalStorage() {
        do {
            let encodedData = try JSONEncoder().encode(userFavoriteProducts)
            UserDefaults.standard.set(encodedData, forKey: userFavoritesKey)
        } catch {
            print("Failed to save user products to local storage:", error)
        }
    }
    
    private func loadFromLocalStorage() {
        self.userFavoriteProducts = []
        
        guard let encodedData = UserDefaults.standard.data(forKey: userFavoritesKey) else {
            return
        }

        do {
            self.userFavoriteProducts = try JSONDecoder().decode([Product].self, from: encodedData)
        } catch {
            print("Failed to decode user products from local storage:", error)
        }
    }
}

