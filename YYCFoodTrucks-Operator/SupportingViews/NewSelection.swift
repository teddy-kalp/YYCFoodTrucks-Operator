//
//  NewSelection.swift
//  YYCFoodTrucks-Operator
//
//  Created by apple on 2020-12-02.
//

import SwiftUI

struct NewSelection: View {
    var body: some View {
        VStack(spacing: 15){
            Spacer()
            NavigationLink(destination: NewTruck())
            {
                Text("New Truck")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(primColor)
                    .shadow(radius: 10)
                    .cornerRadius(15.0)
                    
            }
            NavigationLink(destination: addTruck())
            {
                Text("Existing Truck")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(primColor)
                    .shadow(radius: 10)
                    .cornerRadius(15.0)
            }
            NavigationLink(destination: NewEvent())
            {
            
                Text("New Event")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(primColor)
                    .shadow(radius: 10)
                    .cornerRadius(15.0)
            }
            Spacer()
        }
    }
}

struct NewSelection_Previews: PreviewProvider {
    static var previews: some View {
        NewSelection()
    }
}
