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

class LandMarkRespository: ObservableObject{
    private let db = Firestore.firestore()
    @Published var landmarks = [LandMark]()
    
    init() {
        self.loadData()
        //convertAddressToCoordinatesAndStore(address: "814 4 Ave NW, Calgary AB")
    }
    
    func loadData(){
        db.collection("LandMarks").order(by: "locationId").addSnapshotListener{(querySnapshot, error) in
            guard let documents = querySnapshot?.documents else{
                print("No Documents")
                return
            }
            self.landmarks = documents.map{(queryDocumentSnapshot) -> LandMark in
                let data = queryDocumentSnapshot.data()
                
                
                let address = data["address"] as? String ?? ""
                let latitude = data["latitude"] as? Double ?? 0
                let longitude = data["longitude"] as? Double ?? 0
                let locationId = data["locationId"] as? Int ?? -1
                
                return LandMark(address: address, latitude: latitude, longitude: longitude, locationId: locationId)
            }
        }
    }
    
// function to convert an address to coordinatess
    func convertAddressToCoordinatesAndStore(address: String){
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) {
            placemarks, error in
            let placemark = placemarks?.first
            let lat = placemark?.location?.coordinate.latitude
            let lon = placemark?.location?.coordinate.longitude
            var locationInDB = false
            // check to see if we have the location in the database
            for landmark in self.landmarks{
                if (landmark.latitude) == lat && (landmark.longitude == lon){
                    locationInDB = true
                    break
                }
            }
            // if the location is not in the database, store it
            if (!locationInDB){
                do{
                    let newId = self.landmarks[self.landmarks.count-1].locationId + 1
                    let landmarkToAdd = LandMark(address: address, latitude: lat!, longitude: lon!, locationId: newId)
                    let _ = try self.db.collection("LandMarks").addDocument(from: landmarkToAdd)
                } catch {
                    fatalError("Unable to encode task: \(error.localizedDescription)")
                }
                
            }
        }
    }
}



