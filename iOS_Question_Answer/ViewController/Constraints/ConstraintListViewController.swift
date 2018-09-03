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
    case Variation = "Font variation"
    case VaryForTraits = "Vary for traits - phone 5 and iphone 8"
}

class ConstraintListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var aryConstraintType:[String] = []
    let storyBoardConstraint:UIStoryboard = UIStoryboard.init(name: "Constraint", bundle: nil)
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.aryConstraintType = [ConsraintType.ProportionalConstraint.rawValue, ConsraintType.ProportionalHorizontalConstraint.rawValue, ConsraintType.Variation.rawValue, ConsraintType.VaryForTraits.rawValue]
       
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
            let ConstraintVC = storyBoardConstraint.instantiateViewController(withIdentifier: kConstraintVertical) as? ProportionalConstraintViewController
            ConstraintVC?.RotateDevice = false
            self.navigationController?.pushViewController(ConstraintVC!, animated: true)
            return
        }else if(aryConstraintType[indexPath.row] == ConsraintType.ProportionalHorizontalConstraint.rawValue){
            childViewController = storyBoardConstraint.instantiateViewController(withIdentifier: kConstraintHorizontal) as? ProportionalHorizontalConstraintViewController
        }else if(aryConstraintType[indexPath.row] == ConsraintType.Variation.rawValue){
           let ConstraintVC = storyBoardConstraint.instantiateViewController(withIdentifier: kConstraintVertical) as? ProportionalConstraintViewController
            ConstraintVC?.RotateDevice = true
            AppUtility.lockOrientation(.landscape, andRotateTo: .landscapeLeft)
            self.navigationController?.pushViewController(ConstraintVC!, animated: true)
            return
        }else if(aryConstraintType[indexPath.row] == ConsraintType.VaryForTraits.rawValue){
            childViewController = storyBoardConstraint.instantiateViewController(withIdentifier: kVaryForTraitsViewController) as? VaryForTraitsViewController
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
