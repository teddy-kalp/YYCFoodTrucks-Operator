//
//  FoodCategoryRepository.swift
//  YYCFoodTrucks-Operator
//
//  Created by Teddy Kalp on 2020-11-04.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class FoodCategoryRepository: ObservableObject{
    @Published var foodCategories = [FoodCategory]()
    private let db = Firestore.firestore()
    
    init(){
        self.loadData()
    }
    
    func loadData(){
        db.collection("FoodCategories").order(by: "name").addSnapshotListener{(querySnapshot, error) in
            guard let documents = querySnapshot?.documents else{
                print("No Documents")
                return
            }
            self.foodCategories = documents.map{(queryDocumentSnapshot) -> FoodCategory in
                let data = queryDocumentSnapshot.data()
                let name = data["name"] as? String ?? ""
                let id = data["id"] as? Int ?? -1
                let img = data["img"] as? String ?? ""
                return FoodCategory(name: name, id: id, img: img)
            }
        }
    }
}
    
