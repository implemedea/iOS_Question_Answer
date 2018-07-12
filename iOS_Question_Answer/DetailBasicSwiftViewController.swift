//
//  DetailBasicSwiftViewController.swift
//  iOS_Question_Answer
//
//  Created by Sebastin on 7/10/18.
//  Copyright © 2018 Sebastin. All rights reserved.
//

import UIKit

class DetailBasicSwiftViewController: UIViewController {

    var strTopic:String = ""
   
    @IBOutlet weak var txtViewLog: UITextView!
    @IBOutlet weak var imgViewFunction: UIImageView!
   
    var imgFunction:UIImage?
    var txtLog:String?
   
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.topItem?.title = strTopic
        if let img = imgFunction{
            self.imgViewFunction.image = img
        }
        if let txt = txtLog{
            self.txtViewLog.text = txt
        }
        
        
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
