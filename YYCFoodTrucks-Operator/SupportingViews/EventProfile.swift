//
//  EventProfile.swift
//  YYCFoodTrucks-Operator
//
//  Created by Bojana on 2020-11-28.
//

import Foundation
import SwiftUI

struct EventProfile: View {
    
    var event: Event
    
    
    var body: some View {
        ScrollView{
            FirebaseImage(id:(event.logo), width: Int(UIScreen.main.bounds.width), height: 300)
            VStack(alignment: .leading){
                    Group{
                        Text(event.name)
                            .font(.title)
                            .bold()
                        Spacer()
                        Text("Event Location")
                            .font(.system(size:25))
                            .bold()
                        Text(event.location)
                        Spacer()
                        Text("Event Date and Time")
                            .font(.system(size:25))
                            .bold()
                        HStack(){
                            Text(event.eventDate)
                            Text(" | ")
                            Text(event.eventTime)
                        }
                        Spacer()
                        Text("About the Event")
                            .font(.system(size:25))
                            .bold()
                        Text(event.description)
                     }
                    }
                .padding(.leading, 10)
                .padding(.trailing, 10)
        }
      }
    }





