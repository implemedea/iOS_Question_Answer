//
//  CommonFunctionViewController.swift
//  iOS_Question_Answer
//
//  Created by Sebastin on 7/27/18.
//  Copyright © 2018 Sebastin. All rights reserved.
//

import UIKit

enum CommonFunction:String{
    case WriteFile = "Write File"
    case ReadFile = "Read File"
    case WriteImage = "Write Image"
    case ReadImage = "Read Image"
    case RotateCameraImage = "Rotate camera image"
    case EmailValidation = "Email validation"
    case UNICODEConversion = "UNI CODE Conversion"
    case DictionarytoJSONconverter = "Dictionary to JSON converter"
    case ConvertDateToString = "Convert date to string"
    case GetDateFromString = "Get date from string"
    case ShowAlertMessage = "Show alert message"
    case GetCurrentDateAndTime = "Get current date and time"
    case GetCurrentDate = "Get current date"
    case GetCurrentTime = "Get current time"
    case ChangeDateFormat = "Change date format"
    case GetNotification = "Get Notification"
    case GetNextDate = "Get next date"
    case GetPreviousDate = "Get previous date"
    case CheckValidDate = "Check valid date"

    
}

class CommonFunctionViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let aryTopic = [CommonFunction.WriteFile.rawValue,
                    CommonFunction.ReadFile.rawValue,
                    CommonFunction.WriteImage.rawValue,
                    CommonFunction.ReadImage.rawValue,
                    CommonFunction.RotateCameraImage.rawValue,
                    CommonFunction.EmailValidation.rawValue,
                    CommonFunction.UNICODEConversion.rawValue,
                    CommonFunction.DictionarytoJSONconverter.rawValue,
                    CommonFunction.ConvertDateToString.rawValue,
                    CommonFunction.GetDateFromString.rawValue,
                    CommonFunction.ShowAlertMessage.rawValue,
                    CommonFunction.GetCurrentDateAndTime.rawValue,
                    CommonFunction.GetCurrentDate.rawValue,
                    CommonFunction.GetCurrentTime.rawValue,
                    CommonFunction.ChangeDateFormat.rawValue,
                    CommonFunction.GetNotification.rawValue,
                    CommonFunction.GetNextDate.rawValue,
                    CommonFunction.GetPreviousDate.rawValue,
                    CommonFunction.CheckValidDate.rawValue] as [Any]
    
    let storyBoardMain:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let documentsPath: String? = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String)
        let destfilePath: String = URL(fileURLWithPath: documentsPath!).appendingPathComponent("\(fileName).\(strType)").absoluteString
        let fileExists: Bool = FileManager.default.fileExists(atPath: destfilePath)
        if !fileExists {
            let content = try? String(contentsOfFile: destfilePath, encoding: String.Encoding.ascii)
            let jsonData: Data? = content?.data(using: String.Encoding.utf8)
            
            
            let error: Error? = nil
            let jsonDict = try? JSONSerialization.jsonObject(with: jsonData!, options: [])
            if error == nil {
                return jsonDict! as! [AnyHashable : Any]
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
    
    //MARK:- tableview delegate and datasource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aryTopic.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId:String = "CommonFunctionCellId"
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellId)!
        cell.textLabel?.text = aryTopic[indexPath.row] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(aryTopic[indexPath.row] as! String == CommonFunction.WriteFile.rawValue){
            let dic:[String:String] = ["key":"value"]
            self.writeData(toFile: "SampleDataFile.json", data: self.dictionary(toJsonConverter: dic))
            print("Data write successful")
        }else if(aryTopic[indexPath.row] as! String == CommonFunction.ReadFile.rawValue){
            let readData = self.readData(fromFile: "SampleDataFile", type: "json")
            print("Read data from file = ",readData)
        }else if(aryTopic[indexPath.row] as! String == CommonFunction.WriteImage.rawValue){
            self.writeImage(image: UIImage(named : "twitter1")!, fileName: "TwitterImage.png")
            print("Image write successful")
        }else if(aryTopic[indexPath.row] as! String == CommonFunction.ReadImage.rawValue){
            if let image = self.readImage(fileName: "TwitterImage.png"){
                guard let childViewController = storyBoardMain.instantiateViewController(withIdentifier: "DetailBasicSwiftViewController") as? DetailBasicSwiftViewController else{
                    return
                }
                childViewController.imgFunction = image
                self.navigationController?.pushViewController(childViewController, animated: true)
            }
        }else if(aryTopic[indexPath.row] as! String == CommonFunction.RotateCameraImage.rawValue){
            if let image = self.rotateCameraImageToProperOrientation(imageSource: UIImage(named : "twitter1")!, maxResolution: 0.5){
                guard let childViewController = storyBoardMain.instantiateViewController(withIdentifier: "DetailBasicSwiftViewController") as? DetailBasicSwiftViewController else{
                    return
                }
                childViewController.imgFunction = image
                self.navigationController?.pushViewController(childViewController, animated: true)
            }
        }else if(aryTopic[indexPath.row] as! String == CommonFunction.EmailValidation.rawValue){
            let validEmail = self.isValidEmail(testStr: "test@test.com")
            print("test@test.com is valid email = ",validEmail)
            let notValidEmail = self.isValidEmail(testStr: "test@test.casom")
            print("test@test.casom is not valid email = ",notValidEmail)
        }else if(aryTopic[indexPath.row] as! String == CommonFunction.UNICODEConversion.rawValue){
            let unicode = self.escapeCharreplace("https://www.google.co.in/")
            print(unicode)
        }else if(aryTopic[indexPath.row] as! String == CommonFunction.DictionarytoJSONconverter.rawValue){
            var dic:[String:String] = [:]
            dic["key"] = "value"
            print(self.dictionary(toJsonConverter: dic))
        }else if(aryTopic[indexPath.row] as! String == CommonFunction.ConvertDateToString.rawValue){
            let date = Date()
            let dateString = self.getDateString(from: date, currentFormatter: "dd.MM.yyyy")
            print("dateString = ",dateString)
        }else if(aryTopic[indexPath.row] as! String == CommonFunction.GetDateFromString.rawValue){
            let date = self.getDateFromDateString("01-03-2018", currentFormatter: "dd-MM-yyyy")
            print("Date format = ",date)
        }else if(aryTopic[indexPath.row] as! String == CommonFunction.ShowAlertMessage.rawValue){
            self.showAlertMessage(vc: self, titleStr: "Title", messageStr: "Alert message")
        }else if(aryTopic[indexPath.row] as! String == CommonFunction.GetCurrentDateAndTime.rawValue){
            print("current date and time = ",self.getCurrentDateAndTime())
        }else if(aryTopic[indexPath.row] as! String == CommonFunction.GetCurrentDate.rawValue){
            print("current date = ",self.getCurrentDate())
        }else if(aryTopic[indexPath.row] as! String == CommonFunction.GetCurrentTime.rawValue){
            print("current time = ",self.getCurrentTime())
        }else if(aryTopic[indexPath.row] as! String == CommonFunction.ChangeDateFormat.rawValue){
            let date = self.changeDateFormat(dateAsString: "01-03-2018 10:11 AM", currnetDateFormat: "dd-MM-yyyy hh:mm a", futureDateFormat: "hh:mm a")
            print("changed date format = ",date)
        }else if(aryTopic[indexPath.row] as! String == CommonFunction.GetNotification.rawValue){
            let getNotificationDate = self.getNotificationDate(eventDate: Date())
            print("getNotificationDate = ",getNotificationDate)
        }else if(aryTopic[indexPath.row] as! String == CommonFunction.GetNextDate.rawValue){
            let getNextDate = self.convertNextDate(dateString: "01-03-2018 10:11 AM", dateformat: "dd-MM-yyyy hh:mm a")
            print("Next Date of 01-03-2018 10:11 AM = ",getNextDate)
        }else if(aryTopic[indexPath.row] as! String == CommonFunction.GetPreviousDate.rawValue){
            let getPreviousDate = self.convertPreviousDate(dateString: "01-03-2018 10:11 AM", dateformat: "dd-MM-yyyy hh:mm a")
            print("Previous Date of 01-03-2018 10:11 AM = ",getPreviousDate)
        }else if(aryTopic[indexPath.row] as! String == CommonFunction.CheckValidDate.rawValue){
            print("01-03-2018 10:11 AM is date valid = ",self.checkIsValidDate(dateString: "01-03-2018 10:11 AM", dateformat: "dd-MM-yyyy hh:mm a"))
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

}

extension UIImage {
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

extension UITableView {
    func scrollToBottom(animated: Bool) {
        let y = contentSize.height - frame.size.height
        setContentOffset(CGPoint(x: 0, y: (y<0) ? 0 : y), animated: animated)
    }
}
