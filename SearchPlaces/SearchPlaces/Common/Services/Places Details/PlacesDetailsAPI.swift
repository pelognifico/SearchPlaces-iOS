//
//  PlacesDetailsAPI.swift
//  SearchPlaces
//
//  Created by Carlos Villamizar on 28/1/22.
//

import Foundation

protocol PlacesDetailsServiceProtocol {
    func getPlacesDetails(request: PlacesDetailsModel.GetDetailsPlaces.Request, completion: @escaping (Result<[PlacesDetailsModel.GetDetailsPlaces.Response], MainError>) -> Void)
}

class PlacesDetailsAPI: PlacesDetailsServiceProtocol {
    // Comunication with EndPoint
    func getPlacesDetails(request: PlacesDetailsModel.GetDetailsPlaces.Request, completion: @escaping (Result<[PlacesDetailsModel.GetDetailsPlaces.Response], MainError>) -> Void) {
        
        NetworkService.share.request(endpoint: PlacesDetailsEndpoint.getPlacesDetails(fsq_id: request.fsq_id)) { result in
            switch result {
            case .success:
                do {
                    let data = try result.get()
                    let response = try JSONDecoder().decode([PlacesDetailsModel.GetDetailsPlaces.Response].self, from: data!)
                    completion(.success(response))
                } catch let error {
                    completion(.failure(.parse(error)))
                }
            case .failure(let error):
                completion(.failure(.network(error)))
            }
        }
    }
}
