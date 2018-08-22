//
//  iPadViewController.swift
//  iOS_Question_Answer
//
//  Created by Sebastin on 8/1/18.
//  Copyright © 2018 Sebastin. All rights reserved.
//

import UIKit

class iPadViewController: UIViewController {
    
    
    @IBOutlet weak var lblKVO: UILabel!
    @IBOutlet weak var btnKVC: UIButton!
    
    let student = Student()
    let storyBoardiPad:UIStoryboard = UIStoryboard.init(name: "IPadStoryboard", bundle: nil)
    var progressCounter = 0
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        student.name = "student 1"
        student.age = 20
        student.progress = 0
        print(student.name!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc
    @IBAction func showRectPopOver(_ sender: Any) {
        let popVC = self.storyBoardiPad.instantiateViewController(withIdentifier: "PopoverNavigationController") as! PopoverNavigationController
        self.addChildViewController(popVC)
        self.view.addSubview(popVC.view)
        popVC.didMove(toParentViewController: self)
       
    }
    
    @IBAction func showKVO(_ sender: Any) {
        let popVC = self.storyBoardiPad.instantiateViewController(withIdentifier: "NavigationKVO")
        popVC.modalPresentationStyle = .popover
        
        
        let popOverVC = popVC.popoverPresentationController
        popOverVC?.delegate = self
        let viewForSource = sender as! UIView
        popOverVC?.sourceView = viewForSource
        
        // the position of the popover where it's showed
        popOverVC?.sourceRect = viewForSource.bounds
        popVC.preferredContentSize = CGSize(width: 250, height: 250)
        
        self.present(popVC, animated: true)
        
        
        progressCounter = 0
        self.lblKVO.text = String(progressCounter)
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(KVO), userInfo: nil, repeats: true)
    }
    
    @objc func KVO(){
        let student = Student()
        student.name = "student 2"
        student.age = 21
        if(progressCounter != 10){
            student.updateIndex = 2
            student.progress = progressCounter + 1
            progressCounter = student.progress
            self.lblKVO.text = String(progressCounter)
        }else if(progressCounter == 10){
             timer.invalidate()
        }
    }
    
   
   
//    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
//        return .none
//    }
}

extension iPadViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

