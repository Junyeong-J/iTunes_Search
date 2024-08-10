//
//  TunesNetworkManager.swift
//  iTunesPractice
//
//  Created by 전준영 on 8/10/24.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

final class TunesNetworkManager {
    
    static let shared = TunesNetworkManager()
    
    private init () { }
    
    func getRequest<T: Decodable>(term: String, responseModel: T.Type) -> Observable<Result<T, Error>> {
        
        let url =
        let parameters: [String: Any] = [
            "term": "\(term)",
            "country": "kr",
            "media": "software",
            "limit": "5"
        ]
        
        return Observable.create { observer -> Disposable in
            AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default)
                .responseDecodable(of: responseModel.self) { response in
                    switch response.result {
                    case .success(let data):
                        observer.onNext(.success(data))
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
}
