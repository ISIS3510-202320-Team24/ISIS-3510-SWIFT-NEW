import SwiftUI

struct PostsView: View {
    @State private var searchText: String = ""
    @State private var scrollOffset: CGFloat = 0
    private var navigationBarHeight: CGFloat {
        return UINavigationBar.appearance().frame.height
    }
    @ObservedObject var controller = PostsController()
    @State private var showAlert = false
    @State private var userID: String = UserDefaults.standard.string(forKey: "userID") ?? "ID"
    
    var filteredProducts: [Product] {
        if searchText.isEmpty {
            return controller.userProducts
        } else {
            return controller.userProducts.filter { product in
                product.name.localizedCaseInsensitiveContains(searchText.replacingOccurrences(of: " ", with: ""))
            }
        }
    }

    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                ScrollView {
                    VStack {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                            ForEach(filteredProducts, id: \.name) { product in
                                ZStack {
                                    ProductCard2View(product: product, controller: self.controller)
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 150)
                        .padding(.bottom, 75)
                    }
                    
                }
                .background(GeometryReader {
                    Color.clear.preference(key: ViewOffsetKey.self,
                                           value: -$0.frame(in: .named("scroll")).minY)
                })
                
                if controller.isLoading {
                    ZStack {
                        Color.black.opacity(0.01)
                            .ignoresSafeArea()
                        
                        VStack(spacing: 20) {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .yellow))
                                .scaleEffect(2.0, anchor: .center)
                                .padding(.bottom, 15)

                            Text(controller.loadingMessage)
                                .foregroundColor(.black)
                                .font(.system(size: 18))
                        }
                        .padding(.top, 125)
                    }
                } else if filteredProducts.isEmpty {
                    Text("You have no posts currently")
                        .font(.title2)
                        .foregroundColor(.gray)
                        .padding(.top, 400)
                }
                
                VStack {
                    TextField("Search Products", text: $searchText)
                        .padding()
                        .background(Color(red: 0.941, green: 0.941, blue: 0.941))
                        .cornerRadius(10)
                        .padding([.leading, .trailing], 13)
                        .padding(.top, 10)
                    
                    HStack {
                        Text("Your Posts (\(controller.userProducts.count))")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(Color(red: 0.067, green: 0.075, blue: 0.082))
                            .padding([.leading, .trailing], 15)
                            .padding(.top, 10)
                        
                        Button(action: {
                            controller.userProducts = []
                            UserDefaults.standard.removeObject(forKey: "userPosts")
                            controller.fetchProductsByUserID(id: userID)
                            }) {
                                Image(systemName: "arrow.clockwise")
                                    .font(.system(size: 20))
                                    .foregroundColor(Color(red: 0.067, green: 0.075, blue: 0.082))
                            }
                            .padding(.top, 10)
                        
                        Spacer()
                    }
                }
                .padding(.top, scrollOffset > 0 ? 0 : -scrollOffset)
                .padding(.bottom, 10 + navigationBarHeight)
                .background(Color.white)
                .offset(y: scrollOffset > 0 ? -scrollOffset : 0)
            }
            .background(Color.clear)
            .onAppear {
                controller.fetchProductsByUserID(id: userID)
            }

            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
            .onPreferenceChange(ViewOffsetKey.self) {
                scrollOffset = $0
            }
            .coordinateSpace(name: "scroll")
        }
        NavigationLink(destination: SoldPostsView()) {
            Text("View Sold")
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding()
        }.padding(.top, -128)
    }
}


struct PostsView_Previews: PreviewProvider {
    static var previews: some View {
        PostsView()
    }
}
