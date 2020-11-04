//
//  Truck.swift
//  YYCFoodTrucks-Operator
//
//  Created by Teddy Kalp on 2020-11-04.
//

import Foundation
import FirebaseFirestore

//Load image from url

class Truck: Identifiable, Codable {
    var name: String
    var id: Int
    var open = false
    var logo: String
    var category_id: Int //Foreign key of category.id
    
    var menu: String
    var description: String
    
    init(name: String, id: Int,logo: String, category_id: Int, menu: String, description: String) {
        self.name = name
        self.id = id
        self.logo = logo
        self.category_id = category_id
        self.menu = menu
        self.description = description
    }
}
