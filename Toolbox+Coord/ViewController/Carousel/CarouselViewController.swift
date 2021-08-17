//
//  CarouselViewController.swift
//  Toolbox+Coord
//
//  Created by Giancarlo Castaneda on 16/08/21.
//

import UIKit
import RxSwift

class CarouselViewController: UIViewController, StoryboardInitializable {

    var viewModel: CarouselViewModel!
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var carouselListTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
        carouselListTable.register(UINib(nibName: "CarouselListItemCell", bundle: nil), forCellReuseIdentifier: CarouselListItemCell.identifier)
        carouselListTable.estimatedRowHeight = 200
        
        setUpBinds()
    }

}
// Rx methods
extension CarouselViewController {
    func setUpBinds() {
        
        viewModel.carouselResult.asObservable()
            .catchError({ (error) -> Observable<[CarosuelResponse]> in
                print("Errorrrz")
                return Observable.empty()
            })
            .bind(to: carouselListTable.rx.items(cellIdentifier: CarouselListItemCell.identifier,
                                              cellType: CarouselListItemCell.self)) { row, carousel, cell in
                cell.configureCell(with: carousel)
                cell.onSelected.bind(to: self.viewModel.showDetail)
                    .disposed(by: self.disposeBag)
            }
            .disposed(by: disposeBag)
        
        viewModel.getCarousel.onNext(())
    }
}
