//
//  ViewController.swift
//  iOS_Question_Answer
//
//  Created by Sebastin on 10/05/18.
//  Copyright © 2018 Sebastin. All rights reserved.
//

import UIKit

enum topic:String{
    case tuple = "Tuple"
    case HOF_sort = "Higher order function - sort"
    case HOF_map = "Higher order function - map"
    case HOF_reduce = "Higher order function - reduce"
    case HOF_filter = "Higher order function - filter"
    case Any_AnyObject = "Any and AnyObject"
    case Attributed_String = "Attributed string"
    
}

class BasicSwiftViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let aryTopic = [topic.tuple.rawValue,topic.HOF_sort.rawValue,topic.HOF_map.rawValue,topic.HOF_reduce.rawValue,topic.HOF_filter.rawValue,topic.Any_AnyObject.rawValue,topic.Attributed_String.rawValue] as [Any]
    let storyBoardMain:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.hiderOrderFunction()
//        self.diffBetweenAnyAndAnyObject()
        
        //self.test()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
  
    //MARK:- Higher order function
    
    func hiderOrderFunction(){
       self.sortHigerOrderFunction()
        self.mapHigherOrderFunction()
        self.filterHigherOrderFunction()
        self.reduceHigherOrderFunction()
    }

    //MARK:- Higher order function - sort
    func sortHigerOrderFunction(){
        //sort
        let numbers:[Int] = [2,3,6,4,1]
        print(numbers.sorted())
        
        
        // higher order function - sorted
        let sorted = numbers.sorted { (a, b) -> Bool in
            return a > b
        }
        
        let higherSorted = numbers.sorted(by: >)
        print(sorted,higherSorted)
    }
    
    //MARK:- Higher order function - map
    func mapHigherOrderFunction(){
        //Map
        
        let numbers:[Int] = [2,3,6,4,1]
        let stringAry = numbers.map { (a) -> Int in
            return a + 3
        }
        print(stringAry)
        
        let some = numbers.map{String($0)}
        print(some)
    }
    
    //MARK:- Higher order function - filter
    func filterHigherOrderFunction(){
        //Filter
        
        let numbers:[Int] = [2,3,6,4,1]
        var stringAry = numbers.filter { (a) -> Bool in
            return a > 5
        }
        print(stringAry)
        
        stringAry = numbers.filter{$0 > 5}
        print(stringAry)
    }
    
    //MARK:- Higher order function - reduce
    func reduceHigherOrderFunction(){
        //Reduce
        
        let numbers:[Int] = [2,3,6,4,1]
        var stringAry = numbers.reduce("Combine:") { (result, a) -> String in
            return result + String(a)
        }
        print(stringAry)
        
        stringAry = numbers.reduce("Combine:"){$0 + String($1)}
        print(stringAry)
    }

    //MARK:- difference between any and anyobject
    
    func  diffBetweenAnyAndAnyObject() {
        var aryAny:[Any] = [1,2,"Hi"]
        var aryAnyObject:[AnyObject] = [1 as AnyObject,2 as AnyObject,"Hi" as AnyObject]
        
        class sampleClass{
            
        }
        
        struct sampleStruct{
            
        }
       
        aryAny.append(sampleClass())
        aryAny.append(sampleStruct())
        
        aryAnyObject.append(sampleClass())
        aryAnyObject.append(sampleStruct() as AnyObject)
        
        print(aryAny);
        print(aryAnyObject)
        
    }
    
    //MARK:- Tuple
    
    func test()->(String,Any){
        let tuple = (1,2,"Hi")
        let (age, number, name) = tuple
        let (a,_,_) = tuple
        print(age, number, name, a)
        print(tuple)
        
        var aa = ""
        aa.append("age = \(String(age))")
        aa.append("number = \(String(number))")
        aa.append("name = \(name)")
        return (aa,tuple )
    }
    
    //Label
    
    func lable(){
        
    }
    
    //MARK:- tableview delegate and datasource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aryTopic.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId:String = "BasicSwiftCellId"
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellId)!
        cell.textLabel?.text = aryTopic[indexPath.row] as? String
        if(aryTopic[indexPath.row] as! String == topic.Attributed_String.rawValue){
            cell.textLabel?.addImageWith(name: "twitter1", behindText: true)
        }
        return cell
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let childViewController = storyBoardMain.instantiateViewController(withIdentifier: "DetailBasicSwiftViewController") as? DetailBasicSwiftViewController else{
            return
        }
        
        childViewController.strTopic = (aryTopic[indexPath.row] as? String)!
        if(aryTopic[indexPath.row] as! String == topic.tuple.rawValue){
//            childViewController.imgFunction = UIImage(named: "")
//            childViewController.txtViewLog
        }else if(aryTopic[indexPath.row] as! String == topic.HOF_map.rawValue){
            
        }else if(aryTopic[indexPath.row] as! String == topic.HOF_sort.rawValue){
            
        }else if(aryTopic[indexPath.row] as! String == topic.HOF_filter.rawValue){
            
        }else if(aryTopic[indexPath.row] as! String == topic.HOF_reduce.rawValue){
            
        }else if(aryTopic[indexPath.row] as! String == topic.Any_AnyObject.rawValue){
            
        }
        
        
        self.navigationController?.pushViewController(childViewController, animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}


extension UILabel {
    
    func addImageWith(name: String, behindText: Bool) {
        
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: name)
        let attachmentString = NSAttributedString(attachment: attachment)
        
        guard let txt = self.text else {
            return
        }
        
        if behindText {
            let strLabelText = NSMutableAttributedString(string: txt)
            strLabelText.append(attachmentString)
            
            let myString = " - Example"
            let myAttribute = [ NSAttributedStringKey.foregroundColor: UIColor.blue ]
            let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)
            
            strLabelText.append(myAttrString)
            self.attributedText = strLabelText
        } else {
            let strLabelText = NSAttributedString(string: txt)
            let mutableAttachmentString = NSMutableAttributedString(attributedString: attachmentString)
            mutableAttachmentString.append(strLabelText)
            self.attributedText = mutableAttachmentString
        }
    }
    
    func removeImage() {
        let text = self.text
        self.attributedText = nil
        self.text = text
    }
}

