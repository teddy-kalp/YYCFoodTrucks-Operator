//
//  Global.swift
//  YYCFoodTrucks
//
//  Created by Teddy Kalp on 2020-10-29.
//

import Foundation
import SwiftUI
import CoreLocation

// used for the primary colors of our applications

let primColor = Color(red: 0, green: 0.73, blue: 0.6, opacity: 1)
let primColorUI = UIColor(red: 0, green: 0.73, blue: 0.6, alpha: 1)

// variables used for fillers if an object is not found
var fillerTruck = Truck(name: "fillerTruck", id: -1,logo: "null", category_id: -1, menu: "null", description: "null")
var fillerLocation = LandMark(address: "null", latitude: 0, longitude: 0, locationId: -1)

// all data repositories



// need to generate upcoming schedules
func generateUpcomingSchedule(schedules: [Schedule], locations: [LandMark], truck: Truck) -> [String]{
    var scheduleLocations = [String] ()
    
    let hoursMinutes = DateFormatter()
    hoursMinutes.dateFormat = "HH:MM a"
    
    let monthDayYear = DateFormatter()
    monthDayYear.dateFormat = "MMM dd yyyy"
    
    for schedule in schedules{
        if (schedule.openDate > Date() && schedule.truckId == truck.id){
            let openTime = hoursMinutes.string(from: schedule.openDate)
            let openDate = monthDayYear.string(from: schedule.openDate)
            let closeTime = hoursMinutes.string(from: schedule.closeDate)
            
            let sched = "\(openDate) from \(openTime) - \(closeTime)"
            
            for location in locations{
                if (schedule.locationId == location.locationId){
                    scheduleLocations.append("\(location.address)\n\(sched)")
                }
            }
            
        }
    }

    
    return scheduleLocations
}

func generateTodaySchedule(schedules: [Schedule], locations: [LandMark], truck: Truck) -> (String, String){
    var AddressToReturn = ""
    var TimeToReturn = ""
    
    let hoursMinutes = DateFormatter()
    hoursMinutes.dateFormat = "HH:MM a"
    
    for schedule in schedules{
        if (schedule.openDate < Date() && Date() < schedule.closeDate && schedule.truckId == truck.id){
            let openTime = hoursMinutes.string(from: schedule.openDate)
            let closeTime = hoursMinutes.string(from: schedule.closeDate)
            TimeToReturn = "Today \(openTime) - \(closeTime)"
            for location in locations{
                if (schedule.locationId == location.locationId){
                    AddressToReturn = location.address
                    return(TimeToReturn, AddressToReturn)
                }
            }
        }
        
    }
    return (TimeToReturn, AddressToReturn)
}
