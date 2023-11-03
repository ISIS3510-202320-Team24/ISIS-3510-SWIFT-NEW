import Foundation

struct ProductDetailResponse: Codable {
    let post: [ProductDetail]
}

struct ProductDetail: Codable {
    let degree: String
    let description: String
    let new: Bool
    let price: String
    let recycled: Bool
    let subject: String
    let urlsImages: String
    let date: String
    let name: String
    let category: String
    let sold: Bool
    let user: User
}

/**
 Detail view model
 */
class ProductDetailViewModel: ObservableObject {
    @Published var product: ProductDetail?

    func fetchProduct(with productId: String) {
        guard let url = URL(string: "https://creative-mole-46.hasura.app/api/rest/post/one?id=\(productId)") else { return }

        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        /**
         add the headers*/
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
                let response = try JSONDecoder().decode(ProductDetailResponse.self, from: data)
                DispatchQueue.main.async {
                    self.product = response.post.first
                }
            } catch {
                print("Decoding error: \(error)")
            }
        }.resume()
    }
}

