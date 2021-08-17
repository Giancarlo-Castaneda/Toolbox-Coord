//
//  CarouselDetailCoordinator.swift
//  Toolbox+Coord
//
//  Created by Giancarlo Castaneda on 16/08/21.
//

import UIKit
import RxSwift

class CarouselDetailCoordinator: BaseCoordinator<Void> {
    let rootViewController: UIViewController
    public var item: CarouselItem?
        
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<Void> {
        let viewController = CarouselDetailViewController.initFromStoryboard(name: "Main")
        let viewModel = CarouselDetailViewModel(item: item)
        viewController.viewModel = viewModel
        
        rootViewController.navigationController?
            .pushViewController(viewController, animated: true)
        
        return Observable.never()
    }
}
