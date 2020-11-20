//
//  LandMark.swift
//  YYCFoodTrucks-Operator
//
//  Created by Teddy Kalp on 2020-11-04.
//

import Foundation


class Location: Identifiable, Codable {
    var address: String
    var latitude: Double
    var longitude: Double
    var locationId: String?
    
    init(address: String, latitude: Double, longitude: Double) {
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
    }
}


// used to convert addresses to lats and longs -> still trying to get to work
//func convertToCoords(address: String) -> (CLLocationDegrees, CLLocationDegrees){
//    let geocoder = CLGeocoder()
//    var lat: CLLocationDegrees = 0
//    var lon: CLLocationDegrees = 0
//    geocoder.geocodeAddressString(address){
//        placemarks, error in
//        let placemark = placemarks?.first
//        print(error as Any)
//        lat = placemark?.location?.coordinate.latitude ?? 0
//        print("Lat", placemark?.location?.coordinate.latitude as Any)
//        lon = placemark?.location?.coordinate.longitude ?? 0
//    }
//    print("lat:", lat)
//    print("lon:", lon)
//    return (lat, lon)
//}






