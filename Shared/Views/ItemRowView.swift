//
//  ItemRowView.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/10/21.
//

import SwiftUI

struct ItemRowView: View {
    var item: Item
    var body: some View {
        VStack {
            item.image
                .resizable()
                .frame(width: 100, height: 100)
            Text("\(item.brand) \(item.type)")
        }
    }
}

struct ItemRowView_Previews: PreviewProvider {
    static var previews: some View {
        ItemRowView(item: Item(id: 1, type: "top", color: "red", brand:"bow", imageName: "UserImage"))
    }
}
