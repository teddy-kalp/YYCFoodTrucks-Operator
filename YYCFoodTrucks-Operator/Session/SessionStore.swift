//
//  SessionStore.swift
//  YYCFoodTrucks-Operator
//
//  Created by apple on 2020-11-08.
//

import Foundation
import SwiftUI
import Firebase
import Combine

class SessionStore : ObservableObject {
    var didChange = PassthroughSubject<SessionStore, Never>()
    @Published var session: User? { didSet { self.didChange.send(self) }}
    var handle: AuthStateDidChangeListenerHandle?
    @Published var cur_page = nav.Trucks
    
    func listen () {
        // monitor authentication changes using firebase
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            print("Listener called :)")
            if let user = user {
                // if we have a user, create a new user model
                print("Got user: \(user)")
                print("User_id", user.uid)
                print("User_displayname", user.displayName)
                print("User_email", user.email)
                
                self.session = User(
                    uid: user.uid,
                    displayName: user.displayName,
                    email: user.email
                )
            } else {
                print("Didn't get user")
                // if we don't have a user, set our session to nil
                self.session = nil
            }
        }
    }
    
    func signUp(
        email: String,
        password: String,
        handler: @escaping AuthDataResultCallback
        ) {
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }

    func signIn(
        email: String,
        password: String,
        handler: @escaping AuthDataResultCallback
        ) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
        print("Signing in...", email)
    }

    func signOut () -> Bool {
        do {
            try Auth.auth().signOut()
            self.session = nil
            return true
        } catch {
            return false
        }
    }
    
    func unbind () {
        print("Stopped listening for authentication")
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}
