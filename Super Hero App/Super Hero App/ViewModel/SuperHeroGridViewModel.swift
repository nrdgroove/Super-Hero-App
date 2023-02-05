//
//  SuperHeroGridViewModel.swift
//  Super Hero App
//
//  Created by Gustavo Leguizamon on 2023-02-05.
//

import Foundation
import Combine

class SuperHeroGridViewModel: ObservableObject {
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
    
    private func loadSuperHeros() {
        self.apiClient.loadSuperHeroes { superHeros in
            self.superHeros = superHeros
        }
    }
}
