//
//  Schedules.swift
//  YYCFoodTrucks-Operator
//
//  Created by apple on 2020-11-09.
//

import SwiftUI

struct Schedules: View {
    var schedules: [Schedule]
    @ObservedObject var OperatorRepo = OperatorRepository()
    @ObservedObject var ScheduleRepo = ScheduleRespository()
//    var trucks: [Truck]
    var locations: [Location]
    
    var body: some View {
        NavigationView{
            ScrollView{
                HStack{
                    Spacer()
                    VStack{
                        ForEach(OperatorRepo.operator_trucks){ truck in
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
                                VStack(alignment: .center){
                                    ForEach(self.schedules){schedule in
                                        if (schedule.truckId == truck.id && schedule.closeDate > Date()){
                                            var location = findLocation(schedule: schedule, locations: locations)
                                            if (location != nil){
                                                VStack(alignment: .center){
                                                    HStack{
                                                        Text(location!.address)
                                                            .foregroundColor(primColor)
                                                        Button(action: {ScheduleRepo.deleteSchedule(schedule: schedule)}){
                                                            Image(systemName: "minus.circle.fill")
                                                                .foregroundColor(.red)
                                                        }
                                                        .padding(.leading, 7)
                                                    }
                                                    .padding(.leading, 5)
                                                    let schedule = generateStringDate(schedule: schedule)
                                                    Text(schedule.0)
                                                    Text("To")
                                                    Text(schedule.1)
                                                }
                                            }
                                        }
                                    }
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

func findLocation(schedule: Schedule, locations: [Location]) -> Location?{
    for location in locations{
        if (location.locationId! == schedule.locationId){
            return location
        }
    }
    return nil
}

func generateStringDate(schedule: Schedule) -> (String,String)
{
    let stringDate = DateFormatter()
    stringDate.dateFormat = "MM/dd/yyyy, HH:MM a"
    
    let openDate = stringDate.string(from: schedule.openDate)
    let closeDate = stringDate.string(from: schedule.closeDate)
    
    return (openDate, closeDate)
    
}
/*
struct Schedules_Previews: PreviewProvider {
    static var previews: some View {
        Schedules()
    }
}*/


