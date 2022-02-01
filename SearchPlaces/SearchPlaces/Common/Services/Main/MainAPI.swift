//
//  MainAPI.swift
//  SearchPlaces
//
//  Created by Carlos Villamizar on 27/1/22.
//

import Foundation

protocol MainServiceProtocol {
    func getNearbyPlaces(request: MainModel.GetNearbyPlaces.Request, completion: @escaping (Result<MainModel.GetNearbyPlaces.Response, MainError>) -> Void)
    func getAutocomplete(request: SearchPlacesModel.GetAutocomplete.Request, completion: @escaping (Result<SearchPlacesModel.GetAutocomplete.Response, MainError>) -> Void)
}

class MainAPI: MainServiceProtocol {
    // Comunication with EndPoint
    func getNearbyPlaces(request: MainModel.GetNearbyPlaces.Request, completion: @escaping (Result<MainModel.GetNearbyPlaces.Response, MainError>) -> Void) {
        NetworkService.share.request(endpoint: MainEndpoint.getNearbyPlaces(ll: request.ll)) { result in
            switch result {
            case .success:
                do {
                    let data = try result.get()
                    let response = try JSONDecoder().decode(MainModel.GetNearbyPlaces.Response.self, from: data!)
                    completion(.success(response))
                } catch let error {
                    completion(.failure(.parse(error)))
                }
            case .failure(let error):
                completion(.failure(.network(error)))
            }
        }
    }
    
    func getAutocomplete(request: SearchPlacesModel.GetAutocomplete.Request, completion: @escaping (Result<SearchPlacesModel.GetAutocomplete.Response, MainError>) -> Void) {
        NetworkService.share.request(endpoint: MainEndpoint.getAutocomplete(query: request.query, ll: request.ll)) { result in
            switch result {
            case .success:
                do {
                    let data = try result.get()
                    let response = try JSONDecoder().decode(SearchPlacesModel.GetAutocomplete.Response.self, from: data!)
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
