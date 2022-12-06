//
//  RegisterVC.swift
//  JustPump
//
//  Created by Edward Fetzer on 21.10.22.
//

import UIKit
import Firebase

class RegisterVC: UIViewController {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var passwordRepareTF: UITextField!
    @IBOutlet weak var registerBTN: UIButton!
    @IBOutlet weak var errorLBL: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorLBL.isHidden = true
        errorLBL.sizeToFit()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //Prüft ob alle Felder ausgefüllt sind
    func validateFields() -> String? {
        if nameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordRepareTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Bitte fülle alle Felder aus"
        }
        let checkPwd = passwordTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let checkPwdRep = passwordRepareTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(checkPwd) == false {
            return "Passwort ungültig, Ihr Passwort muss mindestens 8 Zeichen lang sein, ein Sonderzeichen und eine Zahl beinhalten"
        }
        if checkPwd != checkPwdRep {
            return "Passwörter stimmen nicht überein"
        }
        return nil
    }
    
    //Fehler anzeigen lassen
    func showError(_ message:String) {
        errorLBL.isHidden = false
        errorLBL.text = message
        errorLBL.alpha = 1
    }
    
    // Ein neuer User wird erstellt
    @IBAction func registerBTN(_ sender: UIButton) {
        let error = validateFields()
        if error != nil {
            showError(error!)
        }
        else{
            let name = nameTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                if err != nil{
                    self.showError("E-Mail Adresse ist falsch oder existiert bereits")
                } else {
                    //Erstellt einen User im Firestore
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["name":name, "uid": result!.user.uid]) { (error) in
                        if error != nil{
                            self.showError("Error saving user data")
                        }
                    }
                    self.performSegue(withIdentifier: "succesRegistered", sender: nil)
                }
            }
        }
    }
    
    //MARK: Keyboard-Überlappung regeln
    @objc func keyboardWillShow(notification: NSNotification){
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 && nameTF.isFirstResponder {
                self.view.frame.origin.y -= keyboardSize.height
            }; if self.view.frame.origin.y == 0 && emailTF.isFirstResponder {
                self.view.frame.origin.y -= keyboardSize.height
            }; if self.view.frame.origin.y == 0 && passwordTF.isFirstResponder {
                self.view.frame.origin.y -= keyboardSize.height
            }; if self.view.frame.origin.y == 0 && passwordRepareTF.isFirstResponder {
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
