//
//  SignInView.swift
//  YYCFoodTrucks-Operator
//
//  Created by apple on 2020-11-08.
//

import SwiftUI

struct SignInView : View {

    @State var email: String = ""
    @State var password: String = ""
    @State var loading = false
    @State var error = false

    @EnvironmentObject var session: SessionStore
    let screenSize = UIScreen.main.bounds

    
    func signIn () {
        loading = true
        error = false
        session.signIn(email: email, password: password) { (result, error) in
            self.loading = false
            if error != nil {
                self.error = true
            } else {
                self.email = ""
                self.password = ""
            }
        }
    }

    var body: some View {
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        HStack{
            Spacer()
            VStack(spacing: 15) {
                Image("yycfood")
                  .resizable()
                  .frame(width: 200, height: 200)
                  //.shadow(radius: 10)
                    .padding(.bottom, 50)
                    .padding(.top, 30)
            
                Text("Operator Login")
                  .font(.largeTitle).foregroundColor(Color.black)
                  .padding([.bottom], 70)
                TextField("Email", text: $email/*, placeholder: Text("email address")*/)
                    .font(.headline)
                    .frame(width: 300)
                    .padding(.bottom, 10)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                SecureField("Password", text: $password/*, placeholder: Text("Password")*/)
                    .frame(width: 300)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                if (error) {
                    Text("Email/Password Incorrect")
                }
                Button(action: signIn) {
                    Text("Sign in")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black)
                        .cornerRadius(15.0)
                }
                Spacer()
            }
            Spacer()
        }
        .frame(minWidth: screenWidth, maxWidth: screenWidth, minHeight: screenHeight, maxHeight: screenHeight, alignment: .topLeading)
        .background(
          LinearGradient(gradient: Gradient(colors: [primColor, .gray]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all))
    }
}
