//
//  ContentView.swift
//  Super Hero App
//
//  Created by Gustavo Leguizamon on 2023-02-05.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    @ObservedObject var model = SuperHeroGridViewModel()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(model.superHeros, id: \.self) { superhero in
                        VStack {
                            KFImage.url(URL(string: superhero.images.sm))
                            Text("\(superhero.name)")
                        }
                    }
                }
            }
            .navigationBarTitle("SuperHeros", displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
