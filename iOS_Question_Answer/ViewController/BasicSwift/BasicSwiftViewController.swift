//
//  ViewController.swift
//  iOS_Question_Answer
//
//  Created by Sebastin on 10/05/18.
//  Copyright © 2018 Sebastin. All rights reserved.
//

import UIKit

enum topic:String{
    case ifLet = "ifLet"
    case guardLet = "guardLet"
    case LazyProperty = "LazyProperty"
    case tuple = "Tuple"
    case HOF_sort = "Higher order function - sort"
    case HOF_map = "Higher order function - map"
    case HOF_reduce = "Higher order function - reduce"
    case HOF_filter = "Higher order function - filter"
    case Any_AnyObject = "Any and AnyObject"
    case Attributed_String = "Attributed string"
    case TrailingClosure = "Trailing Closure"
    case AutoClosure = "Auto Closure"
    case EscapeClosure = "Escaping Closure"
    case KVC = "KVC"
    case CompileTimePolymorphism = "Compile Time Polymorphism"
    case RunTimePolymorphism = "Run Time Polymorphism"
    case OperatorOverloading = "Operator overloading"
    
}

class BasicSwiftViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    lazy var someVariable:String = { [unowned self] in
        return "I am an iOS developer"
    }()
    
    
    let aryTopic = [topic.ifLet.rawValue,
                    topic.guardLet.rawValue,
                    topic.LazyProperty.rawValue,
                    topic.tuple.rawValue,
                    topic.HOF_sort.rawValue,
                    topic.HOF_map.rawValue,
                    topic.HOF_reduce.rawValue,
                    topic.HOF_filter.rawValue,
                    topic.Any_AnyObject.rawValue,
                    topic.Attributed_String.rawValue,
                    topic.TrailingClosure.rawValue,
                    topic.AutoClosure.rawValue,
                    topic.EscapeClosure.rawValue,
                    topic.KVC.rawValue,
                    topic.CompileTimePolymorphism.rawValue,
                    topic.RunTimePolymorphism.rawValue,
                    topic.OperatorOverloading.rawValue] as [Any]
   
    let storyBoardMain:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK:- If let
    
    func ifLet() {
        var name:String? = "some name"
        name = nil
       
        if let constantName = name {
            print(constantName)
        } else {
           print("value is nil")
        }
    }
    
    //MARK:- Guard let
    
    func guardLet() {
        var name:String? = "some name"
        name = nil
        
        guard let constantName = name else {
            return
        }
        print(constantName)
    }
    
    //MARK:- lazy property
    
    struct lazyVariable {
        lazy var someVariable: String = {
            return "I am an iOS developer"
        }()
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
    
    func tuple(){
        let tuple = (1,2,"Hi")
        let (age, number, name) = tuple
        let (a,_,_) = tuple
        print(age, number, name, a)
        print(tuple)
    }
    
    //MARK:- KVC
    
    func kvc(){
        let objStudent = Student()
        objStudent.setValue(1, forKey: "progress")
        objStudent.setValue(2, forKeyPath: "self.progress")
        print(objStudent.value(forKey: "progress")!)
       
        // Key
        objStudent.objSchool?.schoolName = "test school"
        // KeyPath
        objStudent.setValue("test", forKeyPath: "self.objSchool.schoolName")
        
    }
    
    //MARK:- Compile time polymorphism or Static polymorphism or method overloading
    
    func addNums(i: Int, j: Int) -> Int
    {
        return i + j
    }
    
    func addNums(i: Int, j: Int, k: Int) -> Int
    {
        return i + j + k
    }
    
    //MARK:- Trailing closure
    
    func trailingClosureMethod(a:Int,b:Int,completion:(Int)->(Int)){
        let sum = completion(a+b)
        print(sum)
    }
    
    //MARK:- auto closure
    
    func autoClosure(completion:@autoclosure()->(String)){
        let sum = completion()
        print(sum)
    }
    
    //MARK:- escape closure
    
    func escapeClosure(url:String, completion:@escaping(Data?,Error?)->()){
         DispatchQueue.global().async {
            if let data = try? Data(contentsOf: URL(string:url)!){
                completion(data,nil)
            }else{
                let error:Error = "image not found" as! Error
                completion(nil,error)
            }
        }
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
        if(aryTopic[indexPath.row] as! String == topic.ifLet.rawValue){
            self.ifLet()
        }else if(aryTopic[indexPath.row] as! String == topic.guardLet.rawValue){
            self.guardLet()
        }else if(aryTopic[indexPath.row] as! String == topic.LazyProperty.rawValue){
            //class
            print("lazy variable in class = \(self.someVariable)")
            
            // struct
            var objLazyVariable = lazyVariable()
            print("lazy variable in struct = \(objLazyVariable.someVariable)")
        }else if(aryTopic[indexPath.row] as! String == topic.tuple.rawValue){
            self.tuple()
        }else if(aryTopic[indexPath.row] as! String == topic.HOF_map.rawValue){
            self.mapHigherOrderFunction()
        }else if(aryTopic[indexPath.row] as! String == topic.HOF_sort.rawValue){
            self.sortHigerOrderFunction()
        }else if(aryTopic[indexPath.row] as! String == topic.HOF_filter.rawValue){
            self.filterHigherOrderFunction()
        }else if(aryTopic[indexPath.row] as! String == topic.HOF_reduce.rawValue){
            self.reduceHigherOrderFunction()
        }else if(aryTopic[indexPath.row] as! String == topic.Any_AnyObject.rawValue){
            self.diffBetweenAnyAndAnyObject()
        }else if(aryTopic[indexPath.row] as! String == topic.TrailingClosure.rawValue){
            self.trailingClosureMethod(a: 1, b: 2, completion: { (sum) in
                print("trailing closure sum = \(sum)")
                return sum
            })
        }else if(aryTopic[indexPath.row] as! String == topic.AutoClosure.rawValue){
            self.autoClosure(completion: "hello world")
            
        }else if(aryTopic[indexPath.row] as! String == topic.EscapeClosure.rawValue){
            childViewController.strTopic = (aryTopic[indexPath.row] as? String)!
            self.escapeClosure(url: "http://cdn1.medicalnewstoday.com/content/images/articles/271157-bananas.jpg", completion: { (data, error) in
                if(error == nil){
                    DispatchQueue.main.async {
                        let image = UIImage(data:data!)
                        childViewController.imgViewFunction.image = image
                    }
                }else{
                    print(error!)
                }
            })
            self.navigationController?.pushViewController(childViewController, animated: true)
            
        }else if(aryTopic[indexPath.row] as! String == topic.KVC.rawValue){
            self.kvc()
        }else if(aryTopic[indexPath.row] as! String == topic.CompileTimePolymorphism.rawValue){
            print("addNums with two args = ", addNums(i: 2, j: 3))
            print("addNums with three args = ", addNums(i: 2, j: 3, k: 5))
        }else if(aryTopic[indexPath.row] as! String == topic.RunTimePolymorphism.rawValue){
            var animal: Animal
            animal = Cat()
            print(animal.makeNoise())
            
            animal = Dog()
            print(animal.makeNoise())
        }else if(aryTopic[indexPath.row] as! String == topic.OperatorOverloading.rawValue){
           print(CGSize(width: 10, height: 10)+CGSize(width: 10, height: 10))
        }
        
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

//MARK:- Run time polymorphism or Dynamic polymorphism or method overriding

class Animal
{
    func makeNoise()
    {
        print("Durrr")
    }
}

class Cat : Animal
{
    override func makeNoise()
    {
        print("Meoooowwwww")
    }
}

class Dog : Animal
{
    override func makeNoise()
    {
        print("Woooooof")
    }
}

//MARK:- operator overloading

extension CGSize{
    static func +(lhs:CGSize, rhs:CGSize)->CGSize{
        return  CGSize(width: (lhs.width + rhs.width), height: (lhs.height + rhs.width))
    }
}
