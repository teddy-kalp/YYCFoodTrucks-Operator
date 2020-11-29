//
//  ContentView.swift
//  YYCFoodTrucks-Operator
//
//  Created by Teddy Kalp on 2020-11-04.
//

import SwiftUI
struct LoginView: View {
    @ObservedObject var OperatorRepo = OperatorRepository()
    @ObservedObject var LocationRepo = LocationRepository()
    @ObservedObject var ScheduleRepo = ScheduleRespository()
    @ObservedObject var TruckRepo = TruckRespository()
    @ObservedObject var EventRepo = EventRespository()
    
    
    
    @EnvironmentObject var session: SessionStore
    
    @State private var userId = ""
    @State private var password = ""
    
    var body: some View {
        VStack() {
            if(session.session != nil){
                switch(session.cur_page){
                case nav.Trucks:
                    TruckList(locations: LocationRepo.landmarks, schedules: ScheduleRepo.schedules, trucks: OperatorRepo.operator_trucks, events: EventRepo.events)
                case nav.Schedule:
                    Schedules(schedules: ScheduleRepo.schedules, trucks: OperatorRepo.operator_trucks)
                case nav.Profile:
                    UserProfile()
                }
                Spacer()
                Divider()
                    .foregroundColor(Color.gray)
                NavBar(cur_page: session.cur_page)
            } else{
                SignInView()
            }
        }
        .onAppear(perform: {session.listen()})
            
            
    }
    
}
