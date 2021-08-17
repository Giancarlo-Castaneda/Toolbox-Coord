//
//  AuthModel.swift
//  Toolbox+Coord
//
//  Created by Giancarlo Castaneda on 15/08/21.
//

import Foundation

struct AuthModel: Codable {
    var sub: String?
    var token: String?
    var type: String?
}
