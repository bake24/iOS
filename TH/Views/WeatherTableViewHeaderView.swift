//
//  WeatherTableViewHeaderView.swift
//  TH
//
//  Created by Бакдаулет Дуйсенбеков on 31.10.2022.
//

import UIKit
import SnapKit

protocol HeaderViewDelegate{
    func didUpdateHeaderView(with model: WeatherModel)
}

final class WeatherTableViewHeaderView: UITableViewHeaderFooterView {
    var weatherManager: WeatherManager?
    lazy private var cityLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading..."
        label.font = UIFont.systemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()
    
    lazy private var degreeLabel: UILabel = {
        let label = UILabel()
        label.text = "..."
        label.font = UIFont.systemFont(ofSize: 90)
        label.textAlignment = .center
        return label
    }()
    
    lazy private var weatherLabel: UILabel = {
        let label = UILabel()
        label.text = "..."
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    lazy private var highLowLabel: UILabel = {
        let label = UILabel()
        label.text = "Max: .. Min: .."
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
        changeAllTextColor(with: .white)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeAllTextColor(with color: UIColor) {
        let subviews = contentView.subviews
        for subview in subviews {
            if subview is UILabel {
                let currentLabel = subview as! UILabel
                currentLabel.textColor = color
            }
        }
    }
}

extension WeatherTableViewHeaderView: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, with model: WeatherModel) {
        DispatchQueue.main.async {
            self.cityLabel.text = model.cityName
            self.degreeLabel.text = " \(model.temp)º"
            self.weatherLabel.text = model.desc
            self.highLowLabel.text = ("H: \(model.hTemp)º L:\(model.lTemp)º")
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
//MARK: - Setup views and constraints

private extension WeatherTableViewHeaderView {
    
    func setupViews() {
        contentView.addSubview(cityLabel)
        contentView.addSubview(degreeLabel)
        contentView.addSubview(weatherLabel)
        contentView.addSubview(highLowLabel)
    }
    
    func setupConstraints() {
        cityLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(degreeLabel.snp.top).offset(15)
        }
        degreeLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        weatherLabel.snp.makeConstraints { make in
            make.top.equalTo(degreeLabel.snp.bottom).inset(15)
            make.centerX.equalToSuperview()
        }
        highLowLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherLabel.snp.bottom)
            make.centerX.equalToSuperview()
        }
    }
}
