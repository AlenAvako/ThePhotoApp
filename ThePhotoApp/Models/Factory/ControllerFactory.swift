//
//  ControllerFactory.swift
//  ThePhotoApp
//
//  Created by Ален Авако on 23.06.2022.
//

import UIKit

class ControllerFactory: FactoryProtocol {
    func getViewController(for viewController: ViewControllers) -> UIViewController {
        return viewController.produceViewController()
    }
}
