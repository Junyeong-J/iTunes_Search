//
//  DetailView.swift
//  iTunesPractice
//
//  Created by 전준영 on 8/10/24.
//

import UIKit
import SnapKit
import Kingfisher
import RxSwift
import RxCocoa

final class DetailView: BaseView {
    
    private let disposeBag = DisposeBag()
    private let screenshotURLs = BehaviorRelay<[String]>(value: [])
    
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
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.text = "새로운 소식"
        return label
    }()
    
    private let versionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .lightGray
        return label
    }()
    
    private let releaseNotesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
        collectionView.register(DetailCollectionView.self, forCellWithReuseIdentifier: DetailCollectionView.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    static private func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 1.5, height: (UIScreen.main.bounds.width / 1.5) * 2)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    override func configureHierarchy() {
        addSubview(detailScrollView)
        detailScrollView.addSubview(contentView)
        
        contentView.addSubview(topView)
        [appImageView, appTitleLabel, componyNameLabel, addButton].forEach{ topView.addSubview($0) }
        
        [newsLabel, versionLabel, releaseNotesLabel, collectionView, descriptionLabel].forEach{ contentView.addSubview($0) }
        
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
            make.top.horizontalEdges.equalTo(contentView)
            make.height.equalTo(100)
        }
        
        appImageView.snp.makeConstraints { make in
            make.size.equalTo(80)
            make.centerY.equalTo(topView)
            make.leading.equalTo(topView).inset(20)
        }
        
        appTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(appImageView.snp.trailing).offset(15)
            make.trailing.equalTo(topView).inset(20)
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
        
        newsLabel.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(10)
            make.leading.equalTo(contentView).inset(20)
        }
        
        versionLabel.snp.makeConstraints { make in
            make.top.equalTo(newsLabel.snp.bottom).offset(10)
            make.leading.equalTo(contentView).inset(20)
        }
        
        releaseNotesLabel.snp.makeConstraints { make in
            make.top.equalTo(versionLabel.snp.bottom).offset(15)
            make.leading.trailing.equalTo(contentView).inset(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(releaseNotesLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(contentView)
            make.height.equalTo(500)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(30)
            make.horizontalEdges.bottom.equalTo(contentView).inset(20)
        }
        
    }
    
    override func configureView() {
        bindCollectionView()
    }
    
    func configureData(data: AppResult?) {
        guard let data = data else {return}
        let url = URL(string: data.artworkUrl60 ?? "")
        appImageView.kf.setImage(with: url)
        appTitleLabel.text = data.trackCensoredName
        componyNameLabel.text = data.artistName
        versionLabel.text = "버전 \(data.version ?? "0.0.0")"
        releaseNotesLabel.text = data.releaseNotes
        descriptionLabel.text = data.description
        
        screenshotURLs.accept(data.screenshotUrls ?? [])
    }
    
    
    private func bindCollectionView() {
        screenshotURLs
            .bind(to: collectionView.rx.items(
                cellIdentifier: DetailCollectionView.identifier,
                cellType: DetailCollectionView.self)) { (row, element, cell) in
                    cell.configureData(imageUrl: element)
                }
                .disposed(by: disposeBag)
    }
}
