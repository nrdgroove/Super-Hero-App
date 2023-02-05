//
//  SuperHero.swift
//  Super Hero App
//
//  Created by Gustavo Leguizamon on 2023-02-05.
//

import Foundation

struct SuperHero: Identifiable, Decodable, Hashable {
    var id: Int
    var name: String
    var slug: String
    var images: HeroImage
}

extension SuperHero: Equatable {
    static func == (lhs: SuperHero, rhs: SuperHero) -> Bool {
        lhs.id == rhs.id
    }
}







