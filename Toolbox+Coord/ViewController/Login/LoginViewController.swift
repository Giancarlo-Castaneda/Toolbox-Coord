//
//  LoginViewController.swift
//  Toolbox+Coord
//
//  Created by Giancarlo Castaneda on 15/08/21.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController, StoryboardInitializable {

    @IBOutlet weak var loginButton: UIButton!
    var viewModel: LoginViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBinds()
        // Do any additional setup after loading the view.
    }

}
// Rx methods
extension LoginViewController {
    func setUpBinds() {
        loginButton.rx.tap
            .subscribe(onNext: { () in
                self.viewModel.getAuth.onNext(())
            })
//            .bind(to: viewModel.getAuth)
            .disposed(by: self.disposeBag)
    }
}
