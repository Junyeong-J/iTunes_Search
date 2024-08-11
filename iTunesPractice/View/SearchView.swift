//
//  SearchView.swift
//  iTunes
//
//  Created by 전준영 on 8/9/24.
//

import UIKit
import SnapKit

final class SearchView: BaseView {
    
    let tableView: UITableView = {
        let view = UITableView()
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        view.backgroundColor = .white
        view.rowHeight = 380
        view.separatorStyle = .none
        return view
    }()
    
    let recentWordTableView: UITableView = {
        let view = UITableView()
        view.register(SearchRecentWordTableViewCell.self, forCellReuseIdentifier: SearchRecentWordTableViewCell.identifier)
        view.backgroundColor = .white
        view.rowHeight = 44
        view.separatorStyle = .none
        return view
    }()
    
    override func configureHierarchy() {
        addSubview(recentWordTableView)
        addSubview(tableView)
    }
    
    override func configureLayout() {
        recentWordTableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
}
