//
//  ContentView.swift
//  YYCFoodTrucks-Operator
//
//  Created by Teddy Kalp on 2020-11-04.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var OperatorRepo = OperatorRepository()
    
    var body: some View {
        VStack{
            Text("Hello Operator!")
                .padding()
        }
    }
}
