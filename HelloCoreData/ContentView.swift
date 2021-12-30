//
//  ContentView.swift
//  HelloCoreData
//
//  Created by Nic Deane on 30/12/2021.
//

import SwiftUI

struct ContentView: View {
  
  let coreDM: CoreDataManager
  @State private var movieName: String = ""
  @State private var movies: [Movie] = []
  @State private var needsRefresh: Bool = false
  
  private func populateMovies() {
    movies = coreDM.getAllMovies()
  }
  
  var body: some View {
    NavigationView {
      VStack {
        TextField("Enter movie name", text: $movieName)
          .textFieldStyle(.roundedBorder)
        
        Button("Save") {
          coreDM.saveMovie(title: movieName)
          populateMovies()
        }
        .padding()
        
        List {
          ForEach(movies, id: \.self) { movie in
            NavigationLink {
              MovieDetailView(coreDM: coreDM, movie: movie, needsRefresh: $needsRefresh)
            } label: {
              Text(movie.title ?? "Unknown")
            }            
          }.onDelete { indexSet in
            indexSet.forEach { index in
              let movie = movies[index]
              coreDM.deleteMovie(movie: movie)
              populateMovies()
            }
          }
        }
        .listStyle(.plain)
        .tint(needsRefresh ? .white : .black) // this forces a redraw which then unpdate the movie name that was updated in MovieDetailView
        
        Spacer()
      }
      .padding()
      .onAppear {
        populateMovies()
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(coreDM: CoreDataManager())
    
  }
}

