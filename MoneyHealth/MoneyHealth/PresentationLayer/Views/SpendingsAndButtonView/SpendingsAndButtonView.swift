//
//  SpendingsAndButtonView.swift
//  MoneyHealth
//
//  Created by Alexander on 11/7/20.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

final class SpendingsAndButtonView: UIView, GenericCellSubview, ReusableComponent {
    enum Style {
        case subscriptions
        case subscriptionsAll
        case main
    }
    
    var disposeBag = DisposeBag()

    func update(style: Style) {
        self.spendingActionButton.update(style: style)
        switch style {
        case .subscriptions:
            self.balanceView.titleLabel.text = "Recurent payments per month"

            let balance = (try? APIService.shared.subscrptionPayment.value()) ?? 0
            self.balanceView.balanceLabel.text = String(format: "€%.2f%", balance)
        case .main:
            self.balanceView.titleLabel.text = "Total Balance"
        case .subscriptionsAll:
            self.balanceView.titleLabel.text = "Recurent payments per month"
            self.spendingActionButton.isHidden = true

            let balance = (try? APIService.shared.subscrptionPayment.value()) ?? 0
            self.balanceView.balanceLabel.text = String(format: "€%.2f%", balance)
        }
    }

    init() {
        super.init(frame: .zero)
        self.setupInitialLayout()
    }

    let balanceView = BalanceView()
    let spendingActionButton = SpendingActionButton()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setupInitialLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func setupInitialLayout() {
        self.backgroundColor = .clear

        self.addSubview(self.balanceView)
        self.balanceView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
            make.width.equalToSuperview().multipliedBy(0.53)
        }

        self.addSubview(self.spendingActionButton)
        self.spendingActionButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(self.balanceView.snp.trailing).inset(-12)
        }
    }

    func configure() {
        APIService.shared
            .userBalance
            .map { return "$\($0)" }
            .bind(to: self.balanceView.balanceLabel.rx.text)
            .disposed(by: self.disposeBag)
    }

    func reuse() {
        self.disposeBag = DisposeBag()
    }
}
