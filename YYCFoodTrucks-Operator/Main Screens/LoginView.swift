//
//  ContentView.swift
//  YYCFoodTrucks-Operator
//
//  Created by Teddy Kalp on 2020-11-04.
//

import SwiftUI
struct LoginView: View {
    @ObservedObject var OperatorRepo = OperatorRepository()
    @ObservedObject var LocationRepo = LandMarkRespository()
    @ObservedObject var ScheduleRepo = ScheduleRespository()
    @ObservedObject var TruckRepo = TruckRespository()
    
    
    
    @EnvironmentObject var session: SessionStore
    
    @State private var userId = ""
    @State private var password = ""
    
    var body: some View {
        VStack() {
            if(session.session != nil){
                switch(session.cur_page){
                case nav.Trucks:
                    TruckList(locations: LocationRepo.landmarks, schedules: ScheduleRepo.schedules, trucks: TruckRepo.trucks)
                case nav.Schedule:
                    Schedules()
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
    
    func authenticateUser(id: Int, password: String) -> Operator?{
        for op in OperatorRepo.operators{
            if (op.id == id && op.password == password){
                return op
            }
        }
        return nil
    }
    
}
