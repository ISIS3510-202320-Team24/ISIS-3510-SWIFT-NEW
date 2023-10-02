import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = ProductCardViewModel()
    var categories = ["Recommended", "Category", "Subjects", "Genre", "Favorites"]
    @State private var searchText: String = ""
    @State private var scrollOffset: CGFloat = 0
    private var navigationBarHeight: CGFloat {
        return UINavigationBar.appearance().frame.height
    }

    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                ScrollView {
                    VStack {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                            ForEach(viewModel.products, id: \.name) { product in
                                ZStack {
                                    ProductCardView(product: product)
                                }
                            }
                        }
                        .padding([.horizontal, .top], 16)
                        .padding(.top, 190)
                        .padding(.bottom, 75)
                    }
                }
                .background(GeometryReader {
                    Color.clear.preference(key: ViewOffsetKey.self,
                                           value: -$0.frame(in: .named("scroll")).minY)
                })
                VStack {
                    TextField("Search Products", text: $searchText)
                        .padding()
                        .background(Color(red: 0.941, green: 0.941, blue: 0.941))
                        .cornerRadius(10)
                        .padding([.leading, .trailing], 13)
                        .padding(.top, 10)
                    
                    HStack {
                        Text("Recently Added")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(Color(red: 0.067, green: 0.075, blue: 0.082))
                            .padding([.leading, .trailing], 15)
                            .padding(.top, 10)
                        
                        Spacer()
                    }
                    
                    VStack {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(categories, id: \.self) {
                                    category in
                                    DropdownView(labelText: category)
                                }
                            }
                        }
                        .padding([.leading, .trailing], 13)
                    }
                }
                .padding(.top, scrollOffset > 0 ? 0 : -scrollOffset)
                .padding(.bottom, 10 + navigationBarHeight)
                .background(Color.white)
                .offset(y: scrollOffset > 0 ? -scrollOffset : 0)
            }
            .background(Color.clear)
            .onAppear {
                viewModel.fetchProducts()
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
            .onPreferenceChange(ViewOffsetKey.self) {
                scrollOffset = $0
            }
            .coordinateSpace(name: "scroll")
        }
    }
}

struct DropdownView: View {
    var labelText: String
    
    var body: some View {
        HStack {
            Text(labelText)
                .font(.system(size: 16))
                .foregroundColor(.black)
            Spacer()
            
            if (labelText == "Recommended") {
                Image(systemName: "heart")
            } else {
                Image(systemName: "chevron.down")
            }
        }
        .padding()
        .background(labelText == "Recommended" ? Color(red: 1, green: 0.776, blue: 0, opacity: 0.7) : Color(red: 0.933, green: 0.933, blue: 0.933))
        .cornerRadius(6)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct ViewOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
