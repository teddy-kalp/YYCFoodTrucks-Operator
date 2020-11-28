//
//  EventSchedule.swift
//  YYCFoodTrucks-Operator
//
//  Created by Bojana on 2020-11-28.
//

import Foundation
class EventSchedule: Identifiable, Codable {
    
    var locationId: String
    var eventId: Int
    var openDate: Date
    var closeDate: Date
    
    init(locationId: String, eventId: Int, openDate: Date, closeDate: Date){
        self.locationId = locationId
        self.eventId = eventId
        self.openDate = openDate
        self.closeDate = closeDate
    }
}
