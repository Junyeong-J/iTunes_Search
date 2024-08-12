//
//  BaseView.swift
//  iTunes
//
//  Created by 전준영 on 8/9/24.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureHierarchy() { }
    func configureLayout() { }
    func configureView() { }
    
    @available(*,unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
