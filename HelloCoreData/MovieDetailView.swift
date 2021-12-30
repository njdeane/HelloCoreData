//
//  MovieDetailView.swift
//  HelloCoreData
//
//  Created by Nic Deane on 30/12/2021.
//

import SwiftUI

struct MovieDetailView: View {
  
  let coreDM: CoreDataManager
  let movie: Movie
  @State private var movieName: String = ""
  @Binding var needsRefresh: Bool
  
  var body: some View {
    VStack {
      TextField(movie.title ?? "Unknown", text: $movieName)
        .textFieldStyle(.roundedBorder)
      
      Button("Update") {
        if !movieName.isEmpty {
          movie.title = movieName
          coreDM.updateMovie()
          needsRefresh.toggle()
        }
      }
      .padding()
    }
    .padding()
  }
}

struct MovieDetailView_Previews: PreviewProvider {
  static var previews: some View {
    
    let coreDM = CoreDataManager()
    let movie = Movie(context: coreDM.persistentContainer.viewContext)
    
    MovieDetailView(coreDM: coreDM, movie: movie, needsRefresh: .constant(false))
  }
}
