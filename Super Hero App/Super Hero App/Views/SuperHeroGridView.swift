//
//  SuperHeroGridView.swift
//  Super Hero App
//
//  Created by Gustavo Leguizamon on 2023-02-05.
//

import SwiftUI

struct SuperHeroGridView: View {
    @ObservedObject var model = SuperHeroGridViewModel()
    
    var body: some View {
        NavigationView {
            gridView
                .navigationBarTitle("Super Heros", displayMode: .inline)
        }
    }
    
    var columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 2)
    
    private var gridView: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(model.superHeros, id: \.self) { superHero in
                    ItemView(superHero: superHero)
                        .contextMenu(ContextMenu(menuItems: {
                            Button {
                                model.deleteSuperHero(superHero)
                            } label: {
                                Label("Delete Super Hero", systemImage: "trash")
                            }
                        }))
                }
            }
        }
    }
}

struct SuperHeroGridView_Previews: PreviewProvider {
    static var previews: some View {
        SuperHeroGridView()
    }
}
