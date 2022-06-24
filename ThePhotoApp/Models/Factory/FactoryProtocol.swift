//
//  FactoryProtocol.swift
//  ThePhotoApp
//
//  Created by Ален Авако on 23.06.2022.
//

import UIKit

enum ViewControllers {
    case photoCollection(viewModel: CollectionViewModel)
    case favoritePhotos(viewModel: TableViewModel)
    
    func produceViewController() -> UIViewController {
        switch self {
        case .photoCollection(let viewModel):
            return PhotoCollectionViewController(viewModel: viewModel)
        case .favoritePhotos(let viewModel):
            return FavoriteTableViewController(viewModel: viewModel)
        }
    }
}

protocol FactoryProtocol: AnyObject {
    func getViewController(for viewController: ViewControllers) -> UIViewController
}
