import SwiftUI

@main
struct UniShop_iOSApp: App {
    @StateObject var networkManager = NetworkManager()

    var body: some Scene {
        WindowGroup {
            
            if let userID = UserDefaults.standard.string(forKey: "userID") {
                ContentView()
            } else {
                ExploreView()
                    .environmentObject(networkManager)
            }
        }
    }
}
