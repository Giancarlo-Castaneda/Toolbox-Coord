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
    @IBOutlet weak var collectionHeight: NSLayoutConstraint!
    var carouselItem = PublishSubject<[CarouselItem]>()
    var onSelected = PublishSubject<CarouselItem>()
    private let disposeBag = DisposeBag()
    private var currentItem: CarosuelResponse?
    
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
    
    private func getCollectionHeight(type: String) -> CGFloat {
        return type == "thumb" ? 200 : 300
    }
    
    func configureCell(with carousel: CarosuelResponse) {
        currentItem = carousel
        caruoselTypeLabel.text = "Carousel type: "+carousel.type
        collectionHeight.constant = getCollectionHeight(type: carousel.type)
        carouselItem.onNext(carousel.items)
    }
}

extension CarouselListItemCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width*0.7, height: getCollectionHeight(type: currentItem?.type ?? ""))
    }
}
