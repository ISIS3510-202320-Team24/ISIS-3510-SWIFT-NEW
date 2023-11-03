//
//  FavoritesView.swift
//  UniShop-iOS
//
//  Created by Alejandro Gonzalez on 2/10/23.
//

import SwiftUI

struct FavoritesView: View {
    var body: some View {
        Text("FAVORITES!")
        .gesture(DragGesture().onChanged { _ in })
    }
    
}

#Preview {
    FavoritesView()
}
