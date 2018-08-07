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
    
    var progress:Int = 0
    
}
