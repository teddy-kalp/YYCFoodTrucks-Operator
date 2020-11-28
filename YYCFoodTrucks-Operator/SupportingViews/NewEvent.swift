//
//  NewEvent.swift
//  YYCFoodTrucks-Operator
//
//  Created by admin on 2020-11-28.
//

import Foundation
import SwiftUI
import FirebaseStorage


struct NewEvent: View {
    @ObservedObject var eventRepo = EventRespository()
    //@ObservedObject var operatorRepo = OperatorRepository()
    @Environment(\.presentationMode) var presentation
    @State var eventName: String = ""
    @State var description: String = ""
    @State var eventDate: String = ""
    @State var eventTime: String = ""
    @State var location: String = "" 
    @State var error: Bool = false
    //@State var category = 0
    
    @State var bannerImage: UIImage?
    //@State var truckImage: UIImage?
    //@State var menuImage: UIImage?

    
    var body: some View {
        let bannerPicker = ImagePickerView(image: self.$bannerImage, width: 250, height: 250, message: "Upload Event Banner")
        ScrollView{
            VStack(spacing: 20){
                Text("Add an Event")
                    .font(.title)
                bannerPicker
                TextField("Event Name", text: $eventName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 300)
                TextField("Description", text: $description)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 300)
                TextField("Location", text: $location)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 300)
                TextField("Date", text: $eventDate)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 300)
                TextField("Start time - End time", text: $eventTime)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 300)
                Button(action: addEventToRepo){
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
    
    
    func addEventToRepo(){
        // checking to make sure the images and text fields are not empty
        if (bannerImage == nil){
            error = true
            print("Banner Image is empty")
            return
        }
        else if (eventName == ""){
            error = true
            print("Name is empty")
            return
        }
        else if (description == ""){
            error = true
            print("Description is empty")
            return
        }
        else if (location == ""){
            error = true
            print("Location is empty")
            return
        }
        else if (eventDate == ""){
            error = true
            print("Date is empty")
            return
        }
        else if (eventTime == ""){
            error = true
            print("Event hours is empty")
            return
        }
        else{
            error = false
            print("All Fields Filled")
        }
        
        // updating the url where we want to upload the image data
        let bannerUrl = "EventLogos/\(eventName)Banner.jpeg"
        
        // uploading the images to firebase
        // need to figure this out a little better
        let storage = Storage.storage()
        var ref = storage.reference().child(bannerUrl)
        ref.putData((bannerImage?.jpegData(compressionQuality: 0.3))!)
        

        
        
        let addedEvent = Event(name: eventName, id: 0, logo: bannerUrl, eventDate: eventDate, eventTime: eventTime, description: description, location: location)
        
        // need to build this function
        let event_id = randomString(length: 20)
        
        eventRepo.addEvent(event: addedEvent, event_id: event_id)
        //need to build this function
        
        self.presentation.wrappedValue.dismiss()
    }
}
