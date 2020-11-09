//
//  FirebaseImage.swift
//  YYCFoodTrucks
//
//  Created by Jordan on 2020-10-27.
//

import SwiftUI
import ActivityIndicatorView
//let placeholder = UIImage(named: "placeholder.jpg")!
//let placeholder =  UIImage(systemName: "photo")!
let placeholder = UIImage(named: "Loading")!
let primColor2 = Color(red: 0, green: 0.73, blue: 0.6, opacity: 0.1)

struct FirebaseImage : View {
    var width: CGFloat
    var height: CGFloat
    @State var animate = true
    
    
    init(id: String, width: Int, height: Int) {
        self.width = CGFloat(width)
        self.height = CGFloat(height)
        self.imageLoader = Loader(id)
    }

    @ObservedObject private var imageLoader : Loader
    
    var image: UIImage? {
        imageLoader.data.flatMap(UIImage.init)
    }

    var body: some View {
        if image != nil {
            Image(uiImage: image ?? placeholder)
            .resizable()
                .frame(width: self.width, height: self.height)
                .animation(.easeIn)
        }
        else {
            ActivityIndicatorView(isVisible: $animate, type: .default)
            .frame(width: 50.0, height: 50.0)
            .foregroundColor(primColor)
        }
    }
}
