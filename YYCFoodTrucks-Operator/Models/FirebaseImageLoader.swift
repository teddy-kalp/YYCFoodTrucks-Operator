//
//  FirebaseImageLoader.swift
//  YYCFoodTrucks
//
//  Created by Jordan on 2020-10-27.
//

import Foundation

import SwiftUI
import Combine
import FirebaseStorage

final class Loader : ObservableObject {
    let didChange = PassthroughSubject<Data?, Never>()
    @Published var data: Data? = nil {
        didSet { didChange.send(data) }
    }

    init(_ id: String){
        // the path to the image
        let url = "\(id)"
        let storage = Storage.storage()
        let ref = storage.reference().child(url)
        ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("Failed to load image \(error)")
            }

            DispatchQueue.main.async {
                self.data = data
            }
        }
    }
}
