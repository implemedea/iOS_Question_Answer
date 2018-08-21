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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func makeDataTaskGetCall(_ sender: Any){
        // Set up the URL request
        let todoEndpoint: String = "https://jsonplaceholder.typicode.com/todos/1"
        guard let url = URL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET on /todos/1")
                print(error!)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            // parse the result as JSON, since that's what the API provides
            do {
                guard let todo = try JSONSerialization.jsonObject(with: responseData, options: [])
                    as? [String: Any] else {
                        print("error trying to convert data to JSON")
                        return
                }
                // now we have the todo
                // let's just print it to prove we can access it
                print("The todo is: " + todo.description)
                
                // the todo object is a dictionary
                // so we just access the title using the "title" key
                // so check for a title and print it if we have one
                guard let todoTitle = todo["title"] as? String else {
                    print("Could not get todo title from JSON")
                    return
                }
                print("The title is: " + todoTitle)
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        task.resume()
    }
    
    @IBAction func makeDataTaskPostCall(_ sender: Any){
        let todosEndpoint: String = "https://jsonplaceholder.typicode.com/todos"
        guard let todosURL = URL(string: todosEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        var todosUrlRequest = URLRequest(url: todosURL)
        todosUrlRequest.httpMethod = "POST"
        let newTodo: [String: Any] = ["title": "My First todo", "completed": false, "userId": 1]
        let jsonTodo: Data
        do {
            jsonTodo = try JSONSerialization.data(withJSONObject: newTodo, options: [])
            todosUrlRequest.httpBody = jsonTodo
        } catch {
            print("Error: cannot create JSON from todo")
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: todosUrlRequest) {
            (data, response, error) in
            guard error == nil else {
                print("error calling POST on /todos/1")
                print(error!)
                return
            }
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            // parse the result as JSON, since that's what the API provides
            do {
                guard let receivedTodo = try JSONSerialization.jsonObject(with: responseData,
                                                                          options: []) as? [String: Any] else {
                                                                            print("Could not get JSON from responseData as dictionary")
                                                                            return
                }
                print("The todo is: " + receivedTodo.description)
                
                guard let todoID = receivedTodo["id"] as? Int else {
                    print("Could not get todoID as int from JSON")
                    return
                }
                print("The ID is: \(todoID)")
            } catch  {
                print("error parsing response from POST on /todos")
                return
            }
        }
        task.resume()
    }
    
    @IBAction func makeDataTaskDeleteCall(_ sender: Any){
        let firstTodoEndpoint: String = "https://jsonplaceholder.typicode.com/todos/1"
        var firstTodoUrlRequest = URLRequest(url: URL(string: firstTodoEndpoint)!)
        firstTodoUrlRequest.httpMethod = "DELETE"
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: firstTodoUrlRequest) {
            (data, response, error) in
            guard let _ = data else {
                print("error calling DELETE on /todos/1")
                return
            }
            print("DELETE ok")
        }
        task.resume()
    }
    
    
    
    
    
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
