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
    @State private var userId = ""
    @State private var password = ""
    
    let screenSize = UIScreen.main.bounds
    
    
    
    var body: some View {
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        NavigationView{
                VStack(spacing: 15) {
                    Text("YYC Food Trucks")
                      .font(.largeTitle).foregroundColor(Color.black)
                      .padding([.bottom], 40)
                    
                    Image("yycfood")
                      .resizable()
                      .frame(width: 200, height: 200)
                      .clipShape(Circle())
                      .overlay(Circle().stroke(Color.white, lineWidth: 4))
                      .shadow(radius: 10)
                      .padding(.bottom, 50)
                    
                    TextField("Operator Id", text: self.$userId)
                       .padding()
                       .cornerRadius(20.0)
                        .colorScheme(.light)
                    
                    SecureField("Password", text: self.$password)
                        .padding()
                        .cornerRadius(20.0)
                        .colorScheme(.light)
                    
                    Button(action: {
                        let user = authenticateUser(id: Int(self.userId) ?? -1, password: self.password)
                        if (user != nil){
                            print("User found")
                        }
                        else{
                            print("Invalid User")
                        }
                    }) {
                      Text("Sign In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black)
                        .cornerRadius(15.0)
                    }
                }
                .offset(y:-50)
            }
            
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
