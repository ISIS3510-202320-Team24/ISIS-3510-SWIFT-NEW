//
//  PostsView.swift
//  UniShop-iOS
//
//  Created by Alejandro Gonzalez on 2/10/23.
//

import SwiftUI

struct PostsView: View {
    var body: some View {
        Text("POSTS!")
            .gesture(DragGesture().onChanged { _ in })
    }
        
}

#Preview {
    PostsView()
}
