//
//  ViewController.swift
//  MyGrid
//
//  Created by Jose Adams on 2018/11/23.
//  Copyright © 2018 jose adams. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    /* IB */
    
    @IBOutlet weak var MyColumn: UITextField!
    @IBOutlet weak var MyRow: UITextField!
    
    /* life cycle */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillLayoutSubviews() {
        
        hideKeyboard();
    }

    /* methods */
    
    func hideKeyboard()
    {
        self.view.endEditing(true);
        
        MyColumn.resignFirstResponder();
        MyRow.resignFirstResponder();
    }
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
        
        if segue.identifier == "showGrid"
        {
            let vc = segue.destination as? SecondViewController
            
            let numberOfColumn: String = MyColumn.text ?? "1";
            
            let numberOfRow: String = MyRow.text ?? "1";
            
            vc!.numberOfColumn = Int(numberOfColumn) ?? 1;
            
            vc!.numberOfRow = Int(numberOfRow) ?? 1;
            
            print("FirstVC --> number of column: \(numberOfColumn)");
            print("FirstVC --> number of row: \(numberOfRow)");
            
            hideKeyboard();
        }
     }
    
    
    
}

