//
//  SuperHeroGridView.swift
//  Super Hero App
//
//  Created by Gustavo Leguizamon on 2023-02-05.
//

import SwiftUI

struct SuperHeroGridView: View {
    @ObservedObject var viewModel = SuperHeroGridViewModel()
    @State private var favoriteColor = 0

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("e.g. Batman, Female", text: $viewModel.searchText)
                        .padding()
                    Spacer()
                    Button("Search") {
                        UIApplication.shared.windows.first { $0.isKeyWindow }?.endEditing(true)
                    }
                }
                .padding()
                
                gridView
            }
            .navigationBarTitle("Super Heros", displayMode: .inline)
        }
    }
    
    var columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 2)
    
    private var gridView: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(viewModel.superHeros, id: \.self) { superHero in
                    ItemView(superHero: superHero)
                        .contextMenu(ContextMenu(menuItems: {
                            Button {
                                viewModel.delete(superHero)
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
