//
//  ErrorModel.swift
//  Toolbox+Coord
//
//  Created by Giancarlo Castaneda on 15/08/21.
//

import Foundation

struct ErrorModel: Codable{
    var timestamp: String?
    var statusCode: Int?
    var message: String?
    var title: String?
}
