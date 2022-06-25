//
//  FavoritePhoto.swift
//  ThePhotoApp
//
//  Created by Ален Авако on 24.06.2022.
//

import Foundation

struct Photo: Decodable {
    let id: String
    let createdAt: String
    let downloads: Int
    var location: Location?
    let urls: [URLKind.RawValue: String]
    let user: UserInfo?
    
    enum URLKind: String {
        case raw
        case full
        case regular
        case small
        case thumb
    }
}

struct UserInfo: Decodable {
    let name: String
}

struct Location: Decodable {
    var city: String?
    var country: String?
}

