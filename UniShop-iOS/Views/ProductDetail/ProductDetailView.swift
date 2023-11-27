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
    var productId: String
    var owner: Bool
    @State private var isContactSellerPresented = false
    @ObservedObject var viewModel: ProductDetailViewModel
    @ObservedObject var controller: PostsController
    @ObservedObject var favController: FavoritesController
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    init(productId: String, owner: Bool = false) {
        self.productId = productId
        self.owner = owner
        self.viewModel = ProductDetailViewModel()
        self.controller = PostsController();
        self.favController = FavoritesController();
        
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
                    infoRow(title: "Category:", value: product.category)
                    infoRow(title: "Sold by:", value: product.user.name + " - @" + product.user.username)
                    infoRow(title: "Sold:", value: product.sold ? "Yes" : "No")
           
                    

                    VStack {
                        if (self.owner || (self.viewModel.product?.user.username == UserDefaults.standard.string(forKey: "username") && self.viewModel.product?.user.name == UserDefaults.standard.string(forKey: "userName"))) {
                            Button(action: {
                                controller.deletePostById(id: self.productId) { success in
                                    if success {
                                        DispatchQueue.main.async {
                                            viewModel.product = nil
                                            self.presentationMode.wrappedValue.dismiss()
                                        }
                                    }
                                }
                            }) {
                                Text("Delete")
                                    .font(.custom("Archivo-Regular", size: 16))
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color(red: 1, green: 0, blue: 0))
                                    .cornerRadius(8)
                            }
                            .padding([.leading, .trailing], 15)
                            .padding(.top, 12)
                            .padding(.bottom, 35)
                        } else {
                            Button(action: {
                                favController.addFavoritePostById(post_id: self.productId, user_id: UserDefaults.standard.string(forKey: "userID") ?? "") { success in
                                    if success {}
                                }
                            }) {
                                Text("Add to favorites")
                                    .font(.custom("Archivo-Regular", size: 16))
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.cyan)
                                    .cornerRadius(8)
                            }
                            .padding([.leading, .trailing], 15)
                            .padding(.top, 25)
                            
                            Button(action: {
                                isContactSellerPresented.toggle() // Toggle the contact seller view presentation
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
                            .padding(.top, 5)
                            .padding(.bottom, 35)
                            .sheet(isPresented: $isContactSellerPresented) {
                                ContactSellerView(sellerName: product.user.name, phoneNumber:product.user.phone)
                            }

                        }
                    }
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
