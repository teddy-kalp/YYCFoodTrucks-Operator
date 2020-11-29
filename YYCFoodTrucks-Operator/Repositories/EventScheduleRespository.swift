//
//  EventScheduleRespository.swift
//  YYCFoodTrucks-Operator
//
//  Created by admin on 2020-11-28.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class EventScheduleRespository: ObservableObject{
    private let db = Firestore.firestore()
    @Published var schedules = [EventSchedule]()
    
    init() {
        //removeOldSchedules()
        loadData()
    }
    
    func loadData(){
        db.collection("EventSchedules").addSnapshotListener{(querySnapshot, error) in
            guard let documents = querySnapshot?.documents else{
                print("No Documents")
                return
            }
            self.schedules = documents.map{(queryDocumentSnapshot) -> EventSchedule in
                let data = queryDocumentSnapshot.data()
                
                
                let openTimestamp = data["openDate"] as? Timestamp ?? nil
                let openDate = openTimestamp!.dateValue()
                let closeTimestamp = data["closeDate"] as? Timestamp ?? nil
                let closeDate = closeTimestamp!.dateValue()
                let locationId = data["locationId"] as? String ?? ""
                let eventId = data["eventId"] as? Int ?? -1
                
                return EventSchedule(locationId: locationId, eventId: eventId, openDate: openDate, closeDate: closeDate)
            }
        }
    }
    
    func removeOldSchedules(){
        var idsToRemove = [String]()
        db.collection("EventSchedules").addSnapshotListener{(querySnapshot, error) in
            guard let documents = querySnapshot?.documents else{
                print("No Documents")
                return
            }
            
            for doc in documents{
                let data = doc.data()
                let id = doc.documentID
                let closeTimestamp = data["closeDate"] as? Timestamp ?? nil
                let closeDate = closeTimestamp!.dateValue()
                if (closeDate < Date()){
                    idsToRemove.append(id)
                }
            }
            
            for id in idsToRemove{
                self.db.collection("EventSchedules").document(id).delete()
            }
        }
    }
}
