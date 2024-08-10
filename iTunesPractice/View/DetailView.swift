//
//  DetailView.swift
//  iTunesPractice
//
//  Created by 전준영 on 8/10/24.
//

import UIKit
import SnapKit
import Kingfisher

final class DetailView: BaseView {
    
    private let detailScrollView = UIScrollView()
    private let contentView = UIView()
    
    private let topView = UIView()
    
    private let appImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let appTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    
    private let componyNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .lightGray
        return label
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("받기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 13
        button.clipsToBounds = true
        return button
    }()
    
    private let newsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        label.text = "새로운 소식"
        return label
    }()
    
    override func configureHierarchy() {
        addSubview(detailScrollView)
        detailScrollView.addSubview(contentView)
        
        contentView.addSubview(topView)
        [appImageView, appTitleLabel, componyNameLabel, addButton].forEach{ topView.addSubview($0) }
        
        [newsLabel].forEach{ contentView.addSubview($0) }
        
    }
    
    override func configureLayout() {
        detailScrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.width.equalTo(detailScrollView.snp.width)
            make.verticalEdges.equalTo(detailScrollView)
        }
        
        topView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(100)
        }
        
        appImageView.snp.makeConstraints { make in
            make.size.equalTo(80)
            make.centerY.equalTo(topView)
            make.leading.equalTo(topView).inset(20)
        }
        
        appTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(appImageView.snp.trailing).offset(15)
            make.trailing.equalTo(topView.snp.trailing).offset(20)
            make.top.equalTo(appImageView.snp.top).offset(5)
        }
        
        componyNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(appImageView)
            make.leading.equalTo(appImageView.snp.trailing).offset(15)
        }
        
        addButton.snp.makeConstraints { make in
            make.leading.equalTo(appImageView.snp.trailing).offset(15)
            make.bottom.equalTo(appImageView)
            make.width.equalTo(60)
            make.height.equalTo(26)
        }
        
        
    }
    
    func configureData(data: AppResult?) {
        guard let data = data else {return}
        let url = URL(string: data.artworkUrl60 ?? "")
        appImageView.kf.setImage(with: url)
        appTitleLabel.text = data.trackCensoredName
        componyNameLabel.text = data.artistName
    }
    
}
