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
            GlobalClass.shared.writeData(toFile: "SampleDataFile.json", data: GlobalClass.shared.dictionary(toJsonConverter: dic))
            print("Data write successful")
        }else if(aryTopic[indexPath.row] as! String == CommonFunction.ReadFile.rawValue){
            let readData = GlobalClass.shared.readData(fromFile: "SampleDataFile", type: "json")
            print("Read data from file = ",readData)
        }else if(aryTopic[indexPath.row] as! String == CommonFunction.WriteImage.rawValue){
            GlobalClass.shared.writeImage(image: UIImage(named : "twitter1")!, fileName: "TwitterImage.png")
            print("Image write successful")
        }else if(aryTopic[indexPath.row] as! String == CommonFunction.ReadImage.rawValue){
            if let image = GlobalClass.shared.readImage(fileName: "TwitterImage.png"){
                guard let childViewController = storyBoardMain.instantiateViewController(withIdentifier: "DetailBasicSwiftViewController") as? DetailBasicSwiftViewController else{
                    return
                }
                childViewController.imgFunction = image
                self.navigationController?.pushViewController(childViewController, animated: true)
            }
        }else if(aryTopic[indexPath.row] as! String == CommonFunction.RotateCameraImage.rawValue){
            if let image = GlobalClass.shared.rotateCameraImageToProperOrientation(imageSource: UIImage(named : "twitter1")!, maxResolution: 0.5){
                guard let childViewController = storyBoardMain.instantiateViewController(withIdentifier: "DetailBasicSwiftViewController") as? DetailBasicSwiftViewController else{
                    return
                }
                childViewController.imgFunction = image
                self.navigationController?.pushViewController(childViewController, animated: true)
            }
        }else if(aryTopic[indexPath.row] as! String == CommonFunction.EmailValidation.rawValue){
            let validEmail = GlobalClass.shared.isValidEmail(testStr: "test@test.com")
            print("test@test.com is valid email = ",validEmail)
            let notValidEmail = GlobalClass.shared.isValidEmail(testStr: "test@test.casom")
            print("test@test.casom is not valid email = ",notValidEmail)
        }else if(aryTopic[indexPath.row] as! String == CommonFunction.UNICODEConversion.rawValue){
            let unicode = GlobalClass.shared.escapeCharreplace("https://www.google.co.in/")
            print(unicode)
        }else if(aryTopic[indexPath.row] as! String == CommonFunction.DictionarytoJSONconverter.rawValue){
            var dic:[String:String] = [:]
            dic["key"] = "value"
            print(GlobalClass.shared.dictionary(toJsonConverter: dic))
        }else if(aryTopic[indexPath.row] as! String == CommonFunction.ConvertDateToString.rawValue){
            let date = Date()
            let dateString = GlobalClass.shared.getDateString(from: date, currentFormatter: "dd.MM.yyyy")
            print("dateString = ",dateString)
        }else if(aryTopic[indexPath.row] as! String == CommonFunction.GetDateFromString.rawValue){
            let date = GlobalClass.shared.getDateFromDateString("01-03-2018", currentFormatter: "dd-MM-yyyy")
            print("Date format = ",date)
        }else if(aryTopic[indexPath.row] as! String == CommonFunction.ShowAlertMessage.rawValue){
            GlobalClass.shared.showAlertMessage(vc: self, titleStr: "Title", messageStr: "Alert message")
        }else if(aryTopic[indexPath.row] as! String == CommonFunction.GetCurrentDateAndTime.rawValue){
            print("current date and time = ",GlobalClass.shared.getCurrentDateAndTime())
        }else if(aryTopic[indexPath.row] as! String == CommonFunction.GetCurrentDate.rawValue){
            print("current date = ",GlobalClass.shared.getCurrentDate())
        }else if(aryTopic[indexPath.row] as! String == CommonFunction.GetCurrentTime.rawValue){
            print("current time = ",GlobalClass.shared.getCurrentTime())
        }else if(aryTopic[indexPath.row] as! String == CommonFunction.ChangeDateFormat.rawValue){
            let date = GlobalClass.shared.changeDateFormat(dateAsString: "01-03-2018 10:11 AM", currnetDateFormat: "dd-MM-yyyy hh:mm a", futureDateFormat: "hh:mm a")
            print("changed date format = ",date)
        }else if(aryTopic[indexPath.row] as! String == CommonFunction.GetNotification.rawValue){
            let getNotificationDate = GlobalClass.shared.getNotificationDate(eventDate: Date())
            print("getNotificationDate = ",getNotificationDate)
        }else if(aryTopic[indexPath.row] as! String == CommonFunction.GetNextDate.rawValue){
            let getNextDate = GlobalClass.shared.convertNextDate(dateString: "01-03-2018 10:11 AM", dateformat: "dd-MM-yyyy hh:mm a")
            print("Next Date of 01-03-2018 10:11 AM = ",getNextDate)
        }else if(aryTopic[indexPath.row] as! String == CommonFunction.GetPreviousDate.rawValue){
            let getPreviousDate = GlobalClass.shared.convertPreviousDate(dateString: "01-03-2018 10:11 AM", dateformat: "dd-MM-yyyy hh:mm a")
            print("Previous Date of 01-03-2018 10:11 AM = ",getPreviousDate)
        }else if(aryTopic[indexPath.row] as! String == CommonFunction.CheckValidDate.rawValue){
            print("01-03-2018 10:11 AM is date valid = ",GlobalClass.shared.checkIsValidDate(dateString: "01-03-2018 10:11 AM", dateformat: "dd-MM-yyyy hh:mm a"))
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
