//
//  iPadViewController.swift
//  iOS_Question_Answer
//
//  Created by Sebastin on 8/1/18.
//  Copyright © 2018 Sebastin. All rights reserved.
//

import UIKit

class iPadViewController: UIViewController {

    
    @IBOutlet weak var btnKVC: UIButton!
    let objStudent = Student()
    
    let storyBoardiPad:UIStoryboard = UIStoryboard.init(name: "IPadStoryboard", bundle: nil)
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let student = Student()
        student.name = "Test"
        
        let observer = Observer(student: student)
        observer.student.name = "test1"

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc
    @IBAction func showRectPopOver(_ sender: Any) {
        let popVC = self.storyBoardiPad.instantiateViewController(withIdentifier: "NavigationRectPop")
        popVC.modalPresentationStyle = .popover
        
        
        let popOverVC = popVC.popoverPresentationController
        popOverVC?.delegate = self
        let viewForSource = sender as! UIView
        popOverVC?.sourceView = viewForSource
        
        // the position of the popover where it's showed
        popOverVC?.sourceRect = viewForSource.bounds
        popVC.preferredContentSize = CGSize(width: 250, height: 250)
        
        self.present(popVC, animated: true)
    }
    
    @IBAction func showKVC(_ sender: Any) {
        let popVC = self.storyBoardiPad.instantiateViewController(withIdentifier: "NavigationRectPop")
        popVC.modalPresentationStyle = .popover
        
        
        let popOverVC = popVC.popoverPresentationController
        popOverVC?.delegate = self
        let viewForSource = sender as! UIView
        popOverVC?.sourceView = viewForSource
        
        // the position of the popover where it's showed
        popOverVC?.sourceRect = viewForSource.bounds
        popVC.preferredContentSize = CGSize(width: 250, height: 250)
        
        objStudent.name = "test1"
        
        self.present(popVC, animated: true)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == keyPathToObserve {
            
        }
    }
    
    deinit {
        self.btnKVC.removeObserver(self, forKeyPath: keyPathToObserve, context: nil)
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

