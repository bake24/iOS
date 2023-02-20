//
//  ForecastTableViewCell.swift
//  MyFirstApp
//
//  Created by Бакдаулет Дуйсенбеков on 31.10.2022.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    
    lazy private var dayLabel: UILabel = {
        let label = UILabel()
        label.text = "Today"
        return label
    }()
    
    lazy private var conditionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "cloud")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        return imageView
    }()
    
    lazy private var degreeLowLabel: UILabel = {
        let label = UILabel()
        label.text = " 72°"
        return label
    }()
    
    lazy private var rowLabel: UILabel = {
        let label = UILabel()
        label.text = "----------------"
        return label
    }()
    
    lazy private var degreeHighLabel: UILabel = {
        let label = UILabel()
        label.text = " 49°"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                        
        setupViews()
        setupConstraints()
        changeLabelText()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeLabelText() {
        let subviews = contentView.subviews
        for subview in subviews {
            if subview is UILabel {
                let currentLabel = subview as! UILabel
                currentLabel.textAlignment = .center
                currentLabel.textColor = .white
            }
        }
    }
}

//MARK: - Setup views and constraints methods

private extension ForecastTableViewCell {
    
    func setupViews() {
        contentView.addSubview(dayLabel)
        contentView.addSubview(conditionImageView)
        contentView.addSubview(degreeLowLabel)
        contentView.addSubview(rowLabel)
        contentView.addSubview(degreeHighLabel)
    }
    
    func setupConstraints() {
        dayLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.15)
        }
        conditionImageView.snp.makeConstraints { make in
            make.leading.equalTo(dayLabel.snp.trailing)
            make.top.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.1)
        }
        degreeLowLabel.snp.makeConstraints { make in
            make.leading.equalTo(conditionImageView.snp.trailing)
            make.top.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.1)
        }
        rowLabel.snp.makeConstraints { make in
            make.leading.equalTo(degreeLowLabel.snp.trailing)
            make.top.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.54)
        }
        degreeHighLabel.snp.makeConstraints { make in
            make.leading.equalTo(rowLabel.snp.trailing)
            make.top.bottom.trailing.equalToSuperview()
        }
    }
}
