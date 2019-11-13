//
//  NotesTableViewController.swift
//  evneet_759831_Note_p1
//
//  Created by MacStudent on 2019-11-11.
//  Copyright © 2019 MacStudent. All rights reserved.
//

import UIKit

class NotesTableViewController: UITableViewController {
    
    @IBOutlet var editButton: UIBarButtonItem!
    @IBOutlet var moveButton: UIBarButtonItem!
    @IBOutlet var deleteButton: UIBarButtonItem!
    @IBOutlet var notestable: UITableView!
    
    var currentIndex = -1
    var folderDelegate: folderTableViewController?
    var isVisible = false
    var selectedRows: [IndexPath]?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationController?.navigationBar.prefersLargeTitles = true
        moveButton.isEnabled = false
        deleteButton.isEnabled = false
        tableView.allowsMultipleSelection = true

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return  FolderStructure.folderData[(folderDelegate?.curIndx)!].notes.count
//        return notes?.count ?? 0
    }

        
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let note = notes?[indexPath.row]
       
        let note1 = FolderStructure.folderData[(folderDelegate?.curIndx)!].notes[indexPath.row]
       
        if let cell = tableView.dequeueReusableCell(withIdentifier: "notesCell"){
             
            cell.textLabel?.text = note1
            return cell
        }

        // Configure the cell...

        return UITableViewCell()
    }
    

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        
       
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .detailButton
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
            
            if let detail = segue.destination as? ViewController{
                
                detail.notesTable = self
                
                if let tableViewCell = sender as? UITableViewCell{
                    if let index = tableView.indexPath(for: tableViewCell)?.row{

                        detail.textString = FolderStructure.folderData[(folderDelegate?.curIndx)!].notes[index]
                        currentIndex = index
                    }
                }
            }
        if let move = segue.destination as? MoveViewController{
            move.noteViewdelegate = self}
            
            
        }
    
    func updateText(text : String){
           
            
                      
            guard FolderStructure.folderData[(folderDelegate?.curIndx)!].notes != [] && currentIndex != -1 else {
                FolderStructure.folderData[(folderDelegate?.curIndx)!].notes.append(text)
                tableView.reloadData()
                folderDelegate?.reload()
                return
            }
    
    
            FolderStructure.folderData[(folderDelegate?.curIndx)!].notes[currentIndex] = text
    
            let indexPath = IndexPath(item: currentIndex, section: 0)
            tableView.reloadRows(at: [indexPath], with: .middle)
            currentIndex = -1
    
      }
    
    
    
    @IBAction func edit(_ sender: UIBarButtonItem) {
        
        if !isVisible{
            moveButton.isEnabled = true
            deleteButton.isEnabled = true
            isVisible = true
        }else{
        
        moveButton.isEnabled = false
        deleteButton.isEnabled = false
            isVisible = false
        }
    }
    
    
    
    @IBAction func deleteAction(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Delete", message: "Are you sure", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancel)
        alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { (action) in
            self.deleteRows()
        }))
        self.present(alert, animated: true, completion: nil)
        
        
    }
//    func moveNotes(indexpath.row){
//        // move [1,2,3]
//        for i in selectedRows{
//
//            let notetomove = FolderStructure.folderData[(folderDelegate?.curIndx)!].notes[i.row]
//            FolderStructure.folderData[indexpath.row].notes.append(notetomove)
//
//        }
//
//
//        deleteRows()
//
//    }
    
    func moveNotes(index: Int){
        selectedRows = tableView.indexPathsForSelectedRows!
        for i in selectedRows!{
            let noteToMove = FolderStructure.folderData[(folderDelegate?.curIndx)!].notes[i.row]
            FolderStructure.folderData[index].notes.append(noteToMove)
            
        }
        
        deleteRows()
        
        
    }
    
    func deleteRows(){
        
         selectedRows = tableView.indexPathsForSelectedRows!
            var items = [String]()
            
            for indexpath in selectedRows!{
                items.append(FolderStructure.folderData[(folderDelegate?.curIndx)!].notes[indexpath.row])
            }
            
            for item in items{
                if let indexx = FolderStructure.folderData[(folderDelegate?.curIndx)!].notes.firstIndex(of: item){
                    FolderStructure.folderData[(folderDelegate?.curIndx)!].notes.remove(at: indexx)
                    
                }
                
            }
            
            tableView.beginUpdates()
            tableView.deleteRows(at: selectedRows!, with: .automatic)
            tableView.endUpdates()
            
        folderDelegate?.tableView.reloadData()
        
            
        }
        
    
    
    
}

