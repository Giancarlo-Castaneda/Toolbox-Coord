//
//  CarouselDetailViewModel.swift
//  Toolbox+Coord
//
//  Created by Giancarlo Castaneda on 16/08/21.
//

import Foundation
import RxSwift
import RxCocoa

public class CarouselDetailViewModel {
    var carouselItem = BehaviorRelay<CarouselItem?>(value: nil)
    
    init(item: CarouselItem?) {
        carouselItem.accept(item)
    }
}
