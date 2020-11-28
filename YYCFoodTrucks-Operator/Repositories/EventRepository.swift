//
//  EventRepository.swift
//  YYCFoodTrucks-Operator
//
//  Created by admin on 2020-11-28.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

class EventRespository: ObservableObject{
    @ObservedObject var scheduleRepo = EventScheduleRespository()
    @ObservedObject var landmarkRepo = LocationRepository()
    @Published var events = [Event]()
    private let db = Firestore.firestore()
    
    
    
    init(){
        self.loadData()
    }
    
    func loadData(){
        db.collection("EventList").order(by: "name").addSnapshotListener{(querySnapshot, error) in
            guard let documents = querySnapshot?.documents else{
                print("No Documents")
                return
            }
            self.events = documents.map{(queryDocumentSnapshot) -> Event in
                let data = queryDocumentSnapshot.data()
                
                let name = data["name"] as? String ?? ""
                let id = data["id"] as? Int ?? -1
                let logo = data["logo"] as? String ?? ""
                let eventDate = data["eventDate"] as? String ?? ""
                let eventTime = data["eventTime"] as? String ?? ""
                let description = data["description"] as? String ?? ""
                let location = data["location"] as? String ?? ""
                
                let event = Event(name: name, id: id, logo: logo, eventDate: eventDate, eventTime: eventTime, description: description, location: location)
                
                return event
                
            }
        }
    }
    
    public func addEvent(event: Event, event_id: String){
        do{
            let _ = try self.db.collection("EventList").document(event_id).setData(from: event)
        }
        catch{
            fatalError("Unable to encode task: \(error.localizedDescription)")
        }
    }
}
