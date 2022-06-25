//
//  DetailViewModel.swift
//  ThePhotoApp
//
//  Created by Ален Авако on 24.06.2022.
//

import Foundation

class DetailViewModel {
    let id: String
    
    var onStateChange: ((State) -> Void)?
    private(set) var photo: Photo?
    private(set) var state: State = .initilazing {
        didSet {
            onStateChange?(state)
        }
    }
    
    init(id: String) {
        self.id = id
    }
    
    func makeRequest() {
        state = .loading
        DetailNetworkService.shared.request(id: id) { [weak self] photo in
            self?.photo = photo
            self?.state = .loaded
        }
    }
}

extension DetailViewModel {
    enum State {
        case initilazing
        case loading
        case loaded
    }
}
