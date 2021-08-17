//
//  CarouselCoordinator.swift
//  Toolbox+Coord
//
//  Created by Giancarlo Castaneda on 16/08/21.
//

import UIKit
import RxSwift

class CarouselCoordinator: BaseCoordinator<Void> {
    
    public var auth: AuthModel = AuthModel()
    private let rootViewController: UIViewController
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<CoordinationResult> {
        let viewModel = CarouselViewModel(auth: auth)
        let viewController = CarouselViewController.initFromStoryboard(name: "Main")
        viewController.viewModel = viewModel
        
        rootViewController.navigationController?
            .pushViewController(viewController, animated: true)
        
        viewModel.reloadCarousel.subscribe(onNext: { (value) in
            self.showLogin()
        }).disposed(by: disposeBag)
        
        viewModel.showDetail.subscribe(onNext: { (detail) in
            self.showDetail(by: detail)
        }).disposed(by: disposeBag)
        
        return Observable.never()
    }
    
    private func showLogin() {
        let navigationController = UINavigationController(rootViewController: LoginViewController.initFromStoryboard(name: "Main"))
        let loginCoordinator = LoginCoordinator(rootViewController: navigationController.viewControllers[0])
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        _ = loginCoordinator.start()
    }
    
    private func showDetail(by detail: CarouselItem) {
        let carouselDetailCoordinator = CarouselDetailCoordinator(rootViewController: rootViewController)
        carouselDetailCoordinator.item = detail
        _ = carouselDetailCoordinator.start()
    }
}
