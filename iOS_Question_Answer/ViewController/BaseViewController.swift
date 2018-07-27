
//
//  BaseViewController.swift
//  iOS_Question_Answer
//
//  Created by Sebastin on 7/6/18.
//  Copyright © 2018 Sebastin. All rights reserved.
//

import UIKit

enum ViewController:Int{
    case BaseSwift = 0
    case NSOperation = 1
    case DeviceRotation = 2
    case LocalNotification = 3
    case CommonFunction = 4
}

class BaseViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let aryContentList:Array = ["Swift concept", "NSOperation, Dispatch queue and Dispatch group", "Device rotation specfic view controller", "Local Notification", "Common Function"]
    let storyBoardMain:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
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
        return aryContentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId:String = "BaseCellId"
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellId)!
        cell.textLabel?.text = aryContentList[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var childViewController:UIViewController? = nil
        if(indexPath.row == ViewController.BaseSwift.rawValue){
            childViewController = storyBoardMain.instantiateViewController(withIdentifier: "BasicSwiftViewController") as? BasicSwiftViewController
        }else if(indexPath.row == ViewController.NSOperation.rawValue){
            childViewController = storyBoardMain.instantiateViewController(withIdentifier: "NSOperationAndDispatchQueueViewController")
            
        }else if(indexPath.row == ViewController.DeviceRotation.rawValue){
            childViewController = storyBoardMain.instantiateViewController(withIdentifier: "DeviceRotationViewController")
            AppUtility.lockOrientation(.landscape, andRotateTo: .landscapeLeft)
        }else if(indexPath.row == ViewController.LocalNotification.rawValue){
            childViewController = storyBoardMain.instantiateViewController(withIdentifier: "LocalNotificationViewController")
        }else if(indexPath.row == ViewController.CommonFunction.rawValue){
            childViewController = storyBoardMain.instantiateViewController(withIdentifier: "CommonFunctionViewController")
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
