//
//  TruckList.swift
//  YYCFoodTrucks-Operator
//
//  Created by apple on 2020-11-08.
//

import SwiftUI

struct TruckList: View {
    var locations: [Location]
    var schedules: [Schedule]
    var trucks: [Truck]
    @State var menuToggle = false
    
    var body: some View {
        NavigationView(){
            VStack(){
                ScrollView{
                    ForEach(trucks){ truck in
                            HStack{
                                NavigationLink(destination: TruckProfile(truck: truck, schedules: schedules, locations: locations)){
                                FirebaseImage(id:(truck.logo), width: Int(UIScreen.main.bounds.width/4), height: 175/2)
                                VStack{
                                    Text(truck.name)
                                        .foregroundColor(.black)
                                        .font(.system(size: 24))
                                    if (truck.open){
                                        Text("Open Now")
                                        .foregroundColor(primColor)
                                    }
                                    else{
                                        Text("Closed Now")
                                        .foregroundColor(.red)
                                    }
                                }
                                .frame(width: 200, height: 200, alignment: .center)
                            }
                        }
                        .frame(width: 400, height: 150)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                    }
                }
                .navigationBarTitle("My Trucks")
                .navigationBarItems(trailing:
                    Group{
                        Button(action: {menuToggle.toggle()}){
                            Text("Add Truck..")
                                .foregroundColor(primColor)
                            }
                        if (menuToggle){
                            NavigationLink(destination: NewTruck()){
                                Text("Existing Truck")
                                Image(systemName: "plus.circle")
                            }
                            NavigationLink(destination: addTruck()){
                                Text("New Truck")
                                Image(systemName: "car.2.fill")
                                
                            }
                        }
                    }
                )
                Spacer()
            }
        }
        
    }
}

//struct TruckList_Previews: PreviewProvider {
//    static var previews: some View {
//        TruckList()
//    }
//}

