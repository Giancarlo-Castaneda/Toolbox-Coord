//
//  CarouselListItemCell.swift
//  Toolbox+Coord
//
//  Created by Giancarlo Castaneda on 16/08/21.
//

import UIKit
import RxSwift

class CarouselListItemCell: UITableViewCell {

    @IBOutlet weak var caruoselTypeLabel: UILabel!
    @IBOutlet weak var carouselCollectionView: UICollectionView!
    var carouselItem = PublishSubject<[CarouselItem]>()
    var onSelected = PublishSubject<CarouselItem>()
    private let disposeBag = DisposeBag()
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        carouselCollectionView.register(UINib(nibName: "CarouselCell", bundle: nil), forCellWithReuseIdentifier: CarouselCell.identifier)
        carouselCollectionView.delegate = self
        
        carouselItem.asObservable()
            .bind(to: carouselCollectionView.rx.items(cellIdentifier: CarouselCell.identifier,
                                              cellType: CarouselCell.self)) { row, carousel, cell in
                cell.configureCell(with: carousel)
            }
            .disposed(by: disposeBag)
        
        carouselCollectionView.rx.modelSelected(CarouselItem.self)
            .bind(to: onSelected)
            .disposed(by: disposeBag)
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(with carusel: CarosuelResponse) {
        caruoselTypeLabel.text = "Carousel type: "+carusel.type
        carouselItem.onNext(carusel.items)
    }
}

extension CarouselListItemCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width*0.7, height: 200)
    }
}
