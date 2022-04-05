//
//  RegisterViewController.swift
//  NoteApp
//
//  Created by כפיר פנירי on 31/03/2022.
//
//

import UIKit
import FirebaseAuth
import PKHUD

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func signUpTap(_ sender: UIButton) {
        guard isEmailValid && isPasswordValid ,
              let email = email.text ,
              let password = password.text
        else{return}
        
        showProgress(title: "Please Wait...")
        
        sender.isEnabled = false
        
        Auth.auth().createUser(withEmail: email, password: password) {[weak self] (Result, error) in
            guard let result = Result else{
                let errorMessage  = error?.localizedDescription ?? "Unknown Error"
                self?.showError(title: errorMessage)
                sender.isEnabled  = true
                return
            }
            
            let user = result.user
            let profileChangeRequest = user.createProfileChangeRequest()
            profileChangeRequest.commitChanges { (error) in
                if let error = error{
                    let text = error.localizedDescription
                    self?.showError(title: "Register Faild", subTitle: text)
                }else{
                    self?.showSuccses()
                    Router.shared.chooseMainViewController()
                }
            }
        }
        
    }
    
    @IBAction func AlradeyhaveAccountTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "login")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
}

protocol ShowHUD {
    
}

extension ShowHUD{
 
    func showProgress(title: String? = nil ,subTitle: String? = nil){
        HUD.show(.labeledProgress(title: title, subtitle: subTitle))
    }
    
    func showError(title: String? = nil ,subTitle: String? = nil){
        HUD.flash(.labeledProgress(title: title, subtitle: subTitle),delay: 3)
    }

    func showLabel(title: String){
        HUD.flash(.label(title), delay: 1)
    }
    
    func showSuccses(title: String? = nil ,subTitle: String? = nil){
        HUD.flash(.labeledProgress(title: title, subtitle: subTitle), delay: 1)
    }
}

extension UIViewController: ShowHUD{}

protocol UserValidation: ShowHUD {
    var email:UITextField!{get}
    var password:UITextField!{get}
    
}

extension UserValidation{
    var isEmailValid:Bool{
        guard let email = email.text, !email.isEmpty else{
            showLabel(title: "Email must NOT BE EMPTY")
            return false
        }
        return true
    }

    var isPasswordValid:Bool{
        guard let password = password.text, !password.isEmpty else{
            showLabel(title: "password must NOT BE EMPTY")
            return false
        }
        return true
    }
}

extension LoginViewController: UserValidation{}
extension RegisterViewController: UserValidation{}
