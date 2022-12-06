//
//  LoginVC.swift
//  JustPump
//
//  Created by Edward Fetzer on 23.11.22.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var errorLBL: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorLBL.isHidden = true
        errorLBL.sizeToFit()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //Vorhandener User wird eingeloggt
    @IBAction func loginBtn(_ sender: UIButton) {
        
        Auth.auth().signIn(withEmail: emailTF.text!, password: passwordTF.text!) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
            
            if error == nil {
                strongSelf.performSegue(withIdentifier: "succesLogin", sender: nil)
            } else {
                strongSelf.errorLBL.text = "Überprüfe deine Eingaben"
                strongSelf.errorLBL.isHidden = false
            }
        }
    }
    
    //MARK: Keyboard-Überlappung regeln
    @objc func keyboardWillShow(notification: NSNotification){
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 && passwordTF.isFirstResponder {
                self.view.frame.origin.y -= keyboardSize.height
            }; if self.view.frame.origin.y == 0 && emailTF.isFirstResponder {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}
