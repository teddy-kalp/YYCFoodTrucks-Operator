//
//  TruckRepository.swift
//  YYCFoodTrucks-Operator
//
//  Created by Teddy Kalp on 2020-11-04.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class TruckRespository: ObservableObject{
    @Published var trucks = [Truck]()
    private let db = Firestore.firestore()
    
    init(){
        self.loadData()
    }
    
    public func loadData(){
        db.collection("TruckList").order(by: "name").addSnapshotListener{(querySnapshot, error) in
            guard let documents = querySnapshot?.documents else{
                print("No Documents")
                return
            }
            self.trucks = documents.map{(queryDocumentSnapshot) -> Truck in
                let data = queryDocumentSnapshot.data()
                
                let name = data["name"] as? String ?? ""
//                let id = data["id"] as? Int ?? -1
                let id = queryDocumentSnapshot.documentID; // This gets the firebase id of the truck
                let logo = data["logo"] as? String ?? ""
                let category_id = data["categoryId"] as? Int ?? -1
                let menu = data["menu"] as? String ?? ""
                let description = data["description"] as? String ?? ""

                let truck = Truck(name: name, logo: logo, category_id: category_id, menu: menu, description: description)
                truck.id = id
                return truck
            }
        }
    }
    
    public func addTruck(truck: Truck, truck_id: String){
        do{
            let _ = try self.db.collection("TruckList").document(truck_id).setData(from: truck)
        }
        catch{
            fatalError("Unable to encode task: \(error.localizedDescription)")
        }
    }
}
    

