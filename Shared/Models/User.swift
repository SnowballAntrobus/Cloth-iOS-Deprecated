//
//  User.swift
//  Cloth
//
//  Created by Dante Gil-Marin on 3/9/21.
//

import Foundation
import SwiftUI

class User: ObservableObject {
    private static var documentsFolder: URL {
        do {
            return try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            } catch {
                fatalError("Can't find documents directory.")
            }
        }
    private static var clothItemsURL: URL { return documentsFolder.appendingPathComponent("clothItems.data") }
    private static var clothFitsURL: URL { return documentsFolder.appendingPathComponent("clothFits.data") }
    //private static var userDataURL: URL { return documentsFolder.appendingPathComponent("userData.data") }
    
    @Published var userData: UserData = UserData.data[0]
    @Published var clothItems: [ClothItem] = []
    @Published var clothFits: [ClothFit] = []
    
    func load() {
            DispatchQueue.global(qos: .background).async { [weak self] in
                guard let data = try? Data(contentsOf: Self.clothItemsURL) else {
                    #if DEBUG
                    DispatchQueue.main.async {
                        self?.clothItems = ClothItem.data
                    }
                    #endif
                    return
                }
                guard let clothItems = try? JSONDecoder().decode([ClothItem].self, from: data) else {
                    fatalError("Can't decode saved cloth item data.")
                }
                DispatchQueue.main.async {
                    self?.clothItems = clothItems
                }
            }
        
            DispatchQueue.global(qos: .background).async { [weak self] in
                guard let data = try? Data(contentsOf: Self.clothFitsURL) else {
                    #if DEBUG
                    DispatchQueue.main.async {
                        self?.clothFits = ClothFit.data
                    }
                    #endif
                    return
                }
                guard let clothFits = try? JSONDecoder().decode([ClothFit].self, from: data) else {
                    fatalError("Can't decode saved cloth item data.")
                }
                DispatchQueue.main.async {
                    self?.clothFits = clothFits
                }
            }
    }
    
    func save() {
            DispatchQueue.global(qos: .background).async { [weak self] in
                guard let clothItems = self?.clothItems else { fatalError("Self out of scope") }
                guard let data = try? JSONEncoder().encode(clothItems) else { fatalError("Error encoding data") }
                do {
                    let outfile = Self.clothItemsURL
                    try data.write(to: outfile)
                } catch {
                    fatalError("Can't write to file")
                }
            }
        
            DispatchQueue.global(qos: .background).async { [weak self] in
                guard let clothFits = self?.clothFits else { fatalError("Self out of scope") }
                guard let data = try? JSONEncoder().encode(clothFits) else { fatalError("Error encoding data") }
                do {
                    let outfile = Self.clothFitsURL
                    try data.write(to: outfile)
                } catch {
                    fatalError("Can't write to file")
                }
            }
    }
}
