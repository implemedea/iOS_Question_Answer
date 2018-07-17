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
}

class NSOperationAndDispatchQueueViewController: UIViewController {
    
    @IBOutlet weak var segmentDownloadType: UISegmentedControl!
    @IBOutlet weak var imgView2: UIImageView!
    @IBOutlet weak var imgView4: UIImageView!
    @IBOutlet weak var imgView3: UIImageView!
    @IBOutlet weak var imgView1: UIImageView!
    
    let imageURLs = ["http://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg", "http://adriatic-lines.com/wp-content/uploads/2015/04/canal-of-Venice.jpg", "https://images.pexels.com/photos/462118/pexels-photo-462118.jpeg?auto=compress&cs=tinysrgb&h=350", "https://a00d4717bedc7c196a05-9990652a05993e9ce2692d2d425b2fb5.ssl.cf3.rackcdn.com/product_images/PRODUCT_FLOWERS_Birthday_Flower_Gift_image3.jpg"]
    
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
        }else{
            self.getImageUsingOperation()
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
    
}


