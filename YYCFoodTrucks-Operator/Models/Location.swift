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
    var locationId: Int
    
    init(address: String, latitude: Double, longitude: Double, locationId: Int) {
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.locationId = locationId;
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


let testLocations = [
    Location(address: "2500 University Avenue, Calgary, AB T2N1N4", latitude: 51.076340, longitude:-114.131520, locationId: 0),
    Location(address: "819 4 Avenue NW, Calgary, AB", latitude: 51.057700, longitude: -114.082170, locationId: 1),
    Location(address: "1527 23 Street NW, Calgary, AB T2N2P6", latitude: 51.066000, longitude: -114.116850, locationId: 2)
]





