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
        
//        var activeSession: AuthModel?
        
//        let userDefaults = UserDefaults.standard
//        do {
//            activeSession = try userDefaults.getObject(forKey: authKey, castTo: AuthModel.self)
//            print(activeSession)
//        } catch {
//            print(error.localizedDescription)
//        }
//
//        if let session = activeSession {
//            let navigationController = UINavigationController(rootViewController: CarouselViewController.initFromStoryboard(name: "Main"))
//            let carouselCoordinator = CarouselCoordinator(rootViewController: navigationController)
//            carouselCoordinator.auth = session
//            _ = carouselCoordinator.start()
//            UIApplication.shared.windows.first?.rootViewController = navigationController
//            UIApplication.shared.windows.first?.makeKeyAndVisible()
//            return coordinate(to: carouselCoordinator)
//        }
//        else {
            let navigationController = UINavigationController(rootViewController: LoginViewController.initFromStoryboard(name: "Main"))
            let loginCoordinator = LoginCoordinator(rootViewController: navigationController.viewControllers[0])
            UIApplication.shared.windows.first?.rootViewController = navigationController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
            return coordinate(to: loginCoordinator)
//        }
    }
}
