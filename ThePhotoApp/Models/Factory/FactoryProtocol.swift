//
//  FactoryProtocol.swift
//  ThePhotoApp
//
//  Created by Ален Авако on 23.06.2022.
//

import UIKit

enum ViewControllers {
    case photoCollection(viewModel: CollectionViewModel)
    case favoritePhotos
    
    func produceViewController() -> UIViewController {
        switch self {
        case .photoCollection(let viewModel):
            return PhotoCollectionViewController(viewModel: viewModel)
        case .favoritePhotos:
            return FavoriteTableViewController()
        }
    }
}

protocol FactoryProtocol: AnyObject {
    func getViewController(for viewController: ViewControllers) -> UIViewController
}
