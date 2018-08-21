//
//  ViewController.swift
//  iOS10RichNotificationsTutorial
//
//  Created by Kc on 2016-08-06.
//  Copyright © 2016 Kenechi Okolo. All rights reserved.
//

import UIKit
import UserNotifications

class LocalNotificationViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Pop Quiz!"
        content.subtitle = "Let's see how smart you are!"
        content.body = "How many countries are there in Africa?"
        content.badge = 1
        content.categoryIdentifier = "quizCategory"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        UNUserNotificationCenter.current().delegate = self
        
        let requestIdentifier = "africaQuiz"
        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            // handle error
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension LocalNotificationViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // some other way of handling notification
        completionHandler([.alert, .sound])
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
            case "answerOne":
            imageView.image = UIImage(named: "wrong")
            case "answerTwo":
            imageView.image = UIImage(named: "correct")
            case "clue":
            let alert = UIAlertController(title: "Hint", message: "The answer is greater than 29", preferredStyle: .alert)
            let action = UIAlertAction(title: "Thanks!", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        default:
            break
        }
        completionHandler()

    }
}

