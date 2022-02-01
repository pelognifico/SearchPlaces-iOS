//
//  SearchPlaces.swift
//  SearchPlaces
//
//  Created by Carlos Villamizar on 31/1/22.
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
    let start: Int?
    let length: Int?
}
