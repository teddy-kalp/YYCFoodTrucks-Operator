//
//  NewTruck.swift
//  YYCFoodTrucks-Operator
//
//  Created by apple on 2020-11-09.
//

import SwiftUI
import FirebaseStorage


struct NewTruck: View {
    @ObservedObject var truckRepo = TruckRespository()
    @ObservedObject var operatorRepo = OperatorRepository()
    @State var truckName: String = ""
    @State var description: String = ""
    @State var error: Bool = false
    @State var category = 0
    
    @State var bannerImage: UIImage?
    @State var truckImage: UIImage?
    @State var menuImage: UIImage?

    
    var body: some View {
        let bannerPicker = ImagePickerView(image: self.$bannerImage, width: 250, height: 250, message: "Upload Truck Banner")
        let truckPicker = ImagePickerView(image: self.$truckImage, width: 250, height: 250, message: "Upload Truck Logo")
        let menuPicker = ImagePickerView(image: self.$menuImage, width: 250, height: 250, message: "Upload Menu Image")
        ScrollView{
            VStack(spacing: 20){
                
                bannerPicker
                
                truckPicker
                
                TextField("Truck Name", text: $truckName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 300)
                
                
                
                TextField("Description", text: $description)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 300)
                
                menuPicker
                
                Button(action: addTruckToRepo){
                    Text("SUBMIT")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(primColor)
                        .shadow(radius: 10)
                        .cornerRadius(15.0)
                }
                if (error){
                    Text("Please Fill out all fields")
                        .foregroundColor(.red)
                }
                
            }.frame(width: UIScreen.main.bounds.width)
            Spacer()
        }
    }
    
    
    func addTruckToRepo(){
        // checking to make sure the images are not null
        if (bannerImage == nil){
            error = true
            print("Banner Image is empty")
            return
        }
        else if (truckImage == nil){
            error = true
            print("Truck Image is empty")
            return
        }
        else if (menuImage == nil){
            error = true
            print("Menu Image is empty")
            return
        }
        // updating the url where we want to upload the image data
        let bannerUrl = "TruckBanners/\(truckName)Banner.png"
        let truckUrl = "TruckLogos/\(truckName)Logo.png"
        let menuUrl = "Menus/\(truckName)Menu.png"
        // uploading the images to firebase
        let storage = Storage.storage()
        var ref = storage.reference().child(bannerUrl)
        ref.putData((bannerImage?.pngData())!)
        
        ref = storage.reference().child(truckUrl)
        ref.putData((truckImage?.pngData())!)
        
        ref = storage.reference().child(menuUrl)
        ref.putData((menuImage?.pngData())!)
        
        let addedTruck = Truck(name: truckName, logo: truckUrl, category_id: category, menu: menuUrl, description: description)
        
        // need to build this function
        let truck_id = randomString(length: 20)
        truckRepo.addTruck(truck: addedTruck, truck_id: truck_id)
        // need to build this function
        operatorRepo.addTruck(truck_id: truck_id)
    }
}

struct addTruck: View{
    
    var body: some View{
        Text("Choose From Existing Trucks")
        // dropdown menu of all existing trucks
    }
}

