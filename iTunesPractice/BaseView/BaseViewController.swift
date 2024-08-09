//
//  BaseViewController.swift
//  iTunes
//
//  Created by 전준영 on 8/9/24.
//

import UIKit

class BaseViewController<RootView: UIView>: UIViewController {
    
    let rootView: RootView
    
    init() {
        self.rootView = RootView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureView()
        configureConstraints()
        bindModel()
    }
    
    func configureHierarchy() {
        
    }
    
    func configureView() {
        view.backgroundColor = .white
    }
    
    func configureConstraints() {
        
    }
    
    func bindModel() {
        
    }
    
    func configureKeyboardTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        rootView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        rootView.endEditing(true)
    }
    
}

extension BaseViewController {
    
    func setNavigationBar() {
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "검색"
    }
    
}
