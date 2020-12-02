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
                        TextField("Full Address, including Street, City, Province and Postal Code*", text: $address)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: (UIScreen.main.bounds.width))
                    }
                }
                if (self.address != ""){
                    let fileredAddresses = LocationRepo.landmarks.filter{$0.address.contains(self.address)}
                    ForEach(fileredAddresses){address in
                        Button(action: {
                            self.address = address.address
                        }){
                            Text(address.address)
                                .foregroundColor(.black)
                        }
                    }
                }
                Divider()
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
        else{
            let fullAddress = self.address
            var addressFound = false
            var locationId = randomString(length: 20)
            for location in LocationRepo.landmarks{
                if (location.address == fullAddress){
                    addressFound = true
                    locationId = location.locationId!
                    break
                }
            }
            if (!addressFound){
                LocationRepo.convertAddressToCoordinatesAndStore(address: fullAddress, id: locationId)
            }
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
