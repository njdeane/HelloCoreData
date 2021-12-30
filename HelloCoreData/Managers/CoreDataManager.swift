//
//  CoreDataManager.swift
//  HelloCoreData
//
//  Created by Nic Deane on 30/12/2021.
//

import Foundation
import CoreData

class CoreDataManager {
  
  let persistentContainer: NSPersistentContainer
  
  init() {
    persistentContainer = NSPersistentContainer(name: "HelloCoreDataModel")
    persistentContainer.loadPersistentStores { description, error in
      if let error = error {
        fatalError("Core Data store failed to initialize: \(error.localizedDescription)")
      }
    }
  }
  
  func updateMovie() {
    do {
      try persistentContainer.viewContext.save()
    } catch {
      persistentContainer.viewContext.rollback()
      print("Movie was not updated: \(error)")
    }
  }
  
  func deleteMovie(movie: Movie) {
    persistentContainer.viewContext.delete(movie)
    do {
      try persistentContainer.viewContext.save()
    } catch {
      persistentContainer.viewContext.rollback()
      print("Movie was not deleted: \(error.localizedDescription)")
    }
  }
  
  func getAllMovies() -> [Movie] {
    let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
    do {
      return try persistentContainer.viewContext.fetch(fetchRequest)
    } catch {
      return []
    }
  }
  
  func saveMovie(title: String) {
    let movie = Movie(context: persistentContainer.viewContext)
    movie.title = title
    do {
      try persistentContainer.viewContext.save()
      print("Movie saved")
    } catch {
      print("Failed to save movie: \(error)")
    }
  }
  
}
