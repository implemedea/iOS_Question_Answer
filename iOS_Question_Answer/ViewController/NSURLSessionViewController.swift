//
//  NSURLSessionViewController.swift
//  iOS_Question_Answer
//
//  Created by Sebastin on 8/16/18.
//  Copyright © 2018 Sebastin. All rights reserved.
//

import UIKit

class NSURLSessionViewController: UIViewController {
    
//    let sampleUploadUrl:String = ""
//    let demo_url:String = ""
//    let image_download_url:String = ""
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//
//    func dataTask(){
//
//        NSURLSession *session = [NSURLSession sharedSession];
//        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:@"https://itunes.apple.com/search?term=apple&media=software"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//            NSLog(@"%@", json);
//            }];
//
//        [dataTask resume];
//
//
//
//
//
//        let _url = NSURL(string: demo_url)
//
//        let dataTask : URLSessionDataTask = session.dataTaskWithURL(_url!, completionHandler: {(data, reponse, error) in
//            if(error != nil){
//                print(error!.localizedDescription)
//            }else{
//                do{
//                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
//                    print(json)
//                } catch {
//                    // handle error
//                }
//            }
//        })
//
//        dataTask.resume()
//    }
//
//    func downloadTask() {
//
////        self.imageView.image = nil;
////        self.pb.hidden = false
////        self.pb.progress = 0
//
//        let _url = NSURL(string: image_download_url)
//
//        let configuration = URLSessionConfiguration.defaultSessionConfiguration
//        let manqueue = OperationQueue.main
//        session = NSURLSession(configuration: configuration, delegate:self, delegateQueue: manqueue)
//        dataTask = session.dataTaskWithRequest(NSURLRequest(URL: _url!))
//
//        dataTask().resume()
//
//    }
//
//    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveResponse response: NSURLResponse, completionHandler: (NSURLSessionResponseDisposition) -> Void) {
//        print("Description \(response.description)")
//        completionHandler(NSURLSessionResponseDisposition.BecomeDownload)
//    }
//
//    func URLSession(session: URLSession, downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64)
//    {
//        let progress : Double = Double(totalBytesWritten) / Double(totalBytesExpectedToWrite)
//        //print(progress)
//        dispatch_async(dispatch_get_main_queue()) {
//            self.pb.progress = Float(progress)
//        }
//    }
//
//    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64){
//    }
//
//    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didBecomeDownloadTask downloadTask: NSURLSessionDownloadTask) {
//        downloadTask.resume()
//    }
//
//    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
//        print("Local save Location : \(location)");
//        print("Download Description \(downloadTask.response!.description)")
//        do{
//            let data : NSData = try NSData(contentsOfURL: location, options: NSDataReadingOptions())
//            dispatch_async(dispatch_get_main_queue()) {
//                self.imageView.image = UIImage(data : data);
//                self.pb.hidden = true
//                self.imageView.hidden = false
//            }
//        }catch{
//        }
//    }
//
//    func uploadTask(){
//        let url:NSURL = NSURL(string: sampleUploadUrl)!
//        let session = URLSession.sharedSession()
//
//        let request = NSMutableURLRequest(url: url as URL)
//        request.httpMethod = "POST"
//        request.cachePolicy = NSURLRequest.CachePolicy.ReloadIgnoringCacheData
//
//        let data = sampleData.dataUsingEncoding(NSUTF8StringEncoding)
//
//        let task = session.uploadTaskWithRequest(request, fromData: data, completionHandler:
//        {(data,response,error) in
//
//            guard let _:NSData = data, let _:NSURLResponse = response, error == nil else {
//                print("error")
//                return
//            }
//
//            let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
//            print(dataString)
//        }
//        );
//
//        task.resume()
//    }

}
