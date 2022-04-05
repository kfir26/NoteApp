//
//  ViewController.swift
//  NoteApp
//
//  Created by כפיר פנירי on 26/03/2022.
//

import UIKit
import ChameleonFramework
import Kingfisher

class ViewController: UIViewController,UserDataChangeDelegate {
    func dataDidChange(user: User) {
        database.save()
        tableView.reloadData()
    }
    
    @IBOutlet weak var tableView:UITableView!
    let database = DatabaseHandler.shared
    var users: [User]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.users = self.database.fetch(_type: User.self)
        if users!.isEmpty{
            APIHandler.shared.syncUsers {[weak self] (users) in
                guard users != nil else {return}
                self?.users = users
            }
        }
        tableView.tableFooterView = UIView(frame: .zero)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell") as! UserTableViewCell
        cell.user = users?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showUserDetails", sender: users?[indexPath.row])
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showUserDetails" {
            let destVc = segue.destination as! UserDetailsViewController
            destVc.users = sender as? User
            destVc.delegate = self
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            guard let user = users?[indexPath.row] else {return}
            tableView.beginUpdates()
            self.database.delete(object: user)
            users?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
}

class UserTableViewCell: UITableViewCell{
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    
    var user: User? {
        didSet{
            setupData()
        }
    }
    
    private func setupData(){
        guard let user = user else {return}
        if let url = URL(string: user.avatar){
            userImage.kf.setImage(with: url)
            userImage.clipsToBounds = true
        }
        labelName.text = "\(user.first_name) \(user.last_name)"
        
    }

    override func prepareForReuse() {
        userImage.image = nil
    }
}

protocol UserDataChangeDelegate {
    func dataDidChange(user: User)
}
