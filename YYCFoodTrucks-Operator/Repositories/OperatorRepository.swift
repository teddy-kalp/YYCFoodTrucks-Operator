//
//  OperatorRepository.swift
//  YYCFoodTrucks-Operator
//
//  Created by Teddy Kalp on 2020-11-04.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

class OperatorRepository: ObservableObject{
    @Published var operators = [Operator]()
    // will be used to find the trucks for the operator
    @ObservedObject var TruckRepo = TruckRespository()
    private let db = Firestore.firestore()
    
    init(){
        loadData()
    }
    
    func loadData(){
        db.collection("Operators").addSnapshotListener{(querySnapshot, error) in
            guard let documents = querySnapshot?.documents else{
                print("No Users Found")
                return
            }
            self.operators = documents.map{(queryDocumentSnapshot) -> Operator in
                let data = queryDocumentSnapshot.data()
                let id = data["OperatorId"] as? Int ?? -1
                let password = data["password"] as? String ?? "XXXXX"
                let truckIds = data["truckIds"] as? [Int] ?? [Int]()
                
                var trucks = [Truck]()
                
                for truckId in truckIds{
                    for truck in self.TruckRepo.trucks{
                        if (truckId == truck.id){
                            trucks.append(truck)
                            break
                        }
                    }
                }
                
                return Operator(id: id, password: password, trucks: trucks)
            }
        }
    }
    
    
}
