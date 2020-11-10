//
//  Operator.swift
//  YYCFoodTrucks-Operator
//
//  Created by Teddy Kalp on 2020-11-04.
//

import Foundation

class Operator: Identifiable, Codable{
    var name: String
    var trucks: [Truck]
    
    init(name: String, trucks: [Truck]){
        self.name = name
        self.trucks = trucks
    }
}
