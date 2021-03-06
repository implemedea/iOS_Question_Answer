//
//  ProportionalConstraintViewController.swift
//  iOS_Question_Answer
//
//  Created by Sebastin on 8/31/18.
//  Copyright © 2018 Sebastin. All rights reserved.
//

import UIKit

class ProportionalConstraintViewController: UIViewController {

    public var RotateDevice:Bool = false
    
    override func viewWillDisappear(_ animated: Bool) {
        if(RotateDevice){
            AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
        }
        super.viewDidDisappear(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
