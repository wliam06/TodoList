//
//  DetailListRouter.swift
//  TodoList
//
//  Created by William on 24/11/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

class DetailListRouter: Router {
  var viewController: UIViewController {
    let controller = DetailListViewController()
    let interactor = DetailListInteractor(coreDataManager: coreDataManager)
    let presenter = DetailListPresenter(view: controller, interactor: interactor, router: self)

    let navigationController = UINavigationController(rootViewController: controller)

    controller.event = presenter
    presenter.view = controller
    interactor.output = presenter

    return navigationController
  }
}

