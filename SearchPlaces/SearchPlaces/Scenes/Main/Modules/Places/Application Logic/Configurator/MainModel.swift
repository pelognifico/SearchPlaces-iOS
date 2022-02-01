//
//  MainModels.swift
//  SearchPlaces
//
//  Created by Carlos Villamizar on 27/1/22.
//

import Foundation

enum MainModel {
  
    // MARK: Use cases
    enum GetNearbyPlaces {
        struct Request {
            let ll  : String
        }
        struct Response: Codable {
            
            let results : [NearbyPlaces]?
            
            enum CodingKeys: String, CodingKey {
                case results
            }
            
        }
        
        struct ViewModel {
            let placesList  : [NearbyPlaces]?
        }
    }
    
    enum Error {
        struct Request {
        }
        struct Response {
            var error: MainError
        }
        struct ViewModel {
            var error: MainError
        }
    }
}
