//
//  FavoriteArray.swift
//  ThePhotoApp
//
//  Created by Ален Авако on 25.06.2022.
//

import Foundation

struct FavoriteArray {
    static var favoriteArray = [Photo]()
    
    func addPhoto(photo: Photo) {
        FavoriteArray.favoriteArray.append(photo)
    }
    
    func deletePhoto(photo: Photo) {
        for (index, value) in FavoriteArray.favoriteArray.enumerated() {
            if value.id == photo.id {
                FavoriteArray.favoriteArray.remove(at: index)
            }
        }
    }
}
