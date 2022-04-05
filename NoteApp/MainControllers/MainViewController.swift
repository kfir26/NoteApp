//
//  MainViewController.swift
//  NoteApp
//
//  Created by כפיר פנירי on 27/03/2022.
//

import Foundation
import UIKit
import ChameleonFramework
import Lottie
import FirebaseAuth

class MainViewController: UIViewController{
    
    @IBOutlet weak var animation: UIView!
    @IBOutlet weak var openScreen: AnimationView!
    
    @IBAction func logout(_ sender: UIBarButtonItem) {
        do{
            try Auth.auth().signOut()
            Router.shared.chooseMainViewController()
        }catch let error{
            showError(title: error.localizedDescription)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundColor()
        lottieAnimation()
        
    }
    
    func lottieAnimation(){
        openScreen.frame = view.bounds
        openScreen.animation = Animation.named("41627-boat")
        openScreen.contentMode = .scaleToFill
        openScreen.loopMode = .loop
        openScreen.play()
        view.addSubview(openScreen)
    }
    
    func backgroundColor(){
        let colors:[UIColor] = [
            UIColor.flatPink(),
            UIColor.flatSkyBlue()]
        view.backgroundColor = UIColor(gradientStyle: UIGradientStyle.leftToRight,withFrame: view.frame, andColors:colors)
    }
}
