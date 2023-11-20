import SwiftUI

struct ProductCard2View: View {
    var product: Product
    @ObservedObject var controller: PostsController
    @State private var userID: String = UserDefaults.standard.string(forKey: "userID") ?? "ID"
    
    var body: some View {
        NavigationLink(destination: ProductDetailView(productId: product.id, owner: true)) {
            VStack(alignment: .leading, spacing: 0) {
                if let urlString = product.urlsImages.split(separator: ";").first,
                   let url = URL(string: String(urlString)) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .cornerRadius(27)
                    .frame(height: 150)
                } else {
                    RoundedRectangle(cornerRadius: 27)
                        .foregroundColor(.gray)
                        .frame(height: 150)
                }
                
                Text(product.name)
                    .font(.custom("Helvetica", size: 18))
                    .frame(height: 40)
                
                
                Text(product.price)
                    .font(.custom("Helvetica", size: 16))
                    .foregroundColor(Color(red: 0.241, green: 0.257, blue: 0.222))
                    .frame(height: 30)
                
                HStack {
                    Text(product.user.username)
                        .font(.custom("Helvetica", size: 15))
                        .foregroundColor(Color(red: 0.541, green: 0.557, blue: 0.522))
                        .frame(height: 20)
                    
                    Spacer()
                }
                
                Button(action: deleteProduct) {
                    Text("Delete")
                        .font(.system(size: 16, design: .default))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .background(Color(red: 1, green: 0, blue: 0))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }.padding(.top, 20)
                if product.sold {
                    Button(action: unsoldProduct) {
                        Text("Un-Sold")
                            .font(.system(size: 16, design: .default))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 10)
                            .background(Color.cyan)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }.padding(.top, 5)
                }else{
                    Button(action: soldProduct) {
                        Text("Sold")
                            .font(.system(size: 16, design: .default))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 10)
                            .background(Color.cyan)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }.padding(.top, 5)
                }
                
            }
            .padding(10)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    func deleteProduct() {
        self.controller.deletePostById(id: product.id) { success in
            if success {
                DispatchQueue.main.async {
                    self.controller.userProducts.removeAll { $0.id == product.id }
                }
            }
        }
    }
    func soldProduct() {
        self.controller.sold(user_id: userID, post_id: product.id) { success in
            if success {
            }
        }
    }
    
    func unsoldProduct() {
        self.controller.unsold(user_id: userID, post_id: product.id) { success in
            if success {
            }
        }
    }
}

