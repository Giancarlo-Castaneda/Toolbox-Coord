//
//  NetworkManager.swift
//  Toolbox+Coord
//
//  Created by Giancarlo Castaneda on 15/08/21.
//

import Foundation
import Alamofire
import UIKit

enum NetworkStatus {
    case reachable
    case noReachable
    case unknown
}

class NetworkManager {
    
    //shared instance
    static let shared = NetworkManager()
    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")
    ///Stop listener
    func stop(){
        reachabilityManager?.stopListening()
    }
    ///Start listener and notify if internet connection lost
    func startNetworkReachabilityObserver() {
        // start listening
        reachabilityManager?.startListening(onUpdatePerforming: { status in
            switch status {
            case .notReachable, .unknown:
//                UIApplication.shared.keyWindow?.rootViewController?.getTopMostViewController()?.showAlert("Error", message: "Not Internet Connection", buttonText: "OK")
                print("The network is not reachable")
            case .reachable(.ethernetOrWiFi), .reachable(.cellular):
                print("The network is reachable over the WiFi connection")
            }
        })
    }
    
}

