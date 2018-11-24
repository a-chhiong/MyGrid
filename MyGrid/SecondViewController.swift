//
//  SecondViewController.swift
//  MyGrid
//
//  Created by Jose Adams on 2018/11/23.
//  Copyright © 2018 jose adams. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    /* attributes */
    
    var numberOfColumn: Int?;
    var numberOfRow: Int?;
    var randomOfColumn: Int?;
    var randomOfRow: Int?;
    var timer: Timer?;
    var timerLog: Int = 0;
    
    /* IB */
    
    @IBOutlet weak var locationOfColumn: UILabel!
    @IBOutlet weak var locationOfRow: UILabel!
    @IBOutlet weak var countdownTime: UILabel!
    @IBOutlet weak var MyCollectionView: UICollectionView!
    @IBOutlet weak var MyCollectionViewFlowLayout: UICollectionViewFlowLayout!
    
    /* life cycle*/
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        MyCollectionView.delegate = self;
        MyCollectionView.dataSource = self;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        print("SecondVC --> number of column: \(numberOfColumn)");
        print("SecondVC --> number of row: \(numberOfRow)");
        
        setupItemSize();
        
        self.locationOfColumn.text = "Column: ?";
        self.locationOfRow.text = "Row: ?";
        
        setCountdownTimer(true);
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        setCountdownTimer(false);
    }
    
    /* methods */
    
    func setCountdownTimer(_ enable: Bool)
    {
        if(enable)
        {
            if timer != nil
            {
                timer!.invalidate();
                
                timer = nil;
            }
            
            timerLog = 10;
            
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
                
                if(self.timerLog == 0)
                {
                    self.randomOfColumn = Int.random(in: 0..<self.numberOfColumn!);
                    self.randomOfRow = Int.random(in: 0..<(self.numberOfRow!-1));
                    
                    self.locationOfColumn.text = "Column: \(self.randomOfColumn!)";
                    self.locationOfRow.text = "Row: \(self.randomOfRow!)";
                    self.countdownTime.text = "Time's Up!";
                    
                    self.MyCollectionView.reloadData();
                }
                else
                {
                    self.locationOfColumn.text = "Column: ?";
                    self.locationOfRow.text = "Row: ?";
                    self.countdownTime.text = "\(self.timerLog)";
                }
                
                self.timerLog -= 1;
                
                if(self.timerLog < 0)
                {
                    self.timerLog = 10;
                }
            });
            
            timer!.fire();
        }
        else
        {
            if timer != nil
            {
                timer!.invalidate();
            }
        }
    }
    
    func setupItemSize()
    {
        MyCollectionViewFlowLayout.invalidateLayout();
        
        let parentWidth: CGFloat = MyCollectionView.frame.width;
        let parentHeight: CGFloat = MyCollectionView.frame.height;
        
        print("SecondVC --> parent width: \(parentWidth)");
        print("SecondVC --> parent height: \(parentHeight)");
        
        MyCollectionViewFlowLayout.minimumInteritemSpacing = 1.0;
        MyCollectionViewFlowLayout.sectionInset.right = 2.0;
        
        if numberOfColumn! > 0 && numberOfRow! > 0
        {
            numberOfRow! += 1;   // reserved for button
            
            let evenWidth: CGFloat = parentWidth / CGFloat(numberOfColumn!) - CGFloat(5.0);
            var evenHeight: CGFloat = parentHeight / CGFloat(numberOfRow!) - CGFloat(5.0)
            
            if numberOfRow! <= 3
            {
                evenHeight -= CGFloat(5.0);
            }
            
            print("SecondVC --> even width: \(evenWidth)");
            print("SecondVC --> even height: \(evenHeight)");
            
            MyCollectionViewFlowLayout.itemSize = CGSize(width: evenWidth, height: evenHeight)
            
            MyCollectionView.reloadData();
        }
    }
}

extension SecondViewController: UICollectionViewDelegate, UICollectionViewDataSource, buttonCellAction
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfColumn!;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return numberOfRow!;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == numberOfRow! - 1
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "buttonCell", for: indexPath) as! buttonCell;
            
            cell.MyAction = self;
            cell.MyIndexPath = indexPath;
            
            cell.MyButton.setTitle("~~~", for: UIControl.State.normal);
            cell.MyButton.isEnabled = false;
            cell.MyView.layer.borderColor = UIColor.lightGray.cgColor;
            cell.MyView.layer.borderWidth = CGFloat(0.5);
            
            if randomOfColumn != nil && randomOfRow != nil
            {
                if indexPath.section == randomOfColumn
                {
                    cell.MyButton.setTitle("CONFIRM", for: UIControl.State.normal);
                    cell.MyButton.isEnabled = true;
                    cell.MyView.layer.borderColor = UIColor.red.cgColor;
                    cell.MyView.layer.borderWidth = CGFloat(0.5);
                }
            }
            
            return cell;
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "labelCell", for: indexPath) as! labelCell;
            
            cell.MyLabel.text = "..."
            cell.MyView.layer.borderColor = UIColor.lightGray.cgColor;
            cell.MyView.layer.borderWidth = CGFloat(0.5);
            
            if randomOfColumn != nil && randomOfRow != nil
            {
                if indexPath.section == randomOfColumn
                {
                    cell.MyView.layer.borderColor = UIColor.red.cgColor;
                    cell.MyView.layer.borderWidth = CGFloat(0.5);
                    
                    if indexPath.row == randomOfRow
                    {
                        cell.MyLabel.text = "RANDOM"
                    }
                }
            }
            
            return cell;
        }
    }
    
    func buttonDidClick(at indexpath: IndexPath?) {
        
        print("SecondVC: click button at section: \(indexpath!.section)");
        
        print("SecondVC: random button at column: \(randomOfColumn)");
        
        if indexpath!.section == randomOfColumn
        {
            timerLog = 10;
            
            randomOfColumn = nil;
            randomOfRow = nil;
            
            MyCollectionView.reloadData();
        }
    }
}
