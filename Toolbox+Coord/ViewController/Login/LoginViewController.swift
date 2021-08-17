//
//  LoginViewController.swift
//  Toolbox+Coord
//
//  Created by Giancarlo Castaneda on 15/08/21.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class LoginViewController: UIViewController, StoryboardInitializable {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    var viewModel: LoginViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        setBackgroundImage()
        setUpBinds()
        // Do any additional setup after loading the view.
    }
    
    func setBackgroundImage() {
        guard let url = URL(string: "http://placeimg.com/320/480/any") else { return }
        let processor = DownsamplingImageProcessor(size: backgroundImage.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 0)
        backgroundImage.kf.setImage(
            with: url,
            placeholder: nil,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.1)),
                .cacheOriginalImage,
                .memoryCacheExpiration(.expired),
                .diskCacheExpiration(.expired)
            ])
    }

}
// Rx methods
extension LoginViewController {
    func setUpBinds() {
        loginButton.rx.tap
            .subscribe(onNext: { () in
                self.viewModel.getAuth.onNext(())
            })
            .disposed(by: self.disposeBag)
    }
}
