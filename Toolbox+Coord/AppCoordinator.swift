//
//  AppCoordinator.swift
//  Toolbox+Coord
//
//  Created by Giancarlo Castaneda on 15/08/21.
//

import UIKit
import RxSwift

class AppCoordinator: BaseCoordinator<Void> {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        
        let navigationController = UINavigationController(rootViewController: LoginViewController.initFromStoryboard(name: "Main"))
        let loginCoordinator = LoginCoordinator(rootViewController: navigationController.viewControllers[0])
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        return coordinate(to: loginCoordinator)
    }
}
