//
//  ViewController.swift
//  evneet_759831_Note_p1
//
//  Created by MacStudent on 2019-11-07.
//  Copyright © 2019 MacStudent. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var textView: UITextView!
    var textString: String?
    weak var notesTable: NotesTableViewController?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        textView.text = textString ?? ""
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        notesTable?.updateText(text: textView.text)
    }


}

