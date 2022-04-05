//
//  UserDetailsViewController.swift
//  NoteApp
//
//  Created by כפיר פנירי on 27/03/2022.
//

import UIKit
import CoreData
import ChameleonFramework
import Lottie
import Kingfisher


class UserDetailsViewController: UIViewController{
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    
    var users:User?
    var delegate: UserDataChangeDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAll()
        myBackGroundStyle()
    }
    
    func setAll(){
        
        labelName.text = "\(users?.first_name ?? "") \(users?.last_name ?? "")"
        email.text = users?.email
        gender.text = users?.gender
        
        guard let profile = users?.avatar else {return}
        if let url = URL(string: profile){
            avatar.kf.setImage(with: url)
            avatar.clipsToBounds = true
        }
    }
    
    func myBackGroundStyle(){
        let colors:[UIColor] = [
            UIColor.magenta,
            UIColor.flatSkyBlueColorDark()]
        view.backgroundColor = UIColor(gradientStyle: UIGradientStyle.topToBottom,withFrame: view.frame, andColors:colors)
    }
    
}
