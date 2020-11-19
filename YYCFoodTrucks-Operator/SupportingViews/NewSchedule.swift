//
//  NewSchedule.swift
//  YYCFoodTrucks-Operator
//
//  Created by apple on 2020-11-09.
//

import SwiftUI

struct NewSchedule: View {
    @State var start = Date()
    @State var end = Date()
    @State var address = ""
    @State var truck: Truck
    @State var recurring = false
    @State var repeat_option = ""
    
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
                    Text("Address")
                    Spacer()
                    TextField("", text: $address)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 300)
                }
                HStack{
                    Toggle(isOn: $recurring){
                        Text("Recurring")
                    }
                }
                if recurring {
                    VStack{
                        Divider()
                        Picker("Repeats",selection: $repeat_option){
                            Text("Weekly")
                            Text("Daily")
                            Text("Weekdays")
                            Text("Other")
                        }.pickerStyle(DefaultPickerStyle())
                    }
                    
                    
                }
                Spacer()
            }
        }.padding()
        
    }
}
/*
struct NewSchedule_Previews: PreviewProvider {
    static var previews: some View {
        NewSchedule()
    }
}
*/
