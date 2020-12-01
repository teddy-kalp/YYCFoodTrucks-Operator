//
//  UserProfile.swift
//  YYCFoodTrucks-Operator
//
//  Created by apple on 2020-11-09.
//

import SwiftUI

struct UserProfile: View {
    @EnvironmentObject var session: SessionStore
    @ObservedObject var OperatorRepo = OperatorRepository()
    var body: some View {
        Text("Signed in as \(OperatorRepo.userName)")
        Text(OperatorRepo.email)

        Button(action: signOut) {
            Text("Sign Out")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.red)
                .cornerRadius(15.0)
        }
    }
    
    func signOut(){
        let result = session.signOut()
        print("Logged out? ", result)
    }
    
}


struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
