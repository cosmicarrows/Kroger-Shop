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
        return item
    }
}

//add an extenstion to the Array type to add a save method which adds functionality to instances and a static load method to save and load all array instances of items from UserDefaults
//we're also using generic constraints to signifiy array elements that are of type ShoppingLIst
extension Array where Element == ShoppingList {
    
    func save() {
        let data = try? PropertyListEncoder().encode(self)
        //self signifiys types that are array types contained to only ShoppingList types
        UserDefaults.standard.set(data, forKey: String(describing: Element.self))
        //the key and value of the UserDefaults....hashable key is the string describing the element and the value is the encoded data object
        //UserDefaults.standard.synchronize()
        
    }
    
    static func load() -> [Element] {
        if let data = UserDefaults.standard.value(forKey: String(describing: Element.self)) as? Data,
            let elements = try? PropertyListDecoder().decode([Element].self, from: data) {
            for element in elements {
                element.onUpdate = elements.save
            }
            return elements
        }
        return []
    }
}
