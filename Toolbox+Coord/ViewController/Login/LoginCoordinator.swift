//
//  LoginCoordinator.swift
//  Toolbox+Coord
//
//  Created by Giancarlo Castaneda on 15/08/21.
//

import UIKit
import RxSwift

class LoginCoordinator: BaseCoordinator<Void> {
    
    let rootViewController: UIViewController
        
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<Void> {
        
        let viewController = rootViewController as! LoginViewController
        let viewModel = LoginViewModel()
        viewController.viewModel = viewModel
        
        viewModel.authResult.subscribe(onNext: { (authResult) in
//            let userDefaults = UserDefaults.standard
//            do {
//                try userDefaults.setObject(authResult, forKey: authKey)
//            } catch {
//                print(error.localizedDescription)
//            }
            self.showCarousel(by: authResult)
        }).disposed(by: disposeBag)

        return Observable.never()
    }
    
    private func showCarousel(by Auth: AuthModel) {
        let carouselCoordinator = CarouselCoordinator(rootViewController: rootViewController)
        carouselCoordinator.auth = Auth
        _ = carouselCoordinator.start()
    }
}
