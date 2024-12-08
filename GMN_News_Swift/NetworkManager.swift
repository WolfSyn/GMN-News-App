//
//  NetworkManager.swift
//  xcode Tutorial Demo
//
//  Created by Carlos Daniel Garcia on 12/2/24.
//
// this will handle collecting news through an API CALL

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    private let baseURL = "https://www.gamespot.com/api/articles/"
    private let apiKey = "your_gamespot_api_key"
    
    func fetchArticles(completion: @escaping (Result<[Article], Error>) -> Void) {
        let url = "\(baseURL)?api_key=\(apiKey)&format=json"
        
        AF.request(url).validate().responseDecodable(of: ArticleResponse.self) { response in
            switch response.result {
            case .success(let articleResponse):
                completion(.success(articleResponse.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

struct ArticleResponse: Codable {
    let results: [Article]
}

struct Article: Identifiable, Codable {
    var id = UUID()
    let title: String
    let deck: String?
    let image: ImageInfo?
}

struct ImageInfo: Codable {
    let icon_url: String
}
