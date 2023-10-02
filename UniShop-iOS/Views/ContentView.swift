import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack {
            VStack {
                switch selectedTab {
                case 0:
                    HomeView()
                case 1:
                    PostsView()
                case 2:
                    NewPostView()
                case 3:
                    FavoritesView()
                case 4:
                    ProfileView()
                default:
                    HomeView()
                }
                Spacer()
            }
            NavbarView { index in
                selectedTab = index
            }
            .position(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height - 105) 
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
