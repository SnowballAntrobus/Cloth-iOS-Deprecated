//
//  MenuView.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/8/21.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        HStack {
            Spacer()
            Text("CLO")
                .background(Rectangle().stroke()
                    .frame(width: 50, height: 50))
            Spacer()
            Circle()
                .stroke()
                .frame(width: 50, height: 50)
            Spacer()
            Text("ACC")
                .background(Rectangle().stroke()
                    .frame(width: 50, height: 50))
            Spacer()
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
