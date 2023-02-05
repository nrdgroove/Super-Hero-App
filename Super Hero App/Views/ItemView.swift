//
//  ItemView.swift
//  Super Hero App
//
//  Created by Gustavo Leguizamon on 2023-02-05.
//

import SwiftUI
import Kingfisher

struct ItemView: View {
    var superHero: SuperHero
    
    var body: some View {
        VStack {
            KFImage.url(URL(string: superHero.images.sm))
            Text("\(superHero.name)")
        }
    }
}
