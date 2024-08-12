//
//  TunesNetworkManager.swift
//  iTunesPractice
//
//  Created by 전준영 on 8/10/24.
//

import Foundation
import RxSwift
import Alamofire

enum iTunesNetworkError: Error {
    case invalidURL
    case networkError
    case customError(message: String)
}

final class TunesNetworkManager {
    
    static let shared = TunesNetworkManager()
    
    private init () { }
    
    typealias iTunesHandler<T: Decodable> = Single<Result<T, iTunesNetworkError>>
    
    func getRequest<T: Decodable>(term: String, responseModel: T.Type) -> iTunesHandler<T> {
        
        let url = APIURL.iTunesURL
        let parameters: [String: Any] = [
            "term": "\(term)",
            "country": "kr",
            "media": "software",
            "limit": "5"
        ]
        
        return Single.create { observer -> Disposable in
            guard let url = URL(string: url) else {
                observer(.success(.failure(.invalidURL)))
                return Disposables.create()
            }
            
            AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default)
//                .validate(statusCode: 200..<300)
                .responseDecodable(of: responseModel.self) { response in
                    switch response.result {
                    case .success(let data):
                        observer(.success(.success(data)))
                    case .failure(_):
                        observer(.success(.failure(.networkError)))
                    }
                }
            return Disposables.create()
        }
        .debug("API 통신")
        //    }
        
    }}
