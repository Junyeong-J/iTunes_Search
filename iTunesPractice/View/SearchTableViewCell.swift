//
//  SearchTableViewCell.swift
//  iTunesPractice
//
//  Created by 전준영 on 8/10/24.
//

import UIKit
import SnapKit
import Kingfisher
import RxSwift
import RxCocoa

final class SearchTableViewCell: BaseTableViewCell {
    
    private let width = UIScreen.main.bounds.width
    private var disposeBag = DisposeBag()
    
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
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("받기", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        return button
    }()
    
    private let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        return imageView
    }()
    
    private let appRateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .lightGray
        return label
    }()
    
    private let componyNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .lightGray
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .lightGray
        return label
    }()
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    static private func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3, height: (UIScreen.main.bounds.width / 3) * 2)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func configureHierarchy() {
        [appImageView, appTitleLabel, addButton, starImageView,
         appRateLabel, componyNameLabel, contentLabel, collectionView].forEach{ contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        appImageView.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.leading.top.equalTo(contentView).inset(20)
        }
        
        appTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(appImageView)
            make.leading.equalTo(appImageView.snp.trailing).offset(10)
            make.width.equalTo(width - 160)
        }
        
        addButton.snp.makeConstraints { make in
            make.width.equalTo(60)
            make.height.equalTo(30)
            make.centerY.equalTo(appImageView)
            make.trailing.equalTo(contentView).inset(20)
        }
        
        starImageView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).inset(20)
            make.top.equalTo(appImageView.snp.bottom).offset(10)
            make.size.equalTo(15)
        }
        
        appRateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(starImageView)
            make.leading.equalTo(starImageView.snp.trailing).offset(5)
        }
        
        componyNameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.centerY.equalTo(starImageView)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.centerY.equalTo(starImageView)
            make.trailing.equalTo(contentView).inset(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(starImageView.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(280)
        }
    }
    
    func configureData(data: AppResult) {
        let url = URL(string: data.artworkUrl60 ?? "")
        appImageView.kf.setImage(with: url)
        appTitleLabel.text = data.trackCensoredName
        appRateLabel.text = String(format: "%.1f", data.averageUserRating ?? 0)
        componyNameLabel.text = data.artistName
        contentLabel.text = data.genres?[0]
    }
    
    func bind(data: Observable<[String]?>) {
        data
            .map { $0 ?? [] }
            .bind(to: collectionView.rx.items(
                cellIdentifier: SearchCollectionViewCell.identifier,
                cellType: SearchCollectionViewCell.self)) { (row, element, cell) in
                    cell.configureData(imageUrl: element)
                }
                .disposed(by: disposeBag)
    }
    
}
