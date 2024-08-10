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
    
    override func configureHierarchy() {
        addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
