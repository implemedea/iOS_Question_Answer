//
//  RectPopOverViewController.swift
//  iOS_Question_Answer
//
//  Created by Sebastin on 8/1/18.
//  Copyright © 2018 Sebastin. All rights reserved.
//

import UIKit

class RectPopOverViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tblViewRect: UITableView!
    var aryContentList = ["1","2","3","4","5","6","7","8","9","10"]
    var progress:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.reloadTable),
            name: Notification.Name("KVO"),
            object: nil)
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
    
    //MARK:- user defined function
    
    @objc func reloadTable(not: Notification){
        let sender = not.object
        guard let student = sender as? Student else{
            return
        }
        self.progress = student.progress
        
        if let index = student.updateIndex{
            if(self.aryContentList.count > index){
                self.aryContentList[index] = "Updated value = " + String(describing:student.progress)
            }
            let indexPath = IndexPath(row: student.updateIndex!, section: 0)
            self.tblViewRect.reloadRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.none)
        }
    }

   
}
