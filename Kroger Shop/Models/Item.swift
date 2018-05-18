//
//  Item.swift
//  Kroger Shop
//
//  Created by Laurence Wingo on 5/13/18.
//  Copyright © 2018 Cosmic Arrows, LLC. All rights reserved.
//

//import Foundation to use UserDefaults, PropertyLIstEncoder, and PropertyListDecoder
import Foundation
import UIKit

//conform to the Codable protocol to allow our item to be encoded and decoded to be stored in UserDefaults.UserDefaults
class Item: Codable {
    var name: String
    var isChecked: Bool
    
    init(name: String, isChecked: Bool = false) {
        self.name = name
        self.isChecked = isChecked
    }
    
    static func fake(_ count: Int) -> [Item] {
        var items = [Item]()
        for i in 0...count {
            let item = Item(name: "Item \(i)", isChecked: i % 2 == 0)
            items.append(item)
        }
        return items
    }
    
    func toggleCheck() -> Item {
        let item = Item.init(name: name, isChecked: !isChecked)
        return item //!isChecked means false, so its not checked
    }
}

//add an extenstion to Array class to add a save method and a class level load method to save and load items from UserDefaults
extension Array where Element == Item {
    
    func save() {
        let data = try? PropertyListEncoder().encode(self)
        UserDefaults.standard.set(data, forKey: String(describing: Element.self))
        UserDefaults.standard.synchronize()
    }
    
    static func load() -> [Element] {
        if let data = UserDefaults.standard.value(forKey: String(describing: Element.self)) as? Data, let items = try? PropertyListDecoder().decode([Element].self, from: data) {
            return items
        }
        return []
    }
}
