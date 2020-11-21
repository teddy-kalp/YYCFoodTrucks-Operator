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
                Text("Add a Truck")
                    .font(.title)
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
        else if (truckName == ""){
            error = true
            print("Name is empty")
            return
        }
        else if (description == ""){
            error = true
            print("Description is empty")
            return
        }
        else{
            error = false
            print("All Fields Filled")
        }
        
        // updating the url where we want to upload the image data
        let bannerUrl = "TruckBanners/\(truckName)Banner.jpeg"
        let truckUrl = "TruckLogos/\(truckName)Logo.jpeg"
        let menuUrl = "Menus/\(truckName)Menu.jpeg"
        
        // uploading the images to firebase
        // need to figure this out a little better
        let storage = Storage.storage()
        var ref = storage.reference().child(bannerUrl)
        ref.putData((bannerImage?.jpegData(compressionQuality: 0.3))!)
        
        ref = storage.reference().child(truckUrl)
        ref.putData((truckImage?.jpegData(compressionQuality: 0.3))!)
        
        ref = storage.reference().child(menuUrl)
        ref.putData((menuImage?.jpegData(compressionQuality: 0.3))!)
        
        let addedTruck = Truck(name: truckName, logo: truckUrl, category_id: category, menu: menuUrl, description: description)
        
        // need to build this function
        let truck_id = randomString(length: 20)
        
        truckRepo.addTruck(truck: addedTruck, truck_id: truck_id)
        //need to build this function
        operatorRepo.addTruck(truck_id: truck_id)
    }
}

struct addTruck: View{
    @State var text = "Choose From List of Trucks"
    
    @ObservedObject var truckRepo = TruckRespository()
    @ObservedObject var operatorRepo = OperatorRepository()
    @State var selectedTruck = fillerTruck
    @State var selected = false
    
    var body: some View{
        ScrollView{
            Text("Choose Truck")
                .font(.title)
            ForEach(truckRepo.trucks){truck in
                Button(action: {
                    selectedTruck = truck
                    selected = true
                }){
                    HStack{
                        FirebaseImage(id:(truck.logo), width: Int(UIScreen.main.bounds.width/4), height: 175/2)
                        Text(truck.name)
                            .font(.system(size: 24))
                            .foregroundColor(.black)
                        if (selectedTruck.id == truck.id){
                            Image(systemName: "checkmark.circle")
                                .foregroundColor(primColor)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width, height: 200)
                    .padding(.bottom, -10)
                    .border(primColor, width: 1)
                }
            }
            if (selected){
                Button(action: {
                    operatorRepo.addTruck(truck_id: selectedTruck.id!)
                }){
                    Text("Add Truck")
                        .font(.title)
                        .border(primColor, width: 1)
                        .shadow(radius: 5)
                }
            }
        }
    }
}

