//
//  CarouselDetailViewController.swift
//  Toolbox+Coord
//
//  Created by Giancarlo Castaneda on 16/08/21.
//

import UIKit
import WebKit
import Kingfisher
import RxSwift

class CarouselDetailViewController: UIViewController, StoryboardInitializable {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var videoWebView: WKWebView!
    @IBOutlet weak var descriptionTxv: UITextView!
    
    var viewModel : CarouselDetailViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpBinds()
        // Do any additional setup after loading the view.
    }
}
// Rx Methods
extension CarouselDetailViewController {
    func setUpBinds() {
        viewModel.carouselItem.subscribe(onNext: { (item) in
            if let item = item {
                if let urlVideo = URL(string: (item.videoURL ?? "")) {
                    self.videoWebView.load(URLRequest(url: urlVideo))
                }
                self.titleLabel.text = item.title
                self.descriptionTxv.text = item.itemDescription
                if let urlImage = URL(string: item.imageURL) {
                    let processor = DownsamplingImageProcessor(size: self.imageView.bounds.size)
                             |> RoundCornerImageProcessor(cornerRadius: 20)
                    self.imageView.kf.setImage(
                    with: urlImage,
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
        }).disposed(by: disposeBag)

    }
}
