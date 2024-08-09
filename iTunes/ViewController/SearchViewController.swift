//
//  SearchViewController.swift
//  iTunes
//
//  Created by 전준영 on 8/9/24.
//

import UIKit

final class SearchViewController: BaseViewController<SearchView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        configureSearchBar()
    }
    
    override func configureView() {
        super.configureView()
    }
    
}

extension SearchViewController {
    
    private func configureSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "게임, 앱, 스토리등"
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
}
