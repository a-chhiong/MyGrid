//
//  buttonCell.swift
//  MyGrid
//
//  Created by Jose Adams on 2018/11/24.
//  Copyright © 2018 jose adams. All rights reserved.
//

import UIKit

class buttonCell: UICollectionViewCell {
    
    var MyAction: buttonCellAction?;
    var MyIndexPath: IndexPath?;
    
    @IBOutlet weak var MyButton: UIButton!
    @IBOutlet weak var MyView: UIView!
    @IBAction func MyButton(_ sender: UIButton)
    {
        MyAction!.buttonDidClick(at: MyIndexPath);
    }
}

protocol buttonCellAction {
    
    func buttonDidClick(at indexpath: IndexPath?);
    
}
