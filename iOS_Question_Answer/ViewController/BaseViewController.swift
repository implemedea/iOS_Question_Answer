
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
    case PopOverViewController = 5
    case KVC_KVO = 6
    case NSURLSession = 7
    case CoreData = 8
    case Constraint = 9
    case Biometric = 10
    
}

class BaseViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    let aryContentList:Array = ["Swift concept", "NSOperation, Dispatch queue and Dispatch group", "Device rotation specfic view controller", "Local Notification", "Common Function", "Pop over view controller", "KVC & KVO", "NSURLSession", "CoreData", "Constraint types", "Biometric"]
    
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
        }else if(indexPath.row == ViewController.PopOverViewController.rawValue){
            childViewController = storyBoardMain.instantiateViewController(withIdentifier: "iPadViewController")
        }else if(indexPath.row == ViewController.KVC_KVO.rawValue){
            childViewController = storyBoardMain.instantiateViewController(withIdentifier: "iPadViewController")
        }else if(indexPath.row == ViewController.NSURLSession.rawValue){
            childViewController = storyBoardMain.instantiateViewController(withIdentifier: "NSURLSessionViewController")
        }else if(indexPath.row == ViewController.Constraint.rawValue){
            childViewController = storyBoardMain.instantiateViewController(withIdentifier: "ConstraintListViewController")
        }else if(indexPath.row == ViewController.Biometric.rawValue){
            let masterViewController = storyBoardMain.instantiateViewController(withIdentifier: "MasterViewController") as! MasterViewController
            
            if let delegate = UIApplication.shared.delegate as? AppDelegate {
                masterViewController.managedObjectContext = delegate.persistentContainer.viewContext
            }
            prepareNavigationBarAppearance()
            UINavigationBar.appearance().barStyle = .blackOpaque
            self.navigationController?.pushViewController(masterViewController, animated: true)
            return
        }
        
        guard (childViewController != nil) else {
            return
        }
        self.navigationController?.pushViewController(childViewController!, animated: true)
        
    }
    
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    //MARK:- user defined function
    
    func prepareNavigationBarAppearance() {
        
        let barColor = UIColor(red: 43.0 / 255.0, green: 43.0 / 255.0, blue: 43.0 / 255.0, alpha: 1.0)
        
        UINavigationBar.appearance().barTintColor = barColor
        UINavigationBar.appearance().tintColor = .white
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        let regularVertical = UITraitCollection(verticalSizeClass: .regular)
        let titleDict: [NSAttributedStringKey: Any] = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance(for: regularVertical).titleTextAttributes = titleDict
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UIToolbar.appearance().barTintColor = barColor
        UIToolbar.appearance().tintColor = .white
    }
    

}
