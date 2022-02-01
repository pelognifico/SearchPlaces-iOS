//
//  PlacesDetails.swift
//  SearchPlaces
//
//  Created by Carlos Villamizar on 28/1/22.
//

import Foundation

struct PlacesDetails: Codable {
    let id: String?
    let created_at: String?
    let prefix: String?
    let suffix: String?
    let width: Int?
    let height: Int?
    let classifications: [String]?
}
