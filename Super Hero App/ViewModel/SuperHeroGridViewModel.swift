//
//  SuperHeroGridViewModel.swift
//  Super Hero App
//
//  Created by Gustavo Leguizamon on 2023-02-05.
//

import Foundation
import Combine

protocol SuperHeroGridViewModelProtocol {
    var superHeros: [SuperHero] { get }
    func loadSuperHeros()
    func delete(_ superHero: SuperHero)
}

final class SuperHeroGridViewModel: ObservableObject {
    @Published var superHeros = [SuperHero]() {
        didSet {
            didChange.send(self)
        }
    }
    
    @Published var searchText: String = ""

    private let apiClient: Client
    private var disposables = Set<AnyCancellable>()

    let didChange = PassthroughSubject<SuperHeroGridViewModel, Never>()

    init(apiClient: Client = APIClient()) {
        self.apiClient = apiClient
        self.loadSuperHeros()
        
        $searchText
            .map { text -> [SuperHero] in
                guard !text.isEmpty else {
                    return self.superHeros
                }
                
                let lowercasedText = text.lowercased()
                
                let filteredSuperHero = self.superHeros.filter { superHero -> Bool in
                    return superHero.name.lowercased().contains(lowercasedText) ||
                    superHero.appearance.gender.lowercased().contains(lowercasedText)
                }
                return filteredSuperHero
            }
            .sink { [weak self] (returnedSuperHeros) in
                self?.superHeros = returnedSuperHeros
            }
            .store(in: &disposables)
    }
}

extension SuperHeroGridViewModel: SuperHeroGridViewModelProtocol {
    internal func loadSuperHeros() {
        self.apiClient.loadSuperHeroes { superHeros in
            self.superHeros = superHeros
        }
    }
    
    internal func delete(_ superHero: SuperHero) {
        self.superHeros.removeAll(where: { $0 == superHero })
    }
}
