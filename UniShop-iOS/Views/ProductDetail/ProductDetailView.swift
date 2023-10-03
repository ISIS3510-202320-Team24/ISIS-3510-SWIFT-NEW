import SwiftUI

struct VerticalSpacingModifier: ViewModifier {
    let space: CGFloat

    func body(content: Content) -> some View {
        content.padding(.vertical, space)
    }
}

extension View {
    func verticalSpacing(_ space: CGFloat) -> some View {
        self.modifier(VerticalSpacingModifier(space: space))
    }
}

struct ProductDetailView: View {
    @ObservedObject var viewModel: ProductDetailViewModel
    var productId: String

    init(productId: String) {
        self.productId = productId
        self.viewModel = ProductDetailViewModel()

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()
        navBarAppearance.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 24, weight: .bold),
            .foregroundColor: UIColor(red: 0.23, green: 0.23, blue: 0.23, alpha: 1)
        ]
        navBarAppearance.backgroundEffect = UIBlurEffect(style: .light)
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().standardAppearance = navBarAppearance
    }
    
    private func infoRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .font(.system(size: 17, weight: .bold, design: .default))
                .foregroundColor(Color(red: 0.23, green: 0.23, blue: 0.23))
            
            Text(value)
                .font(.custom("Archivo-Regular", size: 17))
                .foregroundColor(Color(.darkGray))
        }
        .padding([.leading, .trailing], 15)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                if let product = viewModel.product {

                    if let imageUrl = URL(string: product.urlsImages) {
                        AsyncImage(url: imageUrl) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width - 34, height: 300)
                        .clipped()
                        .padding([.leading, .trailing], 15)
                        .padding(.bottom, 12)
                    }

                    Text(product.description)
                        .font(.custom("Archivo-Regular", size: 17))
                        .padding([.leading, .trailing], 15)
                        .foregroundColor(Color(red: 0.23, green: 0.23, blue: 0.23))
                        .padding(.bottom, 10)
                    
                    infoRow(title: "Price:", value: product.price)
                    infoRow(title: "Status:", value: product.new ? "New" : "Recycled")
                    infoRow(title: "Subject/ Degree:", value: product.subject + ", " + product.degree)
                    infoRow(title: "Sold by:", value: product.user.name + " - @" + product.user.username)
                    infoRow(title: "Posted:", value: product.date)

                    Button(action: {
                        // handle button tap
                    }) {
                        Text("Contact Seller")
                            .font(.custom("Archivo-Regular", size: 16))
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(red: 1, green: 0.776, blue: 0))
                            .cornerRadius(8)
                    }
                    .padding([.leading, .trailing], 15)
                    .padding(.top, 12)
                } else {
                    // Loading view
                    Text("Loading...")
                        .font(.custom("Archivo-Regular", size: 16))
                        .foregroundColor(Color.gray)
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.fetchProduct(with: productId)
        }
        .navigationBarTitle(viewModel.product?.name ?? "Product Detail", displayMode: .inline)
        .background(Color.white)
        .navigationBarTitleDisplayMode(.inline)
        .accentColor(.yellow)
    }
}
