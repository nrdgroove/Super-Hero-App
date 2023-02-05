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
    func deleteSuperHero(_ superHero: SuperHero)
}

final class SuperHeroGridViewModel: ObservableObject {
    @Published var superHeros = [SuperHero]() {
        didSet {
            didChange.send(self)
        }
    }

    private let apiClient: Client
    private var disposables = Set<AnyCancellable>()

    let didChange = PassthroughSubject<SuperHeroGridViewModel, Never>()

    init(apiClient: Client = APIClient()) {
        self.apiClient = apiClient
        self.loadSuperHeros()
    }
}

extension SuperHeroGridViewModel: SuperHeroGridViewModelProtocol {
    internal func loadSuperHeros() {
        self.apiClient.loadSuperHeroes { superHeros in
            self.superHeros = superHeros
        }
    }
    
    internal func deleteSuperHero(_ superHero: SuperHero) {
        self.superHeros.removeAll(where: { $0 == superHero })
    }
}
