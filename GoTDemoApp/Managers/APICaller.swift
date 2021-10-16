//
//  APICaller.swift
//  GoTDemoApp
//
//  Created by Coding on 10/14/21.
//  Copyright © 2021 Vaporstream. All rights reserved.
//

import Foundation


final class APICaller {
    static let shared = APICaller()
    
    private init(){}
    
    //MARK: - public
    
    public func fetchHouses(completion: @escaping(Result<[House], Error>) -> Void){
        request(path: Endpoints.houseUrl, characterId: nil, expecting: [House].self, completion: completion)
    }
    
    public func fetchCharacter(characterUrl: String, completion: @escaping(Result<Character, Error>) -> Void){
        
        request(path: .baseCharacterUrl, characterId: characterUrl, expecting: Character.self, completion: completion)
        
    }
    //MARK: - private
    
    private enum APIError: Error {
        case noDataReturned
        case invalidURL
    }
    
    private enum Endpoints: String {
        case houseUrl = "https://www.anapioficeandfire.com/api/houses?hasWords=true&pageSize=50"
        case baseCharacterUrl = "https://www.anapioficeandfire.com/api/characters/"
    }
    
    private func request<T: Codable>(path: Endpoints,
                                     characterId: String?,
                                     expecting: T.Type,
                                     completion: @escaping(Result<T, Error>) -> Void){
        
        var urlPath: String {
            return path == .houseUrl ? path.rawValue : characterId!
        }
        
        guard let url = URL(string: urlPath) else {
            ///invalid url
            completion(.failure(APIError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data, error == nil else {
                if let error = error {
                    
                    completion(.failure(error))
                } else {
                    
                    completion(.failure(APIError.noDataReturned))
                }
                return
            }
            
            do {
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
            
        }
        
        task.resume()
        
    }
}
