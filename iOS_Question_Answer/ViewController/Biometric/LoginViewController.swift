/// Copyright (c) 2017 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit
import CoreData

protocol closeLoginWindow{
    func closeWindow()
}

struct KeychainConfiguration {
    static let serviceName = "TouchMeIn"
    static let accessGroup:String? = nil
}

class LoginViewController: UIViewController {

    var delegate:closeLoginWindow?
    let touchMe = BiometricIDAuth()
    
  // MARK: Properties
  var managedObjectContext: NSManagedObjectContext?
    var passwordItems:[KeychainPasswordItem] = []
    let createLoginButtonTag = 0
    let loginButtonTag = 1
    @IBOutlet weak var loginButton: UIButton!


  // MARK: - IBOutlets
  @IBOutlet weak var usernameTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var createInfoLabel: UILabel!  

    @IBOutlet weak var touchIdButton: UIButton!
    // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    switch touchMe.biometricType(){
    case .touchID:
        touchIdButton.setImage(UIImage(named:"Touch-icon-lg"), for: .normal)
    case .faceID:
        touchIdButton.setImage(UIImage(named:"FaceIcon"), for: .normal)
    case .none:
        touchIdButton.setImage(UIImage(named:"Touch-icon-lg"), for: .normal)
    }
    
    touchIdButton.isHidden = !touchMe.canEvaluatePolicy()
    let hasLogin = UserDefaults.standard.bool(forKey: "hasLoginKey")
    if(hasLogin){
        loginButton.setTitle("Login", for: .normal)
        loginButton.tag = loginButtonTag
         createInfoLabel.isHidden = true
    }else{
        loginButton.setTitle("Create", for: .normal)
        loginButton.tag = createLoginButtonTag
         createInfoLabel.isHidden = false
    }
    if let storedUsername = UserDefaults.standard.value(forKey: "username") as? String {
        usernameTextField.text = storedUsername
    }
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
    
    @IBAction func closeView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.delegate?.closeWindow()
    }
    
}

// MARK: - IBActions
extension LoginViewController {
    
    

  @IBAction func loginAction(sender: UIButton) {
    guard let newAccountName = usernameTextField.text, let newPassword = passwordTextField.text, !newAccountName.isEmpty, !newPassword.isEmpty else {
        self.showLoginFailedAlert()
        return
    }
    self.usernameTextField.resignFirstResponder()
    self.passwordTextField.resignFirstResponder()
    
    if(sender.tag == createLoginButtonTag){
        let hasLoginKey = UserDefaults.standard.bool(forKey: "hasLoginKey")
        if(!hasLoginKey && usernameTextField.hasText){
            UserDefaults.standard.setValue(usernameTextField.text, forKey: "username")
        }
        do{
            let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName, account: newAccountName, accessGroup: KeychainConfiguration.accessGroup)
            try passwordItem.savePassword(newPassword)
        }catch{
            fatalError("Error updating keychain - \(error)")
        }
        UserDefaults.standard.set(true, forKey: "hasLoginKey")
        loginButton.tag = loginButtonTag
         performSegue(withIdentifier: "dismissLogin", sender: self)
    }else if(sender.tag == loginButtonTag){
        if(self.checkLogin(username: usernameTextField.text!, password: passwordTextField.text!)){
            performSegue(withIdentifier: "dismissLogin", sender: self)
        }else{
            self.showLoginFailedAlert()
        }
    }
  }
    
    func checkLogin(username:String, password:String)->Bool{
        guard let username = UserDefaults.standard.value(forKey: "username") else {
            return false
        }
        do{
            let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName, account: username as! String, accessGroup: KeychainConfiguration.accessGroup)
            let keychainPassword = try passwordItem.readPassword()
            return password == keychainPassword
        }catch{
            fatalError("Error reading password from keychain - \(error)")
        }
    }
    
    private func showLoginFailedAlert() {
        let alertView = UIAlertController(title: "Login Problem", message: "Wrong username or password", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Foiled Again!", style: .default, handler: nil)
        alertView.addAction(okAction)
        present(alertView, animated: true, completion: nil)
    }
    
    @IBAction func touchIDLoginAction(sender: UIButton) {
        touchMe.authenticateUser() { [weak self] in
            self?.performSegue(withIdentifier: "dismissLogin", sender: self)
        }
        
      
    }
    
    
}


