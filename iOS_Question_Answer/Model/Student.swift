//
//  Student.swift
//  iOS_Question_Answer
//
//  Created by Sebastin on 8/7/18.
//  Copyright © 2018 Sebastin. All rights reserved.
//

import UIKit

let keyPathProgress = "progress"

let keyPathSchool = "objSchool.schoolName"

class Student: NSObject {
    var name: String?
    var age:Int?
    @objc dynamic var progress: Int = 0
    var updateIndex:Int?
    @objc dynamic var objSchool:School?
    
    override init() {
        super.init()
        self.objSchool = School()
        self.addObserver(self, forKeyPath: keyPathProgress, options: NSKeyValueObservingOptions.new, context: nil)
        self.addObserver(self, forKeyPath: keyPathSchool, options: NSKeyValueObservingOptions.new, context: nil)
    }
   
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == keyPathProgress {
            let student = object as! Student
            print(student.progress)
            NotificationCenter.default.post(name: Notification.Name("KVO"), object: object, userInfo: nil)
        }else if keyPath == keyPathSchool {
            let student = object as! Student
            if let schoolName = student.objSchool?.schoolName{
                print(schoolName)
            }
        }
        print(keyPath!)
    }
    
    deinit {
        self.removeObserver(self, forKeyPath: keyPathProgress)
        self.removeObserver(self, forKeyPath: keyPathSchool)
    }

}



