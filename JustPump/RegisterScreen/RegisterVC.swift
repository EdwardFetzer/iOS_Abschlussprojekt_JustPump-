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
        
        setUpElements()
        
    }
    
    func setUpElements() {
        errorLBL.alpha = 0
        Utilities.styleTextField(nameTF)
        Utilities.styleTextField(emailTF)
        Utilities.styleTextField(passwordTF)
        Utilities.styleTextField(passwordRepareTF)
    }
    
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
    
    func showError(_ message:String) {
        
        errorLBL.text = message
        errorLBL.alpha = 1
    }
    
    
    
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
                    self.showError("E-Mail Adresse existiert bereits")
                } else {
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
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
