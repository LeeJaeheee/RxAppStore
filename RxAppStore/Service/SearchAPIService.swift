//
//  SearchAPIService.swift
//  RxAppStore
//
//  Created by 이재희 on 4/7/24.
//

import Foundation
import RxSwift

// TODO: 파일 분리하기

enum APIError: Error {
    case invalidURL
    case unknownResponse
    case statusError
    case decodingError
}

enum NetworkEndpoint {
    case searchApp(name: String)
}

extension NetworkEndpoint {
    
    static let url = "https://itunes.apple.com/search"
    
    var endpoint: String {
        switch self {
        case .searchApp(_):
            "search"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .searchApp(let name):
            return [
                URLQueryItem(name: "term", value: name),
                URLQueryItem(name: "media", value: "software"),
                URLQueryItem(name: "entity", value: "software"),
                URLQueryItem(name: "country", value: "kr"),
                URLQueryItem(name: "lang", value: "ko_kr"),
                URLQueryItem(name: "limit", value: "20")
            ]
        }
    }
}

class SearchAPIService {
    
    static let shared = SearchAPIService()
    
    private init() { }
    
    // TODO: 케이스 대응
    private func buildUrl(query: String) -> URL? {
        guard !query.isEmpty else { return nil }
        
        var components = URLComponents(string: "https://itunes.apple.com/")
        components?.path.append(NetworkEndpoint.searchApp(name: query).endpoint)
        components?.queryItems = NetworkEndpoint.searchApp(name: query).queryItems
        
        return components?.url
    }
    
    func fetchSearchData(query: String) -> Observable<SearchModel> {
        
        return Observable<SearchModel>.create { observer in
            
            guard let url = self.buildUrl(query: query) else {
                observer.onError(APIError.invalidURL)
                return Disposables.create()
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                if error != nil {
                    observer.onError(APIError.unknownResponse)
                    return
                }
                
                guard let response = response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else {
                    observer.onError(APIError.statusError)
                    return
                }
                
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let appData = try decoder.decode(SearchModel.self, from: data)
                        observer.onNext(appData)
                        observer.onCompleted()
                    } catch {
                        observer.onError(APIError.decodingError)
                    }
                } else {
                    observer.onError(APIError.unknownResponse)
                }
                
            }.resume()
            
            return Disposables.create()
        }.debug()
        
    }
}
