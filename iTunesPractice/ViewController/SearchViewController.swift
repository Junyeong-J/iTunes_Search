//
//  SearchViewController.swift
//  iTunes
//
//  Created by 전준영 on 8/9/24.
//

import UIKit
import RxSwift
import RxCocoa

final class SearchViewController: BaseViewController<SearchView> {
    
    private let viewModel = SearchViewModel()
    private let disposeBag = DisposeBag()
    private var searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        configureSearchBar()
        bind()
    }
    
    override func configureView() {
        super.configureView()
    }
    
    private func bind() {
        
        let input = SearchViewModel.Input(
            searchButtonTap: searchController.searchBar.rx.searchButtonClicked,
            searchText: searchController.searchBar.rx.text.orEmpty)
        
        let output = viewModel.transform(input: input)
        
        output.searchTextOutput
            .map { $0.isEmpty }
            .distinctUntilChanged()
            .bind(to: rootView.tableView.rx.isHidden)
            .disposed(by: disposeBag)
        
        output.recentWordList
            .drive(rootView.recentWordTableView.rx.items(cellIdentifier: SearchRecentWordTableViewCell.identifier, cellType: SearchRecentWordTableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = element
            }
            .disposed(by: disposeBag)
        
        output.appList
            .bind(to: rootView.tableView.rx.items(
                cellIdentifier: SearchTableViewCell.identifier,
                cellType: SearchTableViewCell.self)) { (row, element, cell) in
                    cell.configureData(data: element)
                    cell.bind(data: Observable.just(element.screenshotUrls))
                }
                .disposed(by: disposeBag)
        
        Observable.zip(
            rootView.tableView.rx.modelSelected(AppResult.self),
            rootView.tableView.rx.itemSelected)
        .map { $0.0 }
        .subscribe(with: self) { owner, appData in
            let detailVC = DetailViewController()
            detailVC.appData = appData
            owner.navigationController?.pushViewController(detailVC, animated: true)
        }
        .disposed(by: disposeBag)
        
    }
    
}

extension SearchViewController {
    
    private func configureSearchBar() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "게임, 앱, 스토리등"
        searchController.hidesNavigationBarDuringPresentation = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.largeTitleDisplayMode = .always
    }
    
}
