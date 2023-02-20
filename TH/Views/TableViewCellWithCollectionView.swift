//
//  TableViewCellWithCollectionView.swift
//  MyFirstApp
//
//  Created by Бакдаулет Дуйсенбеков on 28.10.2022.
//

import UIKit
import SnapKit

final class TableViewCellWithCollectionView: UITableViewCell {
    
    lazy private var actualWeatherCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
//        layout.itemSize = CGSize(width: 75, height: 125)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: Constants.Identifiers.CollectionViewCell)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    lazy private var backgroundBlurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemUltraThinMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .clear
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 20
        
        actualWeatherCollectionView.dataSource = self
        actualWeatherCollectionView.delegate = self
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK: - Collection view data source and delegate methods

extension TableViewCellWithCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = actualWeatherCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifiers.CollectionViewCell, for: indexPath) as! CollectionViewCell
        return cell
    }
}

extension TableViewCellWithCollectionView: UICollectionViewDelegate {
    
    
}

extension TableViewCellWithCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 55, height: 100)
    }
}

//MARK: - Setup views and constraints

private extension TableViewCellWithCollectionView {
    
    func setupViews() {
        contentView.addSubview(backgroundBlurEffectView)
        contentView.addSubview(actualWeatherCollectionView)
    }
    
    func setupConstraints() {
        backgroundBlurEffectView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        actualWeatherCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }
}

