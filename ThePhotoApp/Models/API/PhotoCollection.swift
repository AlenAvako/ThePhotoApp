//
//  PhotoCollection.swift
//  ThePhotoApp
//
//  Created by Ален Авако on 23.06.2022.
//

import Foundation

struct SerchResult: Decodable {
    let results: [PhotoCollection]
}

struct PhotoCollection: Decodable {
    let id: String
    let urls: [URLKind.RawValue: String]
    
    enum URLKind: String {
        case raw
        case full
        case regular
        case small
        case thumb
    }
}
