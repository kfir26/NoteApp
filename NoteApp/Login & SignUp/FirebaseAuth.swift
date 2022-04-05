//
//  FirebaseAuth.swift
//  NoteApp
//
//  Created by כפיר פנירי on 30/03/2022.
//

import SwiftUI
import Firebase

struct FirebaseAuth:App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup{
            LoginRegister()
        }
    }
     
}
