//
//  ScheduleRepository.swift
//  YYCFoodTrucks-Operator
//
//  Created by Teddy Kalp on 2020-11-04.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class ScheduleRespository: ObservableObject{
    private let db = Firestore.firestore()
    @Published var schedules = [Schedule]()
    
    init() {
        self.loadData()
    }
    
    func loadData(){
        db.collection("Schedules").addSnapshotListener{(querySnapshot, error) in
            guard let documents = querySnapshot?.documents else{
                print("No Documents")
                return
            }
            let sched = documents.filter{$0["openDate"] != nil && $0["closeDate"] != nil}
            self.schedules = sched.map{(queryDocumentSnapshot) -> Schedule in
                let data = queryDocumentSnapshot.data()
                
                print("Got schedule", data)
                
                let openTimestamp = data["openDate"] as? Timestamp ?? nil
                let openDate = openTimestamp!.dateValue()
                let closeTimestamp = data["closeDate"] as? Timestamp ?? nil
                let closeDate = closeTimestamp!.dateValue()
                let locationId = data["locationId"] as? String ?? ""
                let truckId = data["truckId"] as? String ?? ""
                let schedule = Schedule(locationId: locationId, truckId: truckId, openDate: openDate, closeDate: closeDate)
                schedule.scheduleId = queryDocumentSnapshot.documentID
                return schedule
            }
        }
    }
    func addSchedule(locationId: String, truckId: String, openDate: Date, closeDate: Date, schedule_id: String){
        do{
            let scheduleToAdd = Schedule(locationId: locationId, truckId: truckId, openDate: openDate, closeDate: closeDate)
            let _ = try self.db.collection("Schedules").document(schedule_id).setData(from: scheduleToAdd)
        } catch {
            fatalError("Unable to encode task: \(error.localizedDescription)")
        }
    }
    
    func deleteSchedule(schedule: Schedule){
        self.db.collection("Schedules").document(schedule.scheduleId!).delete()
    }
}
