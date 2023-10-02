//
//  TabBarView.swift
//  UniShop-iOS
//
//  Created by Alejandro Gonzalez on 2/10/23.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        VStack {
            switch selectedTab {
            case 0:
                HomeView()
            case 1:
                HomeView()
            case 2:
                HomeView()
            case 3:
                HomeView()
            case 4:
                HomeView()
            default:
                Text("Invalid selection")
            }
            
            NavbarView { index in
                selectedTab = index
            }
        }
    }
}
