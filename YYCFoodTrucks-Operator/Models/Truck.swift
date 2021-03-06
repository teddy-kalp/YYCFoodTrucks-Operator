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
    var id: String?
    var open = false
    var logo: String
    var categoryId: Int //Foreign key of category.id
    
    var menu: String
    var description: String
    
    init(name: String, logo: String, category_id: Int, menu: String, description: String) {
        self.name = name
        self.logo = logo
        self.categoryId = category_id
        self.menu = menu
        self.description = description
    }
}
