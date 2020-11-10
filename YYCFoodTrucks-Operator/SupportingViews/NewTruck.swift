//
//  NewTruck.swift
//  YYCFoodTrucks-Operator
//
//  Created by apple on 2020-11-09.
//

import SwiftUI



struct NewTruck: View {
    @State var truckName: String = ""
    @State var description: String = ""
    
    var body: some View {
        ScrollView{
            VStack(spacing: 20){
                ImagePickerView(width: 250, height: 250, message: "Upload Truck Banner")
                
                ImagePickerView(width: 250, height: 250, message: "Upload Truck Logo")
                
                
                TextField("Truck Name", text: $truckName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 300)
                
                
                
                TextField("Description", text: $description)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 300)
                
                Button(action: addTruckToRepo){
                    Text("SUBMIT")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(primColor)
                        .shadow(radius: 10)
                        .cornerRadius(15.0)
                }
                
            }.frame(width: UIScreen.main.bounds.width)
            Spacer()
        }
    }
    func addTruckToRepo(){
        
    }
}

struct NewTruck_Previews: PreviewProvider {
    static var previews: some View {
        NewTruck()
    }
}
