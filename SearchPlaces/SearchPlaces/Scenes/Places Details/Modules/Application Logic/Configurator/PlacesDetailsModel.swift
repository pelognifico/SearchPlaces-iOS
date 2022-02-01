//
//  PlacesDetailsModel.swift
//  SearchPlaces
//
//  Created by Carlos Villamizar on 28/1/22.
//

import Foundation

enum PlacesDetailsModel {
  
    // MARK: Use cases
    enum GetDetailsPlaces {
        struct Request {
            let fsq_id : String
        }
        struct Response: Codable {
            // MARK: - DataClass
            struct DataClass: Codable {
                
            }
            let id : String?
            let created_at: String?
            let prefix: String?
            let suffix: String?
            let width: Int?
            let height: Int?
            let classifications: [String]?
            
            enum CodingKeys: String, CodingKey {
                case id
                case created_at
                case prefix
                case suffix
                case width
                case height
                case classifications
            }
            
        }
        
        struct ViewModel {
            let data: [PlacesDetailsModel.GetDetailsPlaces.Response]
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
