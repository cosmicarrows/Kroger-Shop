//
//  ItemsTableViewController.swift
//  Kroger Shop
//
//  Created by Laurence Wingo on 5/15/18.
//  Copyright © 2018 Cosmic Arrows, LLC. All rights reserved.
//

import UIKit

class ItemsTableViewController: BaseTableViewController {
    
    var list: ShoppingList!
    //set the items array to default to items loaded from the UserDefaults storage.  Also use DidSet to add behavior for when the array is modified.  Using this didSet will save the items to UserDefaults by calling the save method on the items array.
    var items: [Item] {
        get {
            return list.items
        }
    }
    //next update the tableView's didSelectRow method with the toggleCheck method in order to trigger the didSet method to automatically save our items
    
    @IBAction func didSelectAdd(_ sender: UIBarButtonItem) {
        requestInput(title: "New shopping list item", message: "Enter item to add to the shopping list:", handler: { (itemName) in
            let itemCount = self.items.count
            let item = Item.init(name: itemName)
            self.list.add(item)
            self.tableView.insertRows(at: [IndexPath(row: itemCount, section: 0)], with: .top)
            })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = list.name
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItems?.append(editButtonItem)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        list.swapItem(sourceIndexPath.row, destinationIndexPath.row)
        
        
        //items.insert(item, at: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            list.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        list.toggleCheckItem(atIndex: indexPath.row)
        tableView.reloadRows(at: [indexPath], with: .middle)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.name
        
        if item.isChecked {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
