//
//  TruckList.swift
//  YYCFoodTrucks-Operator
//
//  Created by apple on 2020-11-08.
//

import SwiftUI

struct TruckList: View {
    var locations: [LandMark]
    var schedules: [Schedule]
    var trucks: [Truck]
    
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
                        .frame(width: 400, height: 200)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                        
                    }
                }
                .navigationBarTitle("My Trucks")
                .navigationBarItems(trailing:
                    Group{
                    NavigationLink(destination: NewTruck()){
                        Text("Add Truck")
                    }
                    }
                )
                Spacer()
            }
        }
        
    }
    func AddTruck(){
        print("Navigate from here to add truck page")
    }
}
/*
struct TruckList_Previews: PreviewProvider {
    static var previews: some View {
        TruckList()
    }
}*/
