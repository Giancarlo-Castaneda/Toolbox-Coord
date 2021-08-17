//
//  CarouselViewModel.swift
//  Toolbox+Coord
//
//  Created by Giancarlo Castaneda on 16/08/21.
//

import Foundation
import RxSwift

class CarouselViewModel {
    
    var getCarousel: AnyObserver<Void>
    var carouselResult: Observable<Carousel>!
    
    var showDetail = PublishSubject<CarouselItem>()
    var reloadCarousel = PublishSubject<Bool>()
    
    let disposeBag = DisposeBag()
    
    init(auth: AuthModel) {
        let _getCarousel = PublishSubject<Void>()
        self.getCarousel = _getCarousel.asObserver()
        
        self.carouselResult = _getCarousel.flatMapLatest({ (_) -> Observable<Carousel> in
            return Api.requestService(endpoint: .data(auth: auth), model: Carousel())
        }).catchError({ (error) -> Observable<[CarosuelResponse]> in
            if let err = error as? NSError, err.code == 401 {
                self.reloadCarousel.onNext(true)
            }
            return .error(error)
        }).map({ result in
            return result
        })
    }
}
