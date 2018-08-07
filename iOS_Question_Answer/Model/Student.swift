//
//  Student.swift
//  iOS_Question_Answer
//
//  Created by Sebastin on 8/7/18.
//  Copyright © 2018 Sebastin. All rights reserved.
//

import UIKit

class Student: NSObject {
    @objc dynamic var name: String?
    var age:Int?
}

class Observer: NSObject {
    var student: Student

    init(student: Student) {
        self.student = student

        super.init()

        self.student.addObserver(self, forKeyPath: "name", options: NSKeyValueObservingOptions.new, context: nil)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == keyPathToObserve {

        }
    }

    deinit {
        self.student.removeObserver(self, forKeyPath: "name")
    }
}


