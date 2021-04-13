//
//  AccountView.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/9/21.
//

import SwiftUI
import Resolver

struct AccountView: View {
    @Binding var userDataRepo: UserDataRepository
    var body: some View {
        if userDataRepo.userData != nil {
            VStack {
                HStack {
                    userDataRepo.userData!.image
                        .resizable()
                        .frame(width: 75, height: 75)
                        .clipShape(Circle())
                        .padding(.leading, 25.0)
                    Spacer()
                    Text(userDataRepo.userData!.name)
                        .padding(.trailing, 25.0)
                }
                .padding(.top, 50)
                HStack {
                    Text("StatsView")
                }
                .padding(.top, 50)
            }
            .padding()
        } else {
            PleaseCreateAccount()
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(userDataRepo: .constant(Resolver.resolve()))
    }
}
