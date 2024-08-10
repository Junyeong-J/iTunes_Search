//
//  SearchCollectionViewCell.swift
//  iTunesPractice
//
//  Created by 전준영 on 8/10/24.
//

import UIKit
import SnapKit
import Kingfisher

final class SearchCollectionViewCell: BaseCollectionViewCell {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(imageView)
    }
    
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
    func configureData(imageUrl: String?) {
        guard let urlString = imageUrl, let url = URL(string: urlString) else { return }
            imageView.kf.setImage(with: url)
    }
}
