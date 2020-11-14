//
//  OperatorRepository.swift
//  YYCFoodTrucks-Operator
//
//  Created by Teddy Kalp on 2020-11-04.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class OperatorRepository: ObservableObject{
    @Published var operators = [Operator]()
    @Published var operator_trucks = [Truck]()
    // will be used to find the trucks for the operator
    @ObservedObject var TruckRepo = TruckRespository()
    private let db = Firestore.firestore()
    @EnvironmentObject var session: SessionStore
    var user = Auth.auth().currentUser
    
    init(){
        loadData()
    }
    
    func loadData(){
        print("opertor rep loading")
        if(user != nil){
            db.collection("Operators").document(user!.uid).addSnapshotListener{(querySnapshot, error) in
                if(querySnapshot?.exists != nil){
                    print("Got operator information", querySnapshot!.data())
                    let name = querySnapshot!.get("name") as! String ?? "null"
                    let truckIds = querySnapshot!.get("truck_ids") as! [String] ?? [""]
                    self.operators.removeAll()
                    
                    for truckId in truckIds{
                        for truck in self.TruckRepo.trucks{
                            print(truckId)
                            print(truck.id)
                            if (truckId == truck.id){
                                self.operator_trucks.append(truck)
                                break
                            }
                        }
                    }
                }
            }
        }
    }
}
