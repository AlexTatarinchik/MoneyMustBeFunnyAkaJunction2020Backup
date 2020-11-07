//
//  ViewController.swift
//  MoneyHealth
//
//  Created by Egor Petrov on 06.11.2020.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let progressView = ProgressView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white

        self.view.addSubview(self.progressView)
        self.progressView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(100)
        }
    }
}

