//
//  FoodCategory.swift
//  YYCFoodTrucks-Operator
//
//  Created by Teddy Kalp on 2020-11-04.
//

import Foundation

class FoodCategory: Identifiable, Codable {
    var name: String
    var id: Int
    var img: String
    
    init(name: String, id: Int, img: String) {
        self.name = name
        self.id = id
        self.img = img
    }
}
