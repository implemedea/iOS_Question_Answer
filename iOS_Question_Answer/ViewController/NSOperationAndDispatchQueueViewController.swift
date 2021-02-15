//
//  NSOperationViewController.swift
//  iOS_Question_Answer
//
//  Created by Sebastin on 7/6/18.
//  Copyright © 2018 Sebastin. All rights reserved.
//

import UIKit

enum download:Int{
    case GCD
    case Operation
    case DispatchGroup
    case DispatchWorkItem
}

class NSOperationAndDispatchQueueViewController: UIViewController {
    
    @IBOutlet weak var segmentDownloadType: UISegmentedControl!
    @IBOutlet weak var imgView2: UIImageView!
    @IBOutlet weak var imgView4: UIImageView!
    @IBOutlet weak var imgView3: UIImageView!
    @IBOutlet weak var imgView1: UIImageView!
    
    let imageURLs = ["http://cdn1.medicalnewstoday.com/content/images/articles/271157-bananas.jpg", "https://media.mercola.com/assets/images/foodfacts/banana-nutrition-facts.jpg", "https://saltmarshrunning.com/wp-content/uploads/2014/09/bananasf.jpg", "http://www.bananeramuchachitaus.com/images/slider/banana-3.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- button action
    
    @IBAction func downloadTypeSelection(_ sender: Any) {
    }
    
    @IBAction func startDownload(_ sender: Any) {
        if(self.segmentDownloadType.selectedSegmentIndex == download.GCD.rawValue){
            self.getImageUsingGCD()
        }else if(self.segmentDownloadType.selectedSegmentIndex == download.Operation.rawValue){
            self.getImageUsingOperation()
        }else if(self.segmentDownloadType.selectedSegmentIndex == download.DispatchGroup.rawValue){
            self.dispatchGroup()
        }else if(self.segmentDownloadType.selectedSegmentIndex == download.DispatchWorkItem.rawValue){
            self.dispatchWorkItem()
        }
    }
    
    //MARK:- user defined function
    
    func getImageURL(url:String)->URL?{
        guard let url:URL = URL(string: url) else{
            return nil
        }
        return url
    }
    
    func getImageData(url:URL)->Data?{
        guard let data:Data = try? Data(contentsOf: url) else {
            return nil
        }
        return data
    }
    
    func getImageDataAsync(url:URL, returnCompletion: @escaping (AnyObject) -> ()){
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            returnCompletion(data as AnyObject)
        }
    }
    
    //MARK:- Grand Central Dispatch(GCD)
    
    /**
    * Grand Central Dispatch(GCD)
    */
    
    func getImageUsingGCD(){
        DispatchQueue.global(qos: .background).async { // Concurrent queue
            if let url1 = self.getImageURL(url: self.imageURLs[0]){
                if let data1 = self.getImageData(url: url1){
                    DispatchQueue.main.async { // Serial queue
                        self.imgView1.image = UIImage(data:data1)
                    }
                }
            }
            
            if let url2 = self.getImageURL(url: self.imageURLs[1]){
                if let data2 = self.getImageData(url: url2){
                    DispatchQueue.main.async {
                        self.imgView2.image = UIImage(data:data2)
                    }
                }
            }
            if let url3 = self.getImageURL(url: self.imageURLs[2]){
                if let data3 = self.getImageData(url: url3){
                    DispatchQueue.main.async {
                        self.imgView3.image = UIImage(data:data3)
                    }
                }
            }
            if let url4 = self.getImageURL(url: self.imageURLs[3]){
                if let data4 = self.getImageData(url: url4){
                    DispatchQueue.main.async {
                        self.imgView4.image = UIImage(data:data4)
                    }
                }
            }
        }
    }
    
    //MARK:- NSOperation
    
    /**
     * NSOperation
     */
    
    func getImageUsingOperation(){
        // create operation queue
        let queue = OperationQueue()
        
        // create operation
        let operation1 = BlockOperation{
            if let url1 = self.getImageURL(url: self.imageURLs[0]){
                if let data1 = self.getImageData(url: url1){
                    OperationQueue.main.addOperation({
                        self.imgView1.image = UIImage(data:data1)
                    })
                }
            }
        }
        let operation2 = BlockOperation{
            if let url2 = self.getImageURL(url: self.imageURLs[1]){
                if let data2 = self.getImageData(url: url2){
                    OperationQueue.main.addOperation({
                        self.imgView2.image = UIImage(data:data2)
                    })
                }
            }
        }
        let operation3 = BlockOperation{
            if let url3 = self.getImageURL(url: self.imageURLs[2]){
                if let data3 = self.getImageData(url: url3){
                    OperationQueue.main.addOperation({
                        self.imgView3.image = UIImage(data:data3)
                    })
                }
            }
        }
        let operation4 = BlockOperation{
            if let url4 = self.getImageURL(url: self.imageURLs[3]){
                if let data4 = self.getImageData(url: url4){
                    OperationQueue.main.addOperation({
                        self.imgView4.image = UIImage(data:data4)
                    })
                }
            }
        }
        
        // add dependency
        operation2.addDependency(operation1)
        operation3.addDependency(operation2)
        operation4.addDependency(operation3)
        
        // add operation to queue
        queue.addOperation(operation1)
        queue.addOperation(operation2)
        queue.addOperation(operation3)
        queue.addOperation(operation4)
        
        //operation cancel
        operation2.cancel()

        
        //operation completion block
        operation1.completionBlock = {
            print("Operation 1 completed")
        }
        operation2.completionBlock = {
            print("operation 2 completed")
        }
        operation3.completionBlock = {
            print("Operation 3 completed")
        }
        operation4.completionBlock = {
            print("Operation 4 completed")
        }
    }
    
    //MARK:- Dispatch group
    
    func dispatchGroup(){
        let dispatchGroup = DispatchGroup()
        let aryImageView = [self.imgView1,self.imgView2,self.imgView3,self.imgView4]
        for (index,url) in self.imageURLs.enumerated(){
            let url:URL = URL(string: url)!
            dispatchGroup.enter()
            self.getImageDataAsync(url: url, returnCompletion: { (data) in
                DispatchQueue.main.async(execute: {
                    let imgView = aryImageView[index]
                    if let imgData = data as? Data {
                        imgView?.image = UIImage(data: imgData)
                    }
                    dispatchGroup.leave()
                })
            })
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            print("image download completed")
        }
        print("For loop completed")
    }
    
    //MARK:- Dispatch work item
    
    func dispatchWorkItem(){
        let dispatchGroup = DispatchGroup()
        let aryImageView = [self.imgView1,self.imgView2,self.imgView3,self.imgView4]
        var blocks:[DispatchWorkItem] = []
        for (index,url) in self.imageURLs.enumerated(){
            dispatchGroup.enter()
            let block = DispatchWorkItem(qos: .background, flags: .inheritQoS, block: {
                let url:URL = URL(string: url)!
                self.getImageDataAsync(url: url, returnCompletion: { (data) in
                    DispatchQueue.main.async(execute: {
                        let imgView = aryImageView[index]
                        if let imgData = data as? Data {
                            imgView?.image = UIImage(data:imgData)
                        }
                        dispatchGroup.leave()
                    })
                })
            })
            blocks.append(block)
            DispatchQueue.main.async(execute: block)
        }
        
        let cancelBlock = blocks[0]
        cancelBlock.cancel()
        dispatchGroup.leave()
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            print("image download completed")
        }
        print("For loop completed")
    }
}


