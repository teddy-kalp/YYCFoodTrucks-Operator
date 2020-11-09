//
//  ContentView.swift
//  YYCFoodTrucks-Operator
//
//  Created by Teddy Kalp on 2020-11-04.
//

import SwiftUI

let primColor = Color(red: 0, green: 0.73, blue: 0.6, opacity: 1)

struct LoginView: View {
    @ObservedObject var OperatorRepo = OperatorRepository()
    @EnvironmentObject var session: SessionStore
    
    @State private var userId = ""
    @State private var password = ""
    
    var body: some View {
        NavigationView{
            VStack() {
                if(session.session != nil){
                    Text("Logged in :)")
                    Button(action: signOut) {
                        Text("Sign Out")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color.red)
                            .cornerRadius(15.0)
                    }
                } else{
                    SignInView()
                }
            }
        }
        .onAppear(perform: {session.listen()})
            
            
    }
    func signOut(){
        let result = session.signOut()
        print("Logged out? ", result)
    }
    
    func authenticateUser(id: Int, password: String) -> Operator?{
        for op in OperatorRepo.operators{
            if (op.id == id && op.password == password){
                return op
            }
        }
        return nil
    }
    
}
