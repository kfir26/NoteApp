//
//  Router.swift
//  NoteApp
//
//  Created by כפיר פנירי on 31/03/2022.
//

import UIKit
import FirebaseAuth


class Router {
    weak var window:UIWindow?
    
    var isLoggedIn:Bool{
        return Auth.auth().currentUser != nil
    }
    static let shared = Router()
    
    private init (){}
    
    func chooseMainViewController(){
        
        guard Thread.current.isMainThread else{
            DispatchQueue.main.async {[weak self] in
                self?.chooseMainViewController()
            }
            
            return
        }
        
        let fileName = isLoggedIn ? "Main" : "Login"
        let sb = UIStoryboard(name: fileName, bundle: .main)
        
        window?.rootViewController = sb.instantiateInitialViewController()
        
        
    }
    
}
