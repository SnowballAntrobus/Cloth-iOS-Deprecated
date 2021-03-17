//
//  AccountView.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/9/21.
//

import SwiftUI

struct AccountView: View {
    @Binding var userData: UserData
    var body: some View {
        VStack {
            HStack {
                userData.image
                    .resizable()
                    .frame(width: 75, height: 75)
                    .clipShape(Circle())
                    .padding(.leading, 25.0)
                Spacer()
                Text(userData.name)
                    .padding(.trailing, 25.0)
            }
            .padding(.top, 50)
            HStack {
                Text("StatsView")
            }
            .padding(.top, 50)
        }
        .padding()
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(userData: .constant(UserData.data[0]))
    }
}
