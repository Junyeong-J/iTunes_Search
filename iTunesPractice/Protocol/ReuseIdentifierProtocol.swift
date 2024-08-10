//
//  ReuseIdentifierProtocol.swift
//  iTunesPractice
//
//  Created by 전준영 on 8/10/24.
//

import UIKit

protocol ReuseIdentifierProtocol {
    
    static var identifier: String { get }
    
}

extension UITableViewCell: ReuseIdentifierProtocol {
    static var identifier: String {
        String(describing: self)
    }
}

extension UICollectionViewCell: ReuseIdentifierProtocol {
    static var identifier: String {
        String(describing: self)
    }
}
