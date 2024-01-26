//
//  PersistenceManager.swift
//  GHFFollowers
//
//  Created by 郭梓榕 on 27/1/2024.
//

import Foundation

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    private enum Keys {
        static let favorites = "favorites"
    }
    
    // load favorites from UserDefaults.plist
    static func retrieveFavorites(completed: @escaping (Result<[Follower],GFError>)->Void) {
        guard let favorites = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        do{
            let decoder = JSONDecoder()
            let decodedFavorites = try decoder.decode([Follower].self, from: favorites)
            completed(.success(decodedFavorites))
        }
        catch{
            completed(.failure(.unableToRetrieveFavorites))
        }
        
    }
    
    // save data to UserDefaults.plist
    static func save(favorites: [Follower]) -> GFError? {
        do{
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            
            return nil
        }
        catch{
            return .unableToSaveFavorites
        }
    }
}
