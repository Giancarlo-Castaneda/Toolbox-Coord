//
//  CarouselCell.swift
//  Toolbox+Coord
//
//  Created by Giancarlo Castaneda on 16/08/21.
//

import UIKit
import Kingfisher

class CarouselCell: UICollectionViewCell {

    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
    }
    
    func configureCell(with item: CarouselItem) {
        itemLabel.text = item.title
        guard let url = URL(string: item.imageURL) else { return }
        let processor = DownsamplingImageProcessor(size: imageView.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 20)
        imageView.kf.setImage(
            with: url,
            placeholder: nil,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.5)),
                .cacheOriginalImage,
                .memoryCacheExpiration(.expired),
                .diskCacheExpiration(.expired)
            ])
    }
}
