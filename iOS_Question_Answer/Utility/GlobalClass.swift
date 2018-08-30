//
//  GlobalClass.swift
//  iOS_Question_Answer
//
//  Created by Sebastin on 8/7/18.
//  Copyright © 2018 Sebastin. All rights reserved.
//

import UIKit

class GlobalClass: NSObject {
    static let shared = GlobalClass()
    
    //Initializer access level change now
    private override init(){}
    
    var secretKey: String = kEmpty
    var sessionId: String = kEmpty
    var accessKeyId: String = kEmpty
    var aryPriceList = [Any]()
    var affId: String = kEmpty
    var multiImageIndicator: String = kEmpty
    
    
    func createFileFromTemp(location:URL){
        debugPrint("Download finished: \(location)")
        do {
            let downloadedData = try Data(contentsOf: location)
            
            DispatchQueue.main.async(execute: {
                print("transfer completion OK!")
                
                let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString
                let destinationPath = documentDirectoryPath.appendingPathComponent("swift.pdf")
                
                let pdfFileURL = URL(fileURLWithPath: destinationPath)
                FileManager.default.createFile(atPath: pdfFileURL.path,
                                               contents: downloadedData,
                                               attributes: nil)
                
                if FileManager.default.fileExists(atPath: pdfFileURL.path) {
                    print("pdfFileURL present!") // Confirm that the file is here!
                }
            })
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Write File
    func writeData(toFile fileName: String, data: String) {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let path = dir.appendingPathComponent(fileName)
            //writing
            do {
                try data.write(to: path, atomically: false, encoding: String.Encoding.utf8)
            }
            catch {
                
            }
        }
    }
    
    // MARK: - Read File
    func readData(fromFile fileName: String, type strType: String) -> [AnyHashable: Any] {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent("\(fileName).\(strType)")
            //reading
            do {
                let content = try String(contentsOf: fileURL, encoding: .utf8)
                let jsonData: Data? = content.data(using: String.Encoding.utf8)
                let error: Error? = nil
                if let data = jsonData{
                    let jsonDict = try? JSONSerialization.jsonObject(with: data, options: [])
                    if error == nil {
                        return jsonDict! as! [AnyHashable : Any]
                    }
                }else{
                    print("data not available")
                }
            }
            catch {
                
            }
        }
        return [:]
    }
    
    //MARK:- Write Image
    
    func writeImage(image:UIImage, fileName:String){
        do {
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = documentsURL.appendingPathComponent("\(fileName)")
            if let pngImageData = UIImagePNGRepresentation(image) {
                try pngImageData.write(to: fileURL, options: .atomic)
            }
        } catch { }
    }
    
    //MARK:- Read Image
    func readImage(fileName:String)->UIImage?{
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let filePath = documentsURL.appendingPathComponent("\(fileName).png").path
        if FileManager.default.fileExists(atPath: filePath) {
            return UIImage(contentsOfFile: filePath)!
        }
        return nil
    }
    
    //MARK:- Rotate camera image
    func rotateCameraImageToProperOrientation(imageSource : UIImage, maxResolution : CGFloat) -> UIImage? {
        
        let imgRef = imageSource.cgImage;
        
        let width = CGFloat(imgRef!.width);
        let height = CGFloat(imgRef!.height);
        
        var bounds = CGRect(origin: .zero, size: CGSize(width: width, height: height))
        
        
        var scaleRatio : CGFloat = 1
        if (width > maxResolution || height > maxResolution) {
            
            scaleRatio = min(maxResolution / bounds.size.width, maxResolution / bounds.size.height)
            bounds.size.height = bounds.size.height * scaleRatio
            bounds.size.width = bounds.size.width * scaleRatio
        }
        
        var transform = CGAffineTransform.identity
        let orient = imageSource.imageOrientation
        let imageSize = CGSize(width: CGFloat(imgRef!.width), height: CGFloat(imgRef!.height))
        
        
        switch(imageSource.imageOrientation) {
        case .up :
            transform = CGAffineTransform.identity
            
        case .upMirrored :
            transform = CGAffineTransform(translationX: imageSize.width, y: 0.0);
            transform = transform.scaledBy(x: -1.0, y: 1.0);
            
        case .down :
            transform = CGAffineTransform(translationX: imageSize.width, y: imageSize.height);
            transform = transform.rotated(by: CGFloat(Double.pi));
            
        case .downMirrored :
            transform = CGAffineTransform(translationX: 0.0, y: imageSize.height);
            transform = transform.scaledBy(x: 1.0, y: -1.0);
            
        case .left :
            let storedHeight = bounds.size.height
            bounds.size.height = bounds.size.width;
            bounds.size.width = storedHeight;
            transform = CGAffineTransform(translationX: 0.0, y: imageSize.width);
            transform = transform.rotated(by: 3.0 * CGFloat(Double.pi) / 2.0);
            
        case .leftMirrored :
            let storedHeight = bounds.size.height
            bounds.size.height = bounds.size.width;
            bounds.size.width = storedHeight;
            transform = CGAffineTransform(translationX: imageSize.height, y: imageSize.width);
            transform = transform.scaledBy(x: -1.0, y: 1.0);
            transform = transform.rotated(by: 3.0 * CGFloat(Double.pi) / 2.0);
            
        case .right :
            let storedHeight = bounds.size.height
            bounds.size.height = bounds.size.width;
            bounds.size.width = storedHeight;
            transform = CGAffineTransform(translationX: imageSize.height, y: 0.0);
            transform = transform.rotated(by: CGFloat(Double.pi) / 2.0);
            
        case .rightMirrored :
            let storedHeight = bounds.size.height
            bounds.size.height = bounds.size.width;
            bounds.size.width = storedHeight;
            transform = CGAffineTransform(scaleX: -1.0, y: 1.0);
            transform = transform.rotated(by: CGFloat(Double.pi) / 2.0);
            
        default : ()
        }
        
        UIGraphicsBeginImageContext(bounds.size)
        let context = UIGraphicsGetCurrentContext()
        
        if orient == .right || orient == .left {
            context!.scaleBy(x: -scaleRatio, y: scaleRatio);
            context!.translateBy(x: -height, y: 0);
        } else {
            context!.scaleBy(x: scaleRatio, y: -scaleRatio);
            context!.translateBy(x: 0, y: -height);
        }
        
        context!.concatenate(transform);
        
        context?.draw(imageSource.cgImage!, in: CGRect(x: 0.0,y: 0.0,width: imageSource.size.width,height: imageSource.size.height))
        
        
        let imageCopy = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return imageCopy!;
    }
    
    // MARK: - Email validation
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    // MARK: - UNI CODE Conversion
    func escapeCharreplace(_ str: String) -> String {
        let data: Data? = str.data(using: String.Encoding.ascii, allowLossyConversion: true)
        var newstr = String(data: data!, encoding: String.Encoding.ascii)!
        newstr = newstr.replacingOccurrences(of: " ", with: "%20")
        newstr = newstr.replacingOccurrences(of: "[", with: "%5B")
        newstr = newstr.replacingOccurrences(of: "]", with: "%5D")
        newstr = newstr.replacingOccurrences(of: "{", with: "%7B")
        newstr = newstr.replacingOccurrences(of: "}", with: "%7D")
        newstr = newstr.replacingOccurrences(of: "^", with: "%5E")
        newstr = newstr.replacingOccurrences(of: ">", with: "%3E")
        newstr = newstr.replacingOccurrences(of: "<", with: "%3C")
        newstr = newstr.replacingOccurrences(of: "|", with: "%7C")
        newstr = newstr.replacingOccurrences(of: "\"", with: "%22")
        newstr = newstr.replacingOccurrences(of: "\\", with: "%5C")
        return newstr
    }
    
    // MARK: - Dictionary to JSON converter
    func dictionary(toJsonConverter dictionary: [AnyHashable: Any]) -> String {
        if let theJSONData = try? JSONSerialization.data(
            withJSONObject: dictionary,
            options: []) {
            let theJSONText = String(data: theJSONData,
                                     encoding: .ascii)
            print("JSON string = \(theJSONText!)")
            return theJSONText!
        }
        return ""
    }
    
    // MARK: - Convert date to string
    func getDateString(from date: Date, currentFormatter curFormatter: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = curFormatter
        dateFormatter.timeZone = NSTimeZone.local
        let dateString: String = dateFormatter.string(from: date)
        return dateString
    }
    
    //MARK:- Get date from string
    func getDateFromDateString(_ dateString: String, currentFormatter curFormatter: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = curFormatter
        let date: Date? = dateFormatter.date(from: dateString)
        return date!
    }
    
    //MARK:- Show alert message
    func showAlertMessage(vc: UIViewController, titleStr:String, messageStr:String) -> Void {
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertControllerStyle.alert);
        let okButton = UIAlertAction(
            title:"OK",
            style: UIAlertActionStyle.default,
            handler:
            {
                (alert: UIAlertAction!)  in
        })
        alert.addAction(okButton)
        vc.present(alert, animated: true, completion: nil)
    }
    
    //MARK:- Get current date and time
    func getCurrentDateAndTime()->String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm a"
        let result = formatter.string(from: date)
        return result
    }
    
    //MARK:- Get current date
    func getCurrentDate()->String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)
        return result
    }
    
    //MARK:- Get current time
    func getCurrentTime()->String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        let result = formatter.string(from: date)
        return result
    }
    
    //MARK:- Change date format
    func changeDateFormat(dateAsString:String, currnetDateFormat:String, futureDateFormat:String)->String{
        if(dateAsString != kEmpty && dateAsString != kAddCaseDatePlaceholder){
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = currnetDateFormat
            let date = dateFormatter.date(from: dateAsString)
            dateFormatter.dateFormat = futureDateFormat
            let convertedDate = dateFormatter.string(from: date!)
            return convertedDate
        }
        return kEmpty
    }
    
    //MARK:- Get Notification
    func getNotificationDate(eventDate:Date)->Date{
        let tempCalendar = Calendar.current
        let earlyDate = tempCalendar.date(byAdding: .hour, value: -1, to: eventDate)
        return earlyDate!
    }
    
    //MARK:- Get next date
    func convertNextDate(dateString : String, dateformat:String)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateformat
        let myDate = dateFormatter.date(from: dateString)!
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: myDate)
        let somedateString = dateFormatter.string(from: tomorrow!)
        return somedateString
    }
    
    //MARK:- Get previous date
    func convertPreviousDate(dateString : String, dateformat:String)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateformat
        let myDate = dateFormatter.date(from: dateString)!
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: myDate)
        let somedateString = dateFormatter.string(from: yesterday!)
        return somedateString
    }
    
    //MARK:- Check valid date
    func checkIsValidDate(dateString:String, dateformat:String)->Bool{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateformat
        let selectedDate = dateFormatter.date(from: dateString)!
        
        let currentDate = Date()
        let convertedDate = dateFormatter.string(from: currentDate)
        let formatedCurrnetDate = dateFormatter.date(from: convertedDate)!
        
        if formatedCurrnetDate <= selectedDate  {
            return true
        }
        return false
    }
    
    //MARK:- Downaload Image
    func getDownloadImageURL(filename:String, securityToken:String, awsSecretAccessKey:String, awsAccessKeyId:String) {
        let ctrlUploadImgHandler = UploadPhotoAPIHandler ()
        let returnURL: String? = ctrlUploadImgHandler.generateFinalURL(filename, url:kImageUploadURL, sessionID: securityToken, secretKey:awsSecretAccessKey, accessKeyId:awsAccessKeyId)
        
        if returnURL != nil {
            print("URL String : \n \("http://" + returnURL!)")
            getDataFromUrl(url: URL(string: "http://" + returnURL!)!) { data, response, error in
                guard let tempData = data, error == nil else { return }
                if let _:UIImage = UIImage(data: tempData){
                    print("Image uploaded successfully")
                }
            }
        }
    }
    
    //MARK:- Image data download
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
}
