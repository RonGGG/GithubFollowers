//
//  PersistenceManager.swift
//  GHFFollowers
//
//  Created by 郭梓榕 on 27/1/2024.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    private enum Keys {
        static let favorites = "favorites"
    }
    
    static func update(favorite: Follower, type: PersistenceActionType, completed: @escaping (GFError?)->Void){
        retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                var retrivedFavorites = favorites
                
                switch type {
                case .add:
                    if favorites.contains(where: { $0.login == favorite.login }) {
                        completed(.userExistInFavoriteList)
                        return
                    }
                    retrivedFavorites.append(favorite)
                case .remove:
                    // 这里不用判断是否存在该user
                    retrivedFavorites.removeAll { $0.login == favorite.login }
                }
                completed(save(favorites: retrivedFavorites))
            case .failure(let error):
                completed(error)
            }
        }
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
