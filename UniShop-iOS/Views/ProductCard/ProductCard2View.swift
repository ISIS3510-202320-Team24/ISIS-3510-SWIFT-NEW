import SwiftUI

struct ProductCard2View: View {
    var product2: Product2
    
    var body: some View {
        NavigationLink(destination: ProductDetailView(productId: product2.id ?? "")) {
            VStack(alignment: .leading, spacing: 0) {
                if let urlString = product2.urlsImages?.split(separator: ";").first,
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
                
                Text(product2.name ?? "")
                    .font(.custom("Helvetica", size: 18))
                    .frame(height: 40)
                
                
                Text(product2.price ?? "0")
                    .font(.custom("Helvetica", size: 16))
                    .foregroundColor(Color(red: 0.241, green: 0.257, blue: 0.222))
                    .frame(height: 30)
                
                HStack {
                    Text(product2.user?.username ?? "")
                        .font(.custom("Helvetica", size: 15))
                        .foregroundColor(Color(red: 0.541, green: 0.557, blue: 0.522))
                        .frame(height: 20)
                    
                    Spacer()
                    
                    Image(systemName: "heart")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .foregroundColor(.gray)
                }
            }
            .padding(10)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

