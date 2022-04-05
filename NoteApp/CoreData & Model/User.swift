//
//  User.swift
//  NoteApp
//
//  Created by כפיר פנירי on 26/03/2022.
//

import CoreData

public class User: NSManagedObject{
    
    @NSManaged var avatar:String
    @NSManaged var id: Int16
    @NSManaged var email: String
    @NSManaged var first_name: String
    @NSManaged var last_name: String
    @NSManaged var gender: String
    
}
