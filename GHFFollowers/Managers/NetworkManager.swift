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
    
    // to restrict that the init cannot be called from ourside, so that 'shared' is the only way to access the NetworkManager
    private init () {}
    
//    func getFollowers(for username: String, page: Int, completed: @escaping ([Follower]?,String?)->(Void)) {
    func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower], ErrorMessage>)->(Void)) {
        let endPoint = baseUrl + "users/\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endPoint) else {
//            completed(nil,"The username created an invalid request.")
            completed(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { date, response, error in
            if let _ = error {
//                completed(nil, "Unable to complete your request. Please check the internet connection.")
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let responseSafe = response as? HTTPURLResponse, responseSafe.statusCode == 200 else {
//                completed(nil, "Invalid response. Please try again.")
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let dataSafe = date else { 
//                completed(nil, "The data from server is invalid. Please try again.")
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: dataSafe)
//                completed(followers,nil)
                completed(.success(followers))
            } catch {
//                completed(nil,"The data from server is uncodable. Please try again.")
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
}
