//
//  ImagePickerView.swift
//  YYCFoodTrucks-Operator
//
//  Created by apple on 2020-11-09.
//

import SwiftUI

struct ImagePickerView: View {
    @State var showImagePicker: Bool = false
    @State var image: UIImage?

    var width: CGFloat
    var height: CGFloat
    var message: String
    
       var body: some View {
           VStack {
                Button(action: {
                    self.showImagePicker.toggle()
                }){
                    if image != nil {
                        Image(uiImage: image!)
                            .resizable()
                         .frame(width: self.width, height: self.height)
                    } else {
                        VStack{
                            Text(self.message)
                                .font(.headline)
                                .padding(.bottom, 25)
                            Image(systemName: "icloud.and.arrow.up")
                                .resizable()
                                .frame(width: 65, height: 65)
                            
                        }.frame(width: self.width, height: self.height)
                    }
                }
                    .overlay(
                        Rectangle()
                            .stroke(Color.gray, lineWidth: 2)
                            .frame(width: self.width, height: self.height)
                        
                            //.foregroundColor(Color.gray)
                    ).frame(width: self.width, height: self.height)
           }
           .sheet(isPresented: $showImagePicker) {
               ImagePicker(sourceType: .photoLibrary) { image in
                   self.image = image
               }
           }
       }
}
/*
struct ImagePickerView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePickerView()
    }
}*/
