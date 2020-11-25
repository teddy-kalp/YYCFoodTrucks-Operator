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
                    let data = querySnapshot?.data()
                    print("Got operator information (name)", querySnapshot!.get("name"))
                    print("Got operator information (truck_ids)", querySnapshot!.get("truck_ids"))
                    self.operators.removeAll()
                    self.operator_trucks.removeAll()
                    
                    if (querySnapshot!.get("name") as? String ?? "null") != nil{
                        print("got name")
                    }
                    
                    if let truck_Ids = querySnapshot!.get("truck_ids") as? [String]{
                        for truckId in truck_Ids{
                            let trimmedId = truckId.trimmingCharacters(in: .whitespacesAndNewlines)
                            for truck in self.TruckRepo.trucks{
                                print(trimmedId)
                                print(truck.id)
                                if (trimmedId == truck.id){
                                    self.operator_trucks.append(truck)
                                    break
                                }
                            }
                        }
                        //truckIds = querySnapshot!.get("truck_ids") as! [String] ?? [""]
                        print("String array..")
                    } else {
                        print("Not a string array?")
                    }
                }
            }
        }
    }
    
    public func addTruck(truck_id: String){
        var truck_ids = [String]()
        for truck in operator_trucks{
            truck_ids.append(truck.id!)
        }
        truck_ids.append(truck_id)
        db.collection("Operators").document(user!.uid).updateData(["truck_ids": truck_ids])
        //print("The Operator ID is \(user!.uid)")
    }
}
