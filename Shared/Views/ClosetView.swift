//
//  ClosetView.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/9/21.
//

import SwiftUI

struct ClosetView: View {
    var items: [Item]
    var columns: [GridItem] =
             Array(repeating: .init(.flexible()), count: 3)
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(items) {item in
                        ItemRowView(item: item)
                    }
                }
            }
            Spacer()
            MenuView()
        }
        .padding()
    }
}

struct ClosetView_Previews: PreviewProvider {
    static var previews: some View {
        ClosetView(items:[Item(id: 1, type: "top", color: "red", brand:"bow", imageName: "UserImage"), Item(id: 2, type: "top", color: "red", brand:"bow", imageName: "UserImage"), Item(id: 3, type: "top", color: "red", brand:"bow", imageName: "UserImage"),Item(id: 4, type: "top", color: "red", brand:"bow", imageName: "UserImage")])
    }
}
