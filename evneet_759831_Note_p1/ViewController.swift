//
//  ViewController.swift
//  evneet_759831_Note_p1
//
//  Created by MacStudent on 2019-11-07.
//  Copyright © 2019 MacStudent. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet var nav_item: UINavigationItem!
    @IBOutlet weak var textView: UITextView!
    var textString: String?
    weak var notesTable: NotesTableViewController?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        textView.text = textString ?? ""
        self.view.backgroundColor = UIColor.lightGray
        textView.backgroundColor = UIColor.lightGray
        textView.textColor = UIColor.white
        nav_item.titleView?.backgroundColor = .lightGray
        self.navigationItem.titleView?.backgroundColor = .lightGray
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        notesTable?.updateText(text: textView.text)
    }


}

