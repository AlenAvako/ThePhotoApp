//
//  FavoriteManager.swift
//  ThePhotoApp
//
//  Created by Ален Авако on 25.06.2022.
//

import Foundation

final class FavoriteManager {
    static let shared = FavoriteManager()
    private var searchTokenFlights = [String]()
    
    func addToFavorites(photo: String) {
        if searchTokenFlights.firstIndex(of: photo) != nil {
            print("already added")
        } else {
            searchTokenFlights.append(photo)
        }
        print(searchTokenFlights)
    }
    
    func removeFromFavorites(photo: String) {
        if let index = searchTokenFlights.firstIndex(of: photo) {
            searchTokenFlights.remove(at: index)
        }
    }
    
    func checkPhotoStatus(photo: String) -> Bool {
        if searchTokenFlights.firstIndex(of: photo) != nil {
            return true
        } else {
            return false
        }
    }
}
