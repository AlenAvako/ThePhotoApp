//
//  CollectionViewModel.swift
//  ThePhotoApp
//
//  Created by Ален Авако on 23.06.2022.
//

import Foundation

final class CollectionViewModel {
    
    var onStateChanged: ((State) -> Void)?
    
    private(set) var photos: [PhotoCollection] = []
    
    private(set) var state: State = .initilazing {
        didSet {
            onStateChanged?(state)
        }
    }
    
    func makeRequest(searchTerm: String) {
        state = .loading
        NetworkService.shared.request(searchterm: searchTerm) { [weak self] photoArray in
            self?.photos = photoArray
            self?.state = .loaded
        }
    }
}

extension CollectionViewModel {
    enum State {
        case initilazing
        case loading
        case loaded
    }
}
