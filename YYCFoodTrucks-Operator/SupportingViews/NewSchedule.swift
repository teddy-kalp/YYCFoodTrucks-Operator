//
//  NewSchedule.swift
//  YYCFoodTrucks-Operator
//
//  Created by apple on 2020-11-09.
//

import SwiftUI

struct NewSchedule: View {
    @Environment(\.presentationMode) var presentation
    @ObservedObject var LocationRepo = LocationRepository()
    @ObservedObject var ScheduleRepo = ScheduleRespository()
    @State var start = Date()
    @State var end = Date()
    @State var city = ""
    @State var province = ""
    @State var postal = ""
    @State var address = ""
    @State var truck: Truck
    @State var error = false
    
    var body: some View {
        HStack(){
            VStack{
                HStack{
                    Text("Truck")
                    Spacer()
                    Text(truck.name)
                }
                HStack{
                    DatePicker("Start", selection: $start, displayedComponents: [.date, .hourAndMinute])
                }
                HStack{
                    DatePicker("End", selection: $end, displayedComponents: [.date, .hourAndMinute])
                }
                HStack{
                    VStack{
                        TextField("Address*", text: $address)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 150)
                    }
                    Spacer()
                    VStack{
                        TextField("City*", text: $city)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 150)
                    }
                }
                HStack{
                    VStack{
                        TextField("Province*", text: $province)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 150)
                    }
                    Spacer()
                    VStack{
                        TextField("Postal/Zip Code", text: $postal)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 150)
                    }
                    
                }
                Button(action: {
                    addSchedule()
                }){
                    Text("Add Schedule")
                }
                if (error){
                    Text("Please fill out all fields correctly")
                        .foregroundColor(.red)
                }
            }
        }.padding()
    }
    
    func addSchedule(){
        if (self.address == ""){
            error = true
            print("Address is wrong")
        }
        else if (self.city == ""){
            error = true
            print("City is wrong")
        }
        else if (self.province == ""){
            error = true
            print("Province is wrong")
        }
        else{
            let fullAddress = "\(address), \(city) \(province), \(postal)"
            print(fullAddress)
            let locationId = randomString(length: 20)
            LocationRepo.convertAddressToCoordinatesAndStore(address: fullAddress, id: locationId)
            ScheduleRepo.addSchedule(locationId: locationId, truckId: truck.id!, openDate: start, closeDate: end)
            self.presentation.wrappedValue.dismiss()
        }
    }
}

/*
struct NewSchedule_Previews: PreviewProvider {
    static var previews: some View {
        NewSchedule()
    }
}
*/
