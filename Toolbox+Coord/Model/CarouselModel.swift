//
//  CarouselModel.swift
//  Toolbox+Coord
//
//  Created by Giancarlo Castaneda on 16/08/21.
//

import Foundation

// MARK: - CarosuelResponse
struct CarosuelResponse: Codable {
    let title, type: String
    let items: [CarouselItem]
}

// MARK: - Item
struct CarouselItem: Codable {
    let title: String
    let imageURL: String
    let videoURL: String?
    let itemDescription: String

    enum CodingKeys: String, CodingKey {
        case title
        case imageURL = "imageUrl"
        case videoURL = "videoUrl"
        case itemDescription = "description"
    }
}

typealias Carousel = [CarosuelResponse]
