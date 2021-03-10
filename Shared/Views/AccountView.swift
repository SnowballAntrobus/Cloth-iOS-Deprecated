//
//  AccountView.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/9/21.
//

import SwiftUI

struct AccountView: View {
    var user: User
    var body: some View {
        VStack {
            HStack {
                user.image
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding(.leading, 50.0)
                Spacer()
                Text(user.name)
                    .padding(.trailing, 50.0)
            }
            .padding(.top, 50)
            HStack {
                Text("Stats:")
            }
            .padding(.top, 50)
            Spacer()
            MenuView()
        }
        .padding()
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(user: User(id: 1, name:"Dante Gil-Marin", items: [], imageName: "UserImage"))
    }
}
