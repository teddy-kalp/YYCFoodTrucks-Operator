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
    var events: [Event]
    @State var menuToggle = false
    
    var body: some View {
        NavigationView(){
            VStack(){
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
                        
                        VStack(alignment:.leading){
                        Text("   My Events")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .alignmentGuide(.leading, computeValue: {d in d[.leading]})
                        
                        ScrollView {
                            ForEach(events){ event in
                                    HStack{
                                        NavigationLink(destination: EventProfile(event: event))
                                        {
                                        FirebaseImage(id:(event.logo), width: Int(UIScreen.main.bounds.width/4), height: 175/2)
                                        VStack{
                                            Text(event.name)
                                                .foregroundColor(.black)
                                                .font(.system(size: 24))
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
                    }
                    .navigationBarTitle("My Trucks")
                    .navigationBarItems(trailing:
                        Group{
                            Spacer()
                            Button(action: {menuToggle.toggle()}){
                                Text("Add Truck..")
                                    .foregroundColor(primColor)
                                }
                            if (menuToggle){
                                HStack{
                                    NavigationLink(destination: NewTruck()){
                                        Text("New Truck")
                                        Image(systemName: "plus.circle")
                                    }
                                    NavigationLink(destination: addTruck()){
                                        Text("Existing Truck")
                                        Image(systemName: "car.2.fill")
                                        
                                    }
                                }
                            }
                            
                            NavigationLink(destination: NewEvent()){
                                    Text("Add Event..")
                                        .foregroundColor(primColor)
                                }
                                
                           
                        }
                    )
                    Spacer()
                }
              }
            }
        }
    }
}

//struct TruckList_Previews: PreviewProvider {
//    static var previews: some View {
//        TruckList()
//    }
//}

