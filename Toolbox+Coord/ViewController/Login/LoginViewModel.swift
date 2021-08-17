//
//  LoginViewModel.swift
//  Toolbox+Coord
//
//  Created by Giancarlo Castaneda on 15/08/21.
//

import Foundation
import RxSwift

public class LoginViewModel {
    
    var getAuth: AnyObserver<Void>
    var authResult: Observable<AuthModel>!
    
    let disposeBag = DisposeBag()
    
    init() {
        let _getAuth = PublishSubject<Void>()
        self.getAuth = _getAuth.asObserver()
        
        self.authResult = _getAuth.flatMapLatest({ (_) -> Observable<AuthModel> in
            let aaaaa = Api.requestService(endpoint: .login, model: AuthModel())
            return aaaaa
        })
    }
}
