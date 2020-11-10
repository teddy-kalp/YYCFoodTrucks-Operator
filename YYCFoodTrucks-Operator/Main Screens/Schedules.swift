//
//  Schedules.swift
//  YYCFoodTrucks-Operator
//
//  Created by apple on 2020-11-09.
//

import SwiftUI

struct Schedules: View {
    var schedules: [Schedule]
    var trucks: [Truck]
    
    var body: some View {
        NavigationView{
            ScrollView{
                HStack{
                    Spacer()
                    VStack{
                        ForEach(self.trucks){ truck in
                            VStack(alignment: .leading){
                                HStack{
                                    Text(truck.name)
                                        .font(.headline)
                                    Spacer()
                                    NavigationLink(destination: NewSchedule(truck: truck)){
                                        Text("Add Schedule")
                                    }
                                }
                                Divider()
                                HStack(alignment: .center){
                                    Spacer()
                                    Text("No Schedules")
                                    Spacer()
                                }
                            }.padding(.bottom, 30)
                            .padding(.top, 15)
                            
                            /*ForEach(self.schedules){ schedule in
                                Text(schedule.locationId)
                            }*/
                            /*ForEach(self.schedules){ schedule in
                                if(truck.id == schedule.truckId){
                                    HStack{
                                        //Text(schedule.openDate.)
                                        Text(schedule.locationId)
                                    }
                                }
                            }*/
                        }
                    }
                    Spacer()
                }.padding()
            }.navigationTitle("Schedules")
        }
    }
}
/*
struct Schedules_Previews: PreviewProvider {
    static var previews: some View {
        Schedules()
    }
}*/


