//
//  LoginViewController.swift
//  NoteApp
//
//  Created by כפיר פנירי on 31/03/2022.
//

import UIKit
import FirebaseAuth


class LoginViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func loginTap(_ sender: UIButton) {
        guard isEmailValid && isPasswordValid ,
              let email = email.text ,
              let password = password.text
        else{return}
        
        showProgress(title: "Please Wait...")
        
        sender.isEnabled = false
        
        Auth.auth().signIn(withEmail: email, password: password) {[weak self] (result, error) in
            guard let _ = result else{
                let errorMessage  = error?.localizedDescription ?? "Unknown Error"
                self?.showError(title: errorMessage)
                sender.isEnabled  = true
                return
            }
            
            self?.showSuccses()
            Router.shared.chooseMainViewController()
        }
    }
    
    @IBAction func dontHaveAccountTap(_ sender: Any){
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "signUp")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
}
