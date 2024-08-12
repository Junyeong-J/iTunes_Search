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
    
    private let disposeBag = DisposeBag()
    
    private var defaults: UserDefaultsManager
    private var recentWordRelay: BehaviorRelay<[String]>
    
    struct Input {
        let searchButtonTap: ControlEvent<Void>
        let searchText: ControlProperty<String>
    }
    
    struct Output {
        let appList: Observable<[AppResult]>
        let recentWordList: Driver<[String]>
        let searchTextOutput: Observable<String>
    }
    
    init(
        defaults: UserDefaultsManager = UserDefaultsManager.shared
    ) {
        self.defaults = defaults
        
        recentWordRelay = BehaviorRelay(value: defaults.recentWord)
    }
    
    func transform(input: Input) -> Output {
        var appList = PublishSubject<[AppResult]>()
        let recentWordList = recentWordRelay.asDriver(onErrorJustReturn: [])
        let searchTextOutput = input.searchText.asObservable()
        
        input.searchButtonTap
            .withLatestFrom(input.searchText)
            .subscribe(with: self) { owner, text in
                var recentWords = owner.defaults.recentWord
                
                recentWords.removeAll { $0 == text }
                recentWords.insert(text, at: 0)
                owner.defaults.recentWord = Array(recentWords)
                owner.recentWordRelay.accept(recentWords)
            }
            .disposed(by: disposeBag)
        
        input.searchText
            .subscribe(onNext: { text in
                if text.isEmpty {
                    appList.onNext([])
                }
            })
            .disposed(by: disposeBag)
        
        
        input.searchButtonTap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(input.searchText)
            .distinctUntilChanged()
            .filter { !$0.isEmpty }
            .flatMap { term in
                TunesNetworkManager.shared.getRequest(term: term, responseModel: iTunesResponse.self)
                    .catch { error in
                        return Single.just(.success(iTunesResponse(resultCount: 0, results: [])))
                    }
            }
            .debug("Button Tap")
            .subscribe(onNext: { result in
                switch result {
                case .success(let response):
                    appList.onNext(response.results)
                case .failure(let error):
                    print("Error: \(error)")
                    appList.onNext([])
                }
            })
            .disposed(by: disposeBag)
        
        return Output(appList: appList, recentWordList: recentWordList, searchTextOutput: searchTextOutput)
    }
    
}
