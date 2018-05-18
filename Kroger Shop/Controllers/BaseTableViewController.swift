//
//  BaseTableViewController.swift
//  Kroger Shop
//
//  Created by Laurence Wingo on 5/18/18.
//  Copyright © 2018 Cosmic Arrows, LLC. All rights reserved.
//

import Foundation
import UIKit

class BaseTableViewController: UITableViewController {
    
    func requestInput(title: String, message: String, handler: @escaping (String) -> ()){
        //this functio is of type, parameters string, string, function that uses a string to return nothing
        //so basically like call this function by inserting another function as a parameter so that it can fire from inside the function possibly??? Hmmmm....let's see
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: nil)
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction.init(title: "Add", style: .default, handler: { (_) in
            //the text that was entered as input by the user in our handler
            if let listName = alert.textFields?[0].text {
                handler(listName)
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
