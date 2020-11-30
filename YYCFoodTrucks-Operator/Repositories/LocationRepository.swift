//
//  LandMarkRepository.swift
//  YYCFoodTrucks-Operator
//
//  Created by Teddy Kalp on 2020-11-04.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import CoreLocation

class LocationRepository: ObservableObject{
    private let db = Firestore.firestore()
    @Published var landmarks = [Location]()
    
    init() {
        self.loadData()
    }
    
    func loadData(){
        db.collection("LandMarks").addSnapshotListener{(querySnapshot, error) in
            guard let documents = querySnapshot?.documents else{
                print("No Documents")
                return
            }
            self.landmarks = documents.map{(queryDocumentSnapshot) -> Location in
                let data = queryDocumentSnapshot.data()
                let address = data["address"] as? String ?? ""
                let latitude = data["latitude"] as? Double ?? 0
                let longitude = data["longitude"] as? Double ?? 0
                let locationId = queryDocumentSnapshot.documentID as? String ?? ""
                
                let location = Location(address: address, latitude: latitude, longitude: longitude)
                location.locationId = locationId
                return location
            }
        }
    }
    
// function to convert an address to coordinatess
    func convertAddressToCoordinatesAndStore(address: String, id: String){
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) {
            placemarks, error in
            let placemark = placemarks?.first
            let lat = placemark?.location?.coordinate.latitude
            let lon = placemark?.location?.coordinate.longitude
            var locationInDB = false
            // check to see if we have the location in the database
            for landmark in self.landmarks{
                print(landmark.address)
                print(landmark.latitude)
                print(landmark.longitude)
                if (landmark.latitude) == lat && (landmark.longitude == lon){
                    locationInDB = true
                    break
                }
                else{
                    continue
                }
            }
            // if the location is not in the database, store it
            if (!locationInDB){
                do{
                    let landmarkToAdd = Location(address: address, latitude: lat!, longitude: lon!)
                    let _ = try self.db.collection("LandMarks").document(id).setData(from: landmarkToAdd)
                } catch {
                    fatalError("Unable to encode task: \(error.localizedDescription)")
                }
                
            }
        }
    }
    
    func findLocation(schedule: Schedule) -> Location?{
        for location in landmarks{
            if (location.locationId == schedule.locationId){
                return location
            }
        }
        return nil
    }
}

func randomString(length: Int) -> String {
  let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
  return String((0..<length).map{ _ in letters.randomElement()! })
}



