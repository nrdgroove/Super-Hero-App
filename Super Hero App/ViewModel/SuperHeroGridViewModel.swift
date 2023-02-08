//
//  SuperHeroGridViewModel.swift
//  Super Hero App
//
//  Created by Gustavo Leguizamon on 2023-02-05.
//

import Foundation
import Combine

final class SuperHeroGridViewModel: ObservableObject {
    @Published var superHeros: [SuperHero] = []
    @Published var searchText: String = ""

    private let apiClient: APIClient
    private var disposables = Set<AnyCancellable>()

    init(apiClient: APIClient = APIClient()) {
        self.apiClient = apiClient
        addSubscribers()
    }
    
    func addSubscribers() {
        apiClient.$superHeros
            .sink { [weak self] superHeros in
                self?.superHeros = superHeros
            }
            .store(in: &disposables)
        
        $searchText
            .combineLatest(apiClient.$superHeros)
            .map { (text, superHeros) in
                guard !text.isEmpty else {
                    return superHeros
                }
                 
                let lowercasedText = text.lowercased()
                
                return superHeros.filter { superHero -> Bool in
                    return superHero.name.lowercased().contains(lowercasedText) || superHero.appearance.gender.lowercased().contains(lowercasedText)
                }
            }
            .sink { [weak self] superHeros in
                self?.superHeros = superHeros
            }
            .store(in: &disposables)
    }
    
    func delete(_ superHero: SuperHero) {
        self.superHeros.removeAll(where: { $0 == superHero })
    }
}
