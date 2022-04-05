//
//  NoteDetailVC.swift
//  NoteApp
//
//  Created by כפיר פנירי on 28/03/2022.
//

import UIKit
import CoreData

class NoteDetailVC: UIViewController{
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var descriptionTV: UITextView!
    
    var selectedtNote: Note? = nil
    
    override func viewDidLoad() {
        if(selectedtNote != nil){
            titleTF.text = selectedtNote?.title
            descriptionTV.text = selectedtNote?.desc
        }
    }
    
    
    @IBAction func save(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        if(selectedtNote == nil){
            let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
            let newNote = Note(entity: entity!, insertInto: context)
            
            newNote.id = noteList.count as NSNumber
            newNote.title = titleTF.text
            newNote.desc = descriptionTV.text
            do{
                try context.save()
                noteList.append(newNote)
                navigationController?.popViewController(animated: true)
            }
            catch{
                print("context save error")
            }
        }
        else{
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
            do{
                let results:NSArray = try context.fetch(request) as NSArray
                for result in results{
                    let note = result as! Note
                    if (note == selectedtNote){
                        note.title = titleTF.text
                        note.desc = descriptionTV.text
                        try context.save()
                        navigationController?.popViewController(animated: true)
                    }
                }
            }
            catch{
                print(" Sorry Mate, Featch Failed ")
            }
        }
    }
    
    @IBAction func deleteNote(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do{
            let results:NSArray = try context.fetch(request) as NSArray
            for result in results{
                let note = result as! Note
                if (note == selectedtNote) {
                    note.deletedDate = Date()
                    try context.save()
                    navigationController?.popViewController(animated: true)
                }
            }
        }
        catch{
            print(" Sorry Mate, Featch Failed ")
        }
    }
}
