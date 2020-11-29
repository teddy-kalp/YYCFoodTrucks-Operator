//
//  Event.swift
//  YYCFoodTrucks-Operator
//
//  Created by Bojana on 2020-11-28.
//

import Foundation
import FirebaseFirestore

//Load image from url
class Event: Identifiable, Codable {
    
    var name: String
    var id: Int
    var open = false
    var logo: String
    var eventDate: String
    var eventTime: String
    var description: String
    var location: String
    
    init(name: String, id: Int, logo: String, eventDate: String, eventTime: String, description: String, location: String) {
        self.name = name
        self.id = id
        self.logo = logo
        self.eventDate = eventDate
        self.eventTime = eventTime
        self.description = description
        self.location = location
    }
}
