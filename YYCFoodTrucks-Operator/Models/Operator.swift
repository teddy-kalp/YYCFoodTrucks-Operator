//
//  Operator.swift
//  YYCFoodTrucks-Operator
//
//  Created by Teddy Kalp on 2020-11-04.
//

import Foundation

class Operator: Identifiable, Codable{
    var id: Int
    var password: String
    var trucks: [Truck]
    
    init(id: Int, password: String, trucks: [Truck]){
        self.id = id
        self.password = password
        self.trucks = trucks
    }
}
