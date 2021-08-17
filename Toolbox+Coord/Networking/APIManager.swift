//
//  APIManager.swift
//  Toolbox+Coord
//
//  Created by Giancarlo Castaneda on 15/08/21.
//

import Foundation
import Moya
import RxMoya
import RxSwift
import Alamofire

private let defaultManager: Session = {
    
    let manager = ServerTrustManager(allHostsMustBeEvaluated: false,
                                     evaluators: ["190.131.203.107": DisabledTrustEvaluator()])
    let configuration = URLSessionConfiguration.af.default
    configuration.waitsForConnectivity = true
    return Session(configuration: configuration, serverTrustManager: manager)
}()

let ApiProvider = MoyaProvider<Api>(session: defaultManager)
var disposeBag = DisposeBag()
//private let allowedDiskSize = 100 * 1024 * 1024
//var cache: URLCache = {
//    return URLCache(memoryCapacity: 100, diskCapacity: allowedDiskSize, diskPath: "requestCache")
//}()

enum Api {
    case login
    case data(auth: AuthModel)
}

extension Api: TargetType {
    
    var baseURL: URL {
        switch self {
        default:
            return URL(string: baseUrl)!
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "auth"
        case .data:
            return "data"
        }
    }
    
    var method: Moya.Method  {
        switch self {
        case .login:
            return .post
        case .data:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .login:
            let parameters = [
                "sub": "ToolboxMobileTest"
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .data:
            return .requestParameters(parameters: [:], encoding: URLEncoding.default)
        }
        
    }
//    let asd ="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJUb29sYm94TW9iaWxlVGVzdCIsIm5hbWUiOiJUb29sYm94IEF1dGggdGVzdCIsImlhdCI6MTYyOTEzMTU0NywiZXhwaXJlRGF0ZSI6IjIwMjEtMDgtMTZUMTY6MzI6MjcuNjA2WiJ9.IMdE25WPjLkQm9fs6O3Vf3SFzjtz_KJObmyID4UFVyo"
    var headers: [String : String]? {
        switch self {
        case .login:
            return nil
        case .data(let auth):
            return ["authorization": "\(auth.type!) \(auth.token!)"]
        }
    }
    
    
    static func requestService<T: Codable>(endpoint:Api,model:T) -> Observable<T> {
        
        return Observable<T>.create { (observer) -> Disposable in
            
            ApiProvider.rx.request(endpoint).subscribe { event in
                
                switch event {
                
                case let .success(response):
                    
                    switch response.statusCode {
                    case 200...299:
                        
//                        let cachedData = CachedURLResponse(response: response.response!, data: response.data)
//                        cache.storeCachedResponse(cachedData, for: response.request!)
                        print("Response:", try? response.mapJSON())
                        if let model = try? response.map(T.self, atKeyPath: "results", using: JSONDecoder.init(), failsOnEmptyData: false) {
                            observer.onNext(model)
                            observer.onCompleted()
                        }else if  let simpleModel = try? response.map(T.self) {
                            observer.onNext(simpleModel)
                            observer.onCompleted()
                        }else {
                            print("JSONDecoder Model error")
                            let error = NSError(domain: "JSONDecoder Model error", code: response.statusCode, userInfo: nil)
                            observer.onError(error)
                            observer.onCompleted()
                        }
                        
                    default:
                        let errorMap : ErrorModel? = try? response.map(ErrorModel.self)
                        let error = NSError(domain: errorMap?.message ?? "Server Error", code: response.response?.statusCode ?? 400, userInfo: nil)
                        
                        observer.onError(error)
                        observer.onCompleted()
                        
                        break
                    }
                    
                case let .error(error):
                    observer.onError(error)
                    observer.onCompleted()
                }
            }.disposed(by: disposeBag)
            
            return Disposables.create {
                
            }
        }
    }
}
