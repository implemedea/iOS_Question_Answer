//
//  PopoverNavigationController.swift
//  iOS_Question_Answer
//
//  Created by Sebastin on 8/21/18.
//  Copyright © 2018 Sebastin. All rights reserved.
//

import UIKit

class PopoverNavigationController: UINavigationController {

   
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(removeFromSuperView), name: NSNotification.Name(rawValue: kNotificationNameNavigation), object: nil)
    }

   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func removeFromSuperView(){
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
  

}
