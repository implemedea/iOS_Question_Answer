//
//  ConstraintListViewController.swift
//  iOS_Question_Answer
//
//  Created by Sebastin on 8/31/18.
//  Copyright © 2018 Sebastin. All rights reserved.
//

import UIKit

enum ConsraintType:String{
    case ProportionalConstraint = "Distribute proportional height"
    case ProportionalHorizontalConstraint = "Distribute proportional width and height"
    
}

class ConstraintListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var aryConstraintType:[String] = []
    let storyBoardConstraint:UIStoryboard = UIStoryboard.init(name: "Constraint", bundle: nil)
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.aryConstraintType = [ConsraintType.ProportionalConstraint.rawValue, ConsraintType.ProportionalHorizontalConstraint.rawValue]
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK:- tableview delegate and datasource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aryConstraintType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId:String = "CellIdConstraintType"
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellId)!
        cell.textLabel?.text = aryConstraintType[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var childViewController:UIViewController? = nil
        
        if(aryConstraintType[indexPath.row] == ConsraintType.ProportionalConstraint.rawValue){
            childViewController = storyBoardConstraint.instantiateViewController(withIdentifier: kConstraintVertical) as? ProportionalConstraintViewController
        }else if(aryConstraintType[indexPath.row] == ConsraintType.ProportionalHorizontalConstraint.rawValue){
            childViewController = storyBoardConstraint.instantiateViewController(withIdentifier: kConstraintHorizontal) as? ProportionalHorizontalConstraintViewController
        }
        
        guard (childViewController != nil) else {
            return
        }
        self.navigationController?.pushViewController(childViewController!, animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

}
