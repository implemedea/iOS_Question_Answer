//
//  Student.swift
//  iOS_Question_Answer
//
//  Created by Sebastin on 8/7/18.
//  Copyright © 2018 Sebastin. All rights reserved.
//

import UIKit

let keyPath = "progress"

class Student: NSObject {
    var name: String?
    var age:Int?
    @objc dynamic var progress: Int = 0
    
}

class Observer: NSObject {
    var student: Student

    init(student: Student) {
        self.student = student

        super.init()

        self.student.addObserver(self, forKeyPath: keyPath, options: NSKeyValueObservingOptions.new, context: nil)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == keyPath {
            let student = object as! Student
            print(student.progress)
            NotificationCenter.default.post(name: Notification.Name("KVO"), object: object, userInfo: nil)
        }
    }

    deinit {
        self.student.removeObserver(self, forKeyPath: keyPath)
    }
}


