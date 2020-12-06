//
//  Schedule.swift
//  YYCFoodTrucks-Operator
//
//  Created by Teddy Kalp on 2020-11-04.
//

import Foundation
class Schedule: Identifiable, Codable {
    
    var locationId: String
    var truckId: String
    var openDate: Date
    var closeDate: Date
    var scheduleId: String?
    
    init(locationId: String, truckId: String, openDate: Date, closeDate: Date){
        self.locationId = locationId
        self.truckId = truckId
        self.openDate = openDate
        self.closeDate = closeDate
    }
    
}
