import SwiftUI

@main
struct UniShop_iOSApp: App {
    @StateObject var networkManager = NetworkManager()
    
    var body: some Scene {
        WindowGroup {
            ExploreView()
                .environmentObject(networkManager) // Configurar como objeto ambiental
        }
    }
}
