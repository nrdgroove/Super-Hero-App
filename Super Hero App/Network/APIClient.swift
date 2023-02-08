//
//  APIClient.swift
//  Super Hero App
//
//  Created by Gustavo Leguizamon on 2023-02-05.
//

import Foundation
import Alamofire

class APIClient {
    @Published var superHeros: [SuperHero] = []
    
    private let baseURL = "https://bitbucket.org/consultr/superhero-json-api/raw/4b787c39fcbfd8d069339de94bf8f3a6bda69f3e"
    
    init() {
        loadSuperHeroes()
    }
    
    private func loadSuperHeroes() {
        AF
        .request("\(baseURL)/superheros.json")
        .responseData { response in
            switch response.result {
            case .failure(let error):
                print(error)
            case .success(let data):
                do {
                    let superHeros = try JSONDecoder().decode([SuperHero].self, from: data)
                    self.superHeros = superHeros
                } catch let error {
                    print(error)
                }
            }
        }
    }
}
