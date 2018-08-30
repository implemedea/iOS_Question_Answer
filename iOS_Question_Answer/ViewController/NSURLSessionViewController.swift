//
//  NSURLSessionViewController.swift
//  iOS_Question_Answer
//
//  Created by Sebastin on 8/16/18.
//  Copyright © 2018 Sebastin. All rights reserved.
//

import UIKit

class NSURLSessionViewController: UIViewController {
    
    var awsAccessKeyId: String = kEmpty
    var awsSecretAccessKey: String = kEmpty
    var securityToken: String = kEmpty
    var aryUploadImages:[uploadImage] = []
    
    typealias CompletionHandler = () -> Void
    
    var completionHandlers = [String: CompletionHandler]()
    
    var sessions = [String: URLSession]()
    let dispatchGroup = DispatchGroup()

    @IBOutlet weak var progressDownloadTaskDelegate: UIProgressView!
    @IBOutlet weak var progressDownloadTaskCompletionHandler: UIProgressView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let aryImages = ["any&anyobject","ary_HOF_filter"]
        for (_, element) in aryImages.enumerated(){
            let objUploadImages = uploadImage()
            objUploadImages.image = UIImage(named:element)
            objUploadImages.progress = 0
            self.aryUploadImages.append(objUploadImages)
        }


        let _ = DownloadManager.shared.activate()
        
       
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DownloadManager.shared.onProgress = { (progress) in
            OperationQueue.main.addOperation {
                self.progressDownloadTaskDelegate.progress = progress
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        DownloadManager.shared.onProgress = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- DataTask - GET call

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
    
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    //MARK:- DataTask - POST call
    
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
    
    //MARK:- DataTask - DELETE call
    
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
    
    //MARK:- Download Task - Completion handler
    
    @IBAction func makeDownloadTaskWithCompletionHandler(_ sender: Any) {
        let url = URL(string: "http://www.pdf995.com/samples/pdf.pdf")!
        let task = URLSession.shared.downloadTask(with: url) { localURL, urlResponse, error in
            if let localURL = localURL {
                GlobalClass.shared.createFileFromTemp(location: localURL)
            }
        }
        task.resume()
    }
    
    //MARK:- Download Task - Delegate method
    
    @IBAction func makeDownloadTaskWithDelegate(_ sender: Any) {
        let url = URL(string: "https://scholar.princeton.edu/sites/default/files/oversize_pdf_test_0.pdf")!
        let task = DownloadManager.shared.activate().downloadTask(with: url)
        task.resume()
    }
    
    func upload(request: URLRequest, data: Data)
    {
        // Create a unique identifier for the session.
        let sessionIdentifier = NSUUID().uuidString
        
        
        let directoryURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let fileURL = directoryURL.appendingPathComponent(sessionIdentifier)
        
        // Write data to cache file.
//        data.write(to: fileURL, options: true);
        do{
            try data.write(to: fileURL, options: .atomic)
        }catch{
            
        }
        
        
//        let configuration = URLSessionConfiguration.background(withIdentifier: sessionIdentifier)
//
//        let session: URLSession = URLSession(
//            configuration:configuration,
//            delegate: self as? URLSessionDelegate,
//            delegateQueue: OperationQueue.main
//        )
        
        // Store the session, so that we don't recreate it if app resumes from suspend.
//        sessions[sessionIdentifier] = session
        
        let task = DownloadManager.shared.activate().uploadTask(with: request as URLRequest, fromFile: fileURL)
         task.resume()
        
//        let task2 = session.uploadTask(with: request, fromFile: fileURL) { (data, response, error) in
//            if let res = response{
//                print("response = ",res)
//            }
//            if let err = error{
//                print("err = ",err)
//            }
//        }
//
//        task2.resume()
        
//        let task1 = session.uploadTask(with: request as URLRequest, from: data as Data) { (data, response, error) in
//            if let res = response{
//                  print("response = ",res)
//            }
//            if let err = error{
//                print("err = ",err)
//            }
//
//        }
//        task1.resume()
        
       
    }

    func getPriceList() {
        dispatchGroup.enter()
        let params: NSDictionary = [kKeyApiKey: kApiKey, kAffId: kAffIdValue, kKeyAct: kgetPhotoProducts, kKeyPrdGrpId: kEmpty, kKeyDevInf: kDevinf, kKeyAppVer: kAppver]
        
        let url:String = kBaseURL + kPhotoURL
        
        print("getPriceList url = \(url)")
    
        let todosEndpoint: String = url
        guard let todosURL = URL(string: todosEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        var todosUrlRequest = URLRequest(url: todosURL)
        todosUrlRequest.httpMethod = "POST"
        let newTodo: [String: Any] = params as! [String : Any]
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
            print("getPriceList completed")
            self.dispatchGroup.leave()
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
                guard let json = try JSONSerialization.jsonObject(with: responseData,
                                                                          options: []) as? [String: Any] else {
                                                                            print("Could not get JSON from responseData as dictionary")
                                                                            return
                }
                
                let jsonDict:NSDictionary = json as NSDictionary
                if ((jsonDict[kProducts]) != nil) {
                    if ((jsonDict[kProducts]) != nil) {
                        let aryPriceList:NSArray? = jsonDict.object(forKey: kProducts) as? NSArray
                        if (aryPriceList?.count)! > 0 {
                            let strMultiImageIndicator: String? = (aryPriceList?[0] as? NSDictionary)?.object(forKey: kMultiImgIndicator) as? String
                            if (strMultiImageIndicator == "Y") {
                                GlobalClass.shared.multiImageIndicator = "1"
                            }
                            else {
                                GlobalClass.shared.multiImageIndicator = "0"
                            }
                        }
                        GlobalClass.shared.aryPriceList = aryPriceList as! [NSDictionary]
                    }
                }
            } catch  {
                print("error - > \n    \(error.localizedDescription) \n")
                
                print("\(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    func getSessionCredential() {
        dispatchGroup.enter()
        let params: NSDictionary = [kKeyApiKey: kApiKey, kAffId: kAffIdValue, kKeyAct: kgetCredentialV2, kKeyView: kGenCredential, kKeyDevInf: kDevinf, kKeyAppVer: kAppver, kKeyServiceType: kWags3]
        let url:String = kBaseURL + kSessionURL
        
        print("getPriceList url = \(url)")
        
        let todosEndpoint: String = url
        guard let todosURL = URL(string: todosEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        var todosUrlRequest = URLRequest(url: todosURL)
        todosUrlRequest.httpMethod = "POST"
        let newTodo: [String: Any] = params as! [String : Any]
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
            print("getSessionCredential completed")
            self.dispatchGroup.leave()
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
                guard let json = try JSONSerialization.jsonObject(with: responseData,
                                                                  options: []) as? [String: Any] else {
                                                                    print("Could not get JSON from responseData as dictionary")
                                                                    return
                }
                let jsonDict:NSDictionary = json as NSDictionary
                if ((jsonDict.object(forKey: kSecretKey)) != nil){
                    self.awsSecretAccessKey = (jsonDict.object(forKey: kSecretKey) as? String)!
                    GlobalClass.shared.secretKey = self.awsSecretAccessKey
                }
                if ((jsonDict.object(forKey: kSessionId)) != nil){
                    self.securityToken = (jsonDict.object(forKey: kSessionId) as? String)!
                    GlobalClass.shared.sessionId = self.securityToken
                }
                if ((jsonDict.object(forKey: kAccessKeyId)) != nil){
                    self.awsAccessKeyId = (jsonDict.object(forKey: kAccessKeyId) as? String)!
                    GlobalClass.shared.accessKeyId = self.awsAccessKeyId
                }
            } catch  {
                print("error - > \n    \(error.localizedDescription) \n")
                
                print("\(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    //MARK:- upload task
    
    func uploadTask(){

        let contentType: String = "image/jpg"
        
        let tz = NSTimeZone(name: kTimeZoneType)
        let formater = DateFormatter()
        formater.dateFormat = kDateFormat
        formater.timeZone = tz as TimeZone!
        let timeStamp: String = "\(formater.string(from: Date())) GMT"
        
        let ctrlUploadImgHandler = UploadPhotoAPIHandler ()
        
        let filename = "Image_\(GlobalClass.shared.affId)_\(ctrlUploadImgHandler.getExpiryTime()).jpg"
        
        
        let urlStr: String = "http://\(kImageUploadURL)/\(filename)"
        
        
        let url = URL(string: urlStr)
        
        var request = URLRequest(url: url! as URL)
        request.httpMethod = kHTTPType
        
        let image: UIImage? = UIImage(named: "correct")
        let image_data = UIImageJPEGRepresentation(image!, 0.3)!
        let body = NSMutableData()
        
        body.append(image_data)
        
        request.httpBody = body as Data
        
        
        
        //******** add header field ********//
        request.addValue(timeStamp, forHTTPHeaderField: kDate)
        request.addValue(contentType, forHTTPHeaderField: kContentType)
        request.addValue(self.securityToken, forHTTPHeaderField: kSecurityToken)
        
              
        
        let auth = ctrlUploadImgHandler.generateUploadAuth(filename, url: kImageUploadURL, sessionID: self.securityToken, secretKey: self.awsSecretAccessKey, accessKeyId: self.awsAccessKeyId)
        request.addValue(auth, forHTTPHeaderField: kAuthorization)
        
        self.upload(request: request, data: image_data)
    }
    
    
    @IBAction func UploadMultipleImages(_ sender: Any){
        self.getPriceList()
        self.getSessionCredential()
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            self.uploadMultiImages()
        }
    }
    
    func uploadMultiImages(){
        (self.aryUploadImages as NSArray).enumerateObjects({ obj, idx, stop in
            
            let ctrlUploadImage: uploadImage? = (obj as? uploadImage)
            
            
            let contentType: String = "image/jpg"
            
            let tz = NSTimeZone(name: kTimeZoneType)
            let formater = DateFormatter()
            formater.dateFormat = kDateFormat
            formater.timeZone = tz as TimeZone!
            let timeStamp: String = "\(formater.string(from: Date())) GMT"
            
            let ctrlUploadImgHandler = UploadPhotoAPIHandler ()
            
            let filename = "Image_\(GlobalClass.shared.affId)_\(ctrlUploadImgHandler.getExpiryTime()).jpg"
            
            
            let urlStr: String = "http://\(kImageUploadURL)/\(filename)"
            
            
            let url = URL(string: urlStr)
            
            var request = URLRequest(url: url! as URL)
            request.httpMethod = kHTTPType
            
            let image: UIImage? = ctrlUploadImage?.image
            let image_data = UIImageJPEGRepresentation(image!, 0.3)!
            let body = NSMutableData()
            
            body.append(image_data)
            
            request.httpBody = body as Data
            
            
            
            //******** add header field ********//
            request.addValue(timeStamp, forHTTPHeaderField: kDate)
            request.addValue(contentType, forHTTPHeaderField: kContentType)
            request.addValue(self.securityToken, forHTTPHeaderField: kSecurityToken)
            
            let auth = ctrlUploadImgHandler.generateUploadAuth(filename, url: kImageUploadURL, sessionID: self.securityToken, secretKey: self.awsSecretAccessKey, accessKeyId: self.awsAccessKeyId)
            request.addValue(auth, forHTTPHeaderField: kAuthorization)
            
            
            let afnet:URLSessionUploadTask = BackgroundSessionManager.shared().uploadTask(withStreamedRequest: request, progress: { (Progress) in
                DispatchQueue.main.async {
                    ctrlUploadImage?.progress = Float(Progress.fractionCompleted);
                }
            }, completionHandler: { (response, responseObject, error) in
                if response is HTTPURLResponse {
                    
                    let res: HTTPURLResponse? = (response as? HTTPURLResponse)
                    print("~~~~~ Status code: \(Int((res?.statusCode)!)) \n ===\(String(describing: res?.allHeaderFields))~~~~~~~res:\(String(describing: res))~~~~~~``error:\(String(describing: error))")
                    self.getDownloadImageURL(filename, image: (ctrlUploadImage?.image)!)
                }
                
            })
            afnet.resume()
        })
    }
    
    func getDownloadImageURL(_ filename: String, image img: UIImage) {
        let ctrlUploadImgHandler = UploadPhotoAPIHandler ()
        let returnURL: String? = ctrlUploadImgHandler.generateFinalURL(filename, url:kImageUploadURL, sessionID: self.securityToken, secretKey:self.awsSecretAccessKey, accessKeyId:self.awsAccessKeyId)
        
        if returnURL != nil {
            print("URL String : \n \("http://" + returnURL!)")
            getDataFromUrl(url: URL(string: "http://" + returnURL!)!) { data, response, error in
                guard let data = data, error == nil else { return }
                print("Download Finished")
                let image:UIImage? = UIImage(data: data)!
                if(image != nil){
                    print("Image uploaded successfully")
                }
            }
        }
    }
}
