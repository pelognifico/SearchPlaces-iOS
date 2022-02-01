//
//  SearchPlacesModel.swift
//  SearchPlaces
//
//  Created by Ruben Duarte on 31/1/22.
//

import Foundation

enum SearchPlacesModel {
  
    // MARK: Use cases
    enum GetAutocomplete {
        struct Request {
            let query   : String
            let ll      : String
        }
        struct Response: Codable {
            
            let results : [SearchPlaces]?
            
            enum CodingKeys: String, CodingKey {
                case results
            }
            
        }
        
        struct ViewModel {
            let placesList  : [SearchPlaces]?
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
