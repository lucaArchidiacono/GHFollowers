//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Luca Archidiacono on 27.10.20.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    
    let imageCache = NSCache<NSString, UIImage>()
    
    private var baseGitHubURL: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.github.com"
        return urlComponents
    }
    
    private init() {}
    
    func getFollowers(for username: String, page: Int, completion: @escaping (Result<[Follower], GFError>) -> Void) {
        guard let url = _createGitHubURL(with: "/users/\(username)/followers", query: ["per_page": "100", "page": String(page)]) else {
            completion(.failure(.invalidURL))
            return
        }
        
        _sendGitHubRequest(to: url, modelType: [Follower].self, completion: completion)
    }
    
    
    func fetchImage(from urlString: String, completion: @escaping (UIImage) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        if let image = imageCache.object(forKey: cacheKey) {
            completion(image)
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else { return }
            
            self.imageCache.setObject(image, forKey: cacheKey)
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
        task.resume()
    }
    
    func getUserInfo(for username: String, completion: @escaping (Result<User, GFError>) -> Void) {
        guard let url = _createGitHubURL(with: "/users/\(username)") else {
            completion(.failure(.invalidURL))
            return
        }
        
        _sendGitHubRequest(to: url, modelType: User.self, completion: completion)
    }
    
    // MARK: - Private Section -
    
    private func _createGitHubURL(with path: String, query: [String: String]? = nil) -> URL? {
        var urlComponents = baseGitHubURL
        urlComponents.path = path
        
        if let query = query {
            var queryItems = [URLQueryItem]()
            
            for (key, value) in query {
                queryItems.append(URLQueryItem(name: key, value: value))
            }
            
            urlComponents.queryItems = queryItems
        }
        
        return urlComponents.url
    }
    
    private func _sendGitHubRequest<T: Codable>(to url: URL, modelType: T.Type, completion: @escaping (Result<T, GFError>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let model = try decoder.decode(T.self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
}
