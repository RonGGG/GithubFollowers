//
//  NetworkManager.swift
//  GHFFollowers
//
//  Created by 郭梓榕 on 19/1/2024.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private let baseUrl = "https://api.github.com/"
    
    let cache = NSCache<NSString,NSData>()
    
    // to restrict that the init cannot be called from ourside, so that 'shared' is the only way to access the NetworkManager
    private init () {}
    
//    func getFollowers(for username: String, page: Int, completed: @escaping ([Follower]?,String?)->(Void)) {
    func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower], ErrorMessage>)->(Void)) {
        let endPoint = baseUrl + "users/\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endPoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { date, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let responseSafe = response as? HTTPURLResponse, responseSafe.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let dataSafe = date else {
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: dataSafe)
                completed(.success(followers))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func downloadImage(from urlString: String, completed: @escaping (Data)->(Void)) {
        
        if let imgData = cache.object(forKey: NSString(string: urlString)) {
            
            completed(imgData as Data)
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
            
            // check
            guard let self = self else { return }
            if error != nil { return }
            guard let responseSafe = response as? HTTPURLResponse, responseSafe.statusCode == 200 else { return }
            guard let dataSafe = data else { return }
            
            // check cache
            self.cache.setObject(dataSafe as NSData, forKey: NSString(string: urlString))
            
            // completed
            completed(dataSafe)
        }
        task.resume()
    }
}
