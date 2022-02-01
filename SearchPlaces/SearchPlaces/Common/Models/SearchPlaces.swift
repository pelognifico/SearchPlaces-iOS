//
//  SearchPlaces.swift
//  SearchPlaces
//
//  Created by Ruben Duarte on 31/1/22.
//

import Foundation

struct SearchPlaces: Codable {
    let type: String?
    let text: Text?
    let link: String?
    let place: NearbyPlaces?
    let name: String?
}

struct Text: Codable {
    let primary: String?
    let secondary: String?
    let highlight: [Highlight]?
}

struct Highlight: Codable {
    let start: Int?  // duda si es bool
    let length: Int? // duda si es bool// duda si es bool
}
