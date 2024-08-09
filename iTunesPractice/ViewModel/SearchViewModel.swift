//
//  SearchViewModel.swift
//  iTunesPractice
//
//  Created by 전준영 on 8/10/24.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchViewModel {
    
    let disposeBag = DisposeBag()
    
    struct Input {
        let searchButtonTap: ControlEvent<Void>
        let searchText: ControlProperty<String>
    }
    
    struct Output {
        let appList: Observable<[AppResult]>
    }
    
    func transform(input: Input) -> Output {
        let appList = PublishSubject<[AppResult]>()
        
        input.searchButtonTap
            .subscribe(onNext: {
                print("searchButtonTap")
            })
            .disposed(by: disposeBag)
        
        input.searchText
            .subscribe(onNext: { text in
                print("searchText: \(text)")
            })
            .disposed(by: disposeBag)
        
        input.searchButtonTap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(input.searchText)
            .distinctUntilChanged()
            .filter { !$0.isEmpty }
            .flatMapLatest { term in
                TunesNetworkManager.shared.getRequest(term: term, responseModel: iTunesResponse.self)
            }
            .subscribe(onNext: { result in
                switch result {
                case .success(let response):
                    appList.onNext(response.results)
                    dump(response.results)
                case .failure(let error):
                    print("Error: \(error)")
                    appList.onNext([])
                }
            })
            .disposed(by: disposeBag)
        
        return Output(appList: appList)
    }
    
}
