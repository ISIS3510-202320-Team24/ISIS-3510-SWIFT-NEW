import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = ProductCardViewModel()
    var categories = ["All Products", "Recommended", "Bargains"]
    @State private var searchText: String = ""
    @State private var scrollOffset: CGFloat = 0
    @State private var selectedCategory: String = "All Products"
    private var navigationBarHeight: CGFloat {
        return UINavigationBar.appearance().frame.height
    }
    @ObservedObject var hViewModel = HomeViewModel()
    @State private var showAlert = false
    
    var lastAlertDescription: String {
        guard let lastAlert = hViewModel.alerts.last else { return "" }
        return """
                User: \(lastAlert.user.name) (\(lastAlert.user.username))
                Latitude: \(lastAlert.latitude)
                Longitude: \(lastAlert.longitude)
            """
    }
    
    var filteredProducts: [Product] {
        if searchText.isEmpty {
            return viewModel.products
        } else {
            return viewModel.products.filter { product in
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
                
                if viewModel.isLoading {
                    ZStack {
                        Color.black.opacity(0.01)
                            .ignoresSafeArea()
                        
                        VStack(spacing: 20) {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .yellow))
                                .scaleEffect(2.0, anchor: .center)
                                .padding(.bottom, 15)

                            Text(viewModel.loadingMessage)
                                .foregroundColor(.black)
                                .font(.system(size: 18))
                        }
                        .padding(.top, 125)
                    }
                }
                
                VStack {
                    TextField("Search Products", text: $searchText)
                        .padding()
                        .background(Color(red: 0.941, green: 0.941, blue: 0.941))
                        .cornerRadius(10)
                        .padding([.leading, .trailing], 13)
                        .padding(.top, 10)
                    
                    HStack {
                        Text(selectedCategory)
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(Color(red: 0.067, green: 0.075, blue: 0.082))
                            .padding([.leading, .trailing], 15)
                            .padding(.top, 10)
                        
                        Spacer()
                    }
                    
                    VStack {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(categories, id: \.self) { category in
                                    DropdownView(labelText: category, selectedCategory: $selectedCategory)
                                }
                            }
                        }
                        .padding([.leading, .trailing], 13)
                    }
                    .onChange(of: selectedCategory) { newValue in
                        if newValue == "Recommended" {
                            viewModel.fetchRecommendedProducts()
                        } else if (newValue == "Bargains") {
                            viewModel.fetchBargainProducts()
                        } else {
                            viewModel.fetchProducts()
                        }
                    }

                }
                .padding(.top, scrollOffset > 0 ? 0 : -scrollOffset)
                .padding(.bottom, 10 + navigationBarHeight)
                .background(Color.white)
                .offset(y: scrollOffset > 0 ? -scrollOffset : 0)
            }
            .alert(isPresented: $hViewModel.showAlert) {
                if let lastAlert = hViewModel.alerts.last {
                    print("Show Alert: true")
                    return SwiftUI.Alert(
                        title: Text("Someone Needs Help!"),
                        message: Text(lastAlertDescription),
                        dismissButton: .default(Text("OK")) {
                            hViewModel.showAlert = false
                        }
                    )
                } else {
                    print("Show Alert: false")
                    return SwiftUI.Alert(
                        title: Text(""),
                        message: Text("")
                    )
                }
            }

            .background(Color.clear)
            .onAppear {
                viewModel.fetchProducts()
                hViewModel.fetchAlerts()
                
                if !hViewModel.alerts.isEmpty {
                    showAlert = true
                    print("ShowAlert set to true")
                }
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
    @Binding var selectedCategory: String
    
    var body: some View {
        Button(action: {
            selectedCategory = labelText
        }) {
            HStack {
                Text(labelText.capitalized)
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                Spacer()
                
                if (labelText == "Recommended") {
                    Image(systemName: "star")
                } else if (labelText == "Bargains") {
                    Image(systemName: "dollarsign.circle")
                }
            }
            .padding()
            .background(selectedCategory == labelText ? Color.yellow : Color(red: 0.933, green: 0.933, blue: 0.933))
            .cornerRadius(6)
        }
        .buttonStyle(PlainButtonStyle())
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
