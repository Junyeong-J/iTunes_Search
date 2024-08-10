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
    
    func bind() {
        
        let input = SearchViewModel.Input(
            searchButtonTap: searchController.searchBar.rx.searchButtonClicked,
            searchText: searchController.searchBar.rx.text.orEmpty)
        
        let output = viewModel.transform(input: input)
        
        output.appList
            .bind(to: rootView.tableView.rx.items(
                cellIdentifier: SearchTableViewCell.identifier,
                cellType: SearchTableViewCell.self)) { (row, element, cell) in
                    cell.configureData(data: element)
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
    }
    
}
