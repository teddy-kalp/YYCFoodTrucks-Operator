//
//  NavBar.swift
//  YYCFoodTrucks
//
//  Created by Teddy Kalp on 2020-10-16.
//

// TODO
// Add clauses to change color depending on which screen
// Space icons out better

import SwiftUI
enum nav{
    case Trucks
    case Schedule
    case Profile
}
struct NavBar: View {
    var cur_page: nav
    @EnvironmentObject var session: SessionStore
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack(spacing: 45){
                var baseColor = (colorScheme == .light) ? Color.black : Color.white
            Button(action: {self.session.cur_page = nav.Trucks}){
                    VStack{
                        Image(systemName: "house")
                        .resizable()
                        .frame(width: 25, height: 25)
                            .foregroundColor(cur_page == nav.Trucks ? primColor: baseColor)
                    Text("My Trucks")
                        .foregroundColor(cur_page == nav.Trucks ? primColor: baseColor)
                    }
                    
                }
            Button(action: {self.session.cur_page = nav.Schedule}){
                    VStack{
                        Image(systemName: "calendar")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(cur_page == nav.Schedule ? primColor: baseColor)
                        Text("Schedules")
                            .foregroundColor(cur_page == nav.Schedule ? primColor: baseColor)
                    }
                }
            Button(action: {self.session.cur_page = nav.Profile}){
                    VStack {
                        Image(systemName: "person")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(cur_page == nav.Profile ? primColor: baseColor)
                        Text("Profile")
                            .foregroundColor(cur_page == nav.Profile ? primColor: baseColor)
                    }
                }
            }
        }
}



struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        NavBar(cur_page: nav.Trucks)
    }
}
