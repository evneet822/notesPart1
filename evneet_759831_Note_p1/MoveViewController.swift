//
//  MoveViewController.swift
//  evneet_759831_Note_p1
//
//  Created by MacStudent on 2019-11-12.
//  Copyright © 2019 MacStudent. All rights reserved.
//

import UIKit

class MoveViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet var tableView: UITableView!
    var noteViewdelegate: NotesTableViewController?
    @IBOutlet var cancelLabel: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.lightGray
        self.tableView.backgroundColor = UIColor.lightGray
        self.cancelLabel.tintColor = .white
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FolderStructure.folderData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "")
        cell.backgroundColor = UIColor.lightGray
        cell.textLabel?.text = FolderStructure.folderData[indexPath.row].folderName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        del.method(indexPath.row)
        
        let alert = UIAlertController(title: "Move to \(FolderStructure.folderData[indexPath.row].folderName)", message: "Are you sure?", preferredStyle: .alert)
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        noAction.setValue(UIColor.brown, forKey: "titleTextColor")
        alert.addAction(noAction)
        
        alert.addAction(UIAlertAction(title: "Move", style: .default, handler: { (action) in
            self.noteViewdelegate!.moveNotes(index: indexPath.row)
                   self.presentingViewController?.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
         alert.view.tintColor = UIColor.black
        
//        noteViewdelegate!.moveNotes(index: indexPath.row)
//        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    
}
