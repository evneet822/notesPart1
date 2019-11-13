//
//  folderTableViewController.swift
//  evneet_759831_Note_p1
//
//  Created by MacStudent on 2019-11-07.
//  Copyright © 2019 MacStudent. All rights reserved.
//

import UIKit

class folderTableViewController: UITableViewController {
    
    
//    var folders : [String]?
    var curIndx = -1
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.rightBarButtonItem?.tintColor = .white
        self.navigationItem.backBarButtonItem?.tintColor = .white
   
        
        self.view.backgroundColor = UIColor.lightGray
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return FolderStructure.folderData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard  != nil else {
//            return UITableViewCell()
//        }

       
        if let cell = tableView.dequeueReusableCell(withIdentifier: "folderName"){
        cell.textLabel?.text = FolderStructure.folderData[indexPath.row].folderName
        cell.imageView?.image = UIImage(named: "folder-icon")
        cell.detailTextLabel?.text = "\(FolderStructure.folderData[indexPath.row].notes.count)"
            cell.detailTextLabel?.textColor = UIColor.white


        // Configure the cell...

            return cell}
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let actions = UIContextualAction(style: .destructive, title: "Delete") { (action, view, _) in
            FolderStructure.folderData.remove(at: indexPath.row)
//            self.folders?.remove(at: indexPath.row)
            self.tableView.reloadData()
            self.curIndx = indexPath.row
        }


        return UISwipeActionsConfiguration(actions: [actions])
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            folders?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    func reload(){
        tableView.reloadData()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let detail = segue.destination as? NotesTableViewController{
            detail.folderDelegate = self
            
            if let tableviewCell = sender as? UITableViewCell{
                if let index = tableView.indexPath(for: tableviewCell)?.row{
                    curIndx = index
                }
            }
        }
    }


    @IBAction func newfolder(_ sender: UIBarButtonItem) {
        
        
        let alercontroller = UIAlertController(title: "New Folder", message: "Enter a name for this folder", preferredStyle: .alert)
               
              alercontroller.addTextField { (text) in
                  text.placeholder = "name"
              }
               
               
               
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        cancelAction.setValue(UIColor.brown, forKey: "titleTextColor")
        
               
               
        alercontroller.addAction(cancelAction)
        
               alercontroller.addAction(UIAlertAction(title: "Add Item", style: .default, handler: { (action) in
                   
                   
                   let name = alercontroller.textFields?.first?.text
                let f = FolderStructure(folderName: name!, notes: [])
               // FolderStructure.folderData.append(f)
//                self.tableView.reloadData()
               var isExist = false
                
                for item in FolderStructure.folderData{
                    let name = f.folderName
                    if name == item.folderName{
                        isExist = true
                        break
                    }
                }
                    if isExist{
                        let alert = UIAlertController(title: "Name Taken", message: "Please choose a different name", preferredStyle: .alert)
                        let okaction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        okaction.setValue(UIColor.brown, forKey: "titleTextColor")
                        alert.addAction(okaction)
                        self.present(alert, animated: true, completion: nil)
                        alert.view.tintColor = UIColor.black
                        
                    }
                    else{
                        FolderStructure.folderData.append(f)
                                       self.tableView.reloadData()
                    }
                
                
                   
               }))
        
        
        self.present(alercontroller, animated: true, completion: nil)
        alercontroller.view.tintColor = UIColor.black

}
    

    
}
