//
//  Main.swift
//  SearchPlaces
//
//  Created by Carlos Villamizar on 27/1/22.
//

import Foundation

struct NearbyPlaces: Codable {
    let fsq_id          : String?
    let categories      : [Categories]?
    let chains          : [Chains]?
    let distance        : Int?
    let geocodes        : Geocodes?
    let location        : Location?
    let name            : String?
    let related_places  : Parent?
    let timezone        : String?
}

struct Categories: Codable {
    let id      : Int?
    let name    : String?
    let icon    : Icon?
}

struct Icon: Codable {
    let prefix  : String?
    let suffix  : String?
}

struct Chains: Codable {
    let id      : String?
    let name    : String?
}

struct Geocodes: Codable {
    let main    : Main
}

struct Main: Codable {
    let latitude    : Double
    let longitude   : Double
}

struct Location: Codable {
    let address             : String?
    let address_extended    : String?
    let country             : String?
    let cross_street        : String?
    let dma                 : String?
    let locality            : String?
    let postcode            : String?
    let region              : String?
}

struct Parent: Codable {
    let parent  : Parents?
}

struct Parents: Codable {
    let fsq_id  : String?
    let name    : String?
}
