//
//  PasswordReset.swift
//  YYCFoodTrucks-Operator
//
//  Created by admin on 2020-11-22.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct PasswordReset: View {
    
    
    @ObservedObject var OperatorRepo = OperatorRepository()
    @EnvironmentObject var session: SessionStore
    @Environment(\.colorScheme) var colorScheme
    @State var user_email: String = ""
    @State var errorText: String = ""
    @State var validOperator: Bool = true
    @State private var showAlert = false

    var body: some View {
            VStack(alignment: .center){
                Text("Enter your account email address")
                    //.font(.callout)
                    .bold()
                    .font(.system(size:18))
                
                TextField("Operator email address", text: $user_email)
                    .font(Font.system(size: 25, design: .default))
                    .frame(width: 300, height: 70)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    Auth.auth().sendPasswordReset(withEmail: user_email, completion: ({ error in
                        if let error = error {
                            self.errorText = error.localizedDescription
                        return
                    }
                }))
                    user_email = " ";
                    self.showAlert = true;
                    
                }) {
                    Text("RESET")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(primColor)
                        .shadow(radius: 10)
                        .cornerRadius(15.0)
                        
                }
                if showAlert {
                    ZStack {
                        Color.white
                        VStack {
                            Text("Password reset email sent - please check your inbox")
                                .padding()
                            Button(action: {
                                self.showAlert = false

                                
                            }, label: {
                                Text("Close")
                            })
                        }.padding()
                    }
                    .frame(width: 300, height: 200)
                    .cornerRadius(20).shadow(radius: 20)
                }
                Spacer()
            } .padding(.top, 50)
                .frame(width: 300)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            .navigationBarTitle("Request Password Reset", displayMode: .inline)
            
                    
        }

}
    
    
    
    




