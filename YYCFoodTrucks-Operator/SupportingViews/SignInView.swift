//
//  SignInView.swift
//  YYCFoodTrucks-Operator
//
//  Created by apple on 2020-11-08.
//  revised by Bojana 2020-11-24.
//

import SwiftUI

struct SignInView : View {
    
    @ObservedObject var OperatorRepo = OperatorRepository()
    @State var email: String = ""
    @State var password: String = ""
    @State var loading = false
    @State var error = false
    @State var focusEmail = false
    @State var focusPassword = false

    
    @EnvironmentObject var session: SessionStore
    let screenSize = UIScreen.main.bounds
    @Environment(\.colorScheme) var colorScheme
    let topGrad = Color(red: 0, green: 0.73, blue: 0.6, opacity: 0.5)
    let bottomGrad = Color(red: 0, green: 0.73, blue: 0.6, opacity: 0.2)
    
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
                session.cur_page = nav.Trucks
                OperatorRepo.loadData()

            }
        }
    }
    
    var body: some View {
            NavigationView {
                    let screenWidth = screenSize.width
                    let screenHeight = screenSize.height
                    let light_mode = (colorScheme == .light)
                    HStack{
                        Spacer()
                        VStack(spacing: 5) {
                            //Spacer()
                            Group{
                            Image((light_mode) ? "yycfood" : "yycfood_white")
                              .resizable()
                              .frame(width: 200, height: 200)
                              //.shadow(radius: 10)
                                .padding(.bottom, 30)
                                .padding(.top, 30)
                        
                            Text("Operator Login")
                              .font(.largeTitle)
                              .padding([.bottom], 70)
                            TextField("Email", text: $email)
                                .font(.headline)
                                .frame(width: 300)
                            Rectangle()
                                .fill(Color.gray)
                                .frame(width: 300, height: 2)
                                .padding(.bottom, 25)
                                
                            SecureField("Password", text: $password)
                                .frame(width: 300)
                            Rectangle()
                                .fill(Color.gray)
                                .frame(width: 300, height: 2)
                                .padding(.bottom, 25)
                            
                            if (error) {
                                Text("Email/Password Incorrect")
                            }
                            NavigationLink("forgot password?", destination: PasswordReset())
                                .padding()
                               
                            Button(action: signIn) {
                                Text("Sign in")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(width: 300, height: 50)
                                    .background(primColor)
                                    .shadow(radius: 10)
                                    .cornerRadius(15.0)
                              }
                            }
                        
                            Spacer()
                        }
                        Spacer()
                    }
                
                    .frame(minWidth: screenWidth, maxWidth: screenWidth, minHeight: screenHeight, maxHeight: screenHeight, alignment: .topLeading)
                    .background(
                      LinearGradient(gradient: Gradient(colors: [topGrad, bottomGrad]), startPoint: .top, endPoint: .bottom)
                        .edgesIgnoringSafeArea(.all))
         
       }
    }
}

