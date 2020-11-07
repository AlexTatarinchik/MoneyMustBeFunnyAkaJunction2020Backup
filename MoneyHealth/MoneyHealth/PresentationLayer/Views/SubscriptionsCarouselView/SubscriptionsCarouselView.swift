//
//  SubscriptionsCarouselView.swift
//  MoneyHealth
//
//  Created by Alexander on 11/7/20.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SubscriptionsCarouselView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, GenericCellSubview {

    var disposeBag = DisposeBag()

    let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Upcoming write-offs"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        return label
    }()

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    var items = [SubscriptionModel]()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.items = [
            .init(id: "1",
                  name: "Spotify",
                  category: "Music",
                  imageName: "Spotify",
                  backgroundColor: "000000",
                  price: 9.99
            ),
            .init(id: "1",
                  name: "Netflix",
                  category: "Steaming",
                  imageName: "Netflix",
                  backgroundColor: "FFFFFF",
                  price: 9.99
            )
        ]

        self.collectionView.backgroundColor = .clear
        self.collectionView.showsHorizontalScrollIndicator = false

        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }

        layout.scrollDirection = .horizontal

        self.collectionView.dataSource = self
        self.collectionView.delegate = self

        self.setupInitialLayout()

        self.collectionView.registerReusableCellWithClass(GenericCollectionViewCell<SubscriptionView>.self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupInitialLayout() {
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview()
        }

        self.addSubview(self.collectionView)
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        self.collectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.height.equalTo(100)
            make.trailing.equalToSuperview()
            make.top.equalTo(self.titleLabel.snp.bottom).offset(24)
            make.bottom.equalToSuperview()
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithType(GenericCollectionViewCell<SubscriptionView>.self, indexPath: indexPath)
        cell.customSubview.setup(config: self.items[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 220, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }

    func bindOutput(from model: LookAtSpendingsItemModel) { }
}