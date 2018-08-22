//
//  RectPopOverViewController.swift
//  iOS_Question_Answer
//
//  Created by Sebastin on 8/1/18.
//  Copyright © 2018 Sebastin. All rights reserved.
//

import UIKit

class RectPopOverViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var isRectPopOver:Bool = false
    
    @IBOutlet weak var tblViewRect: UITableView!
    var aryContentList = ["1","2","3","4","5","6","7","8","9","10"]
    var progress:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let cellId:String = "RectCellId"
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellId)!
        cell.textLabel?.text = self.aryContentList[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    @IBAction func removePopOver(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kNotificationNameNavigation), object: nil, userInfo: nil)
    }

   
}
