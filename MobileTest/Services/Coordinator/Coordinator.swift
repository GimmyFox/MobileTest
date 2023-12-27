//
//  Coordinator.swift
//  MobileTest
//
//  Created by Maksim Guzeev on 26.12.2023.
//

import SwiftUI

final class Coordinator<Router: NavigationRouter>: ObservableObject {
    
    public let navigationController: UINavigationController
    public let startingRoute: Router?
    
    init(navigationController: UINavigationController = .init(), startingRoute: Router? = nil) {
        self.navigationController = navigationController
        navigationController.navigationItem.backButtonTitle = ""
        self.startingRoute = startingRoute
    }
    
    func start() {
        guard let route = startingRoute else { return }
        show(route)
    }
    
    func show(_ route: Router, animated: Bool = true) {
        let view = route.view()
        let viewWithCoordinator = view.environmentObject(self)
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        switch route.transition {
        case .push:
            navigationController.pushViewController(viewController, animated: animated)
        case .presentModally:
            viewController.modalPresentationStyle = .formSheet
            navigationController.present(viewController, animated: animated)
        case .presentFullscreen:
            viewController.modalPresentationStyle = .fullScreen
            navigationController.present(viewController, animated: animated)
        }
    }
    
    func pop(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }
    
    public func popToRoot(animated: Bool = true) {
        navigationController.popToRootViewController(animated: animated)
    }
    
    func dismiss(animated: Bool = true) {
        navigationController.dismiss(animated: true) { [weak self] in
            self?.navigationController.viewControllers = []
        }
    }
}
