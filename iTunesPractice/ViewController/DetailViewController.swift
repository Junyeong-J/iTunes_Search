//
//  DetailViewController.swift
//  iTunesPractice
//
//  Created by 전준영 on 8/10/24.
//

import UIKit

final class DetailViewController: BaseViewController<DetailView> {
    
    var appData: AppResult? {
        didSet {
            rootView.configureData(data: appData)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func configureView() {
        super.configureView()
    }
    
}
