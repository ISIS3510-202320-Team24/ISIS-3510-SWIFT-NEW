import SwiftUI

struct ProductCard3View: View {
    var product: Product
    var userId: String
    @ObservedObject var controller: FavoritesController
    
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
                    
                    Image(systemName: "heart")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .foregroundColor(.gray)
                }
                
                Button(action: removeProduct) {
                    Text("Remove")
                        .font(.system(size: 16, design: .default))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .background(Color(red: 1, green: 0, blue: 0))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.top, 20)
            }
            .padding(10)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    func removeProduct() {
        self.controller.deleteFavoritesPostById(post_id: product.id, user_id: userId) { success in
            if success{
            }
        }
    }
}

