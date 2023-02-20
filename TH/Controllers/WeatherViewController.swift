//
//  ViewController.swift
//  TH
//
//  Created by Бакдаулет Дуйсенбеков on 13.10.2022.
//

//

import UIKit
import SnapKit

final class WeatherViewController: UIViewController {
    
    private var weatherManager = WeatherManager()
    
    lazy private var sectionNames: [String] = ["Windy conditions from 3PM-5pm, with heavy snow expected at 6pM.", "7-day forecast"]
    
    lazy private var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "back.png")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy private var weatherTableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        let headerView = WeatherTableViewHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 275))
        headerView.weatherManager = self.weatherManager 
        tableView.tableHeaderView = headerView
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = true
        tableView.layer.cornerRadius = 20
        
        return tableView
    }()
    
    lazy var searchBar:UISearchBar = {
            let searchBar = UISearchBar()
            searchBar.layer.cornerRadius = 30
            searchBar.placeholder = " What book do you want find..."
            searchBar.backgroundColor = UIColor(red: 230/255, green: 187/255, blue: 148/255, alpha: 1)
            searchBar.searchTextField.backgroundColor = .orange
            searchBar.searchBarStyle = .minimal
            return searchBar
        }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherTableView.dataSource = self
        weatherTableView.delegate = self
        weatherManager.delegate = weatherTableView.tableHeaderView as! any WeatherManagerDelegate
         
        setupViews()
        setupConstraints()
        
        weatherManager.fetchRequest()
        
    }
}

//MARK: - Tableview datasource and delegate methods

extension WeatherViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0: let cell = TableViewCellWithCollectionView()
            cell.backgroundColor = .clear
            return cell
        case 1: let cell = TableViewCellWithTableView()
            cell.backgroundColor = .clear
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension WeatherViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionNames[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.textColor = .white
        }
    }
}

//MARK: - Setup views and constraints

private extension WeatherViewController {
    
    func setupViews() {
        view.addSubview(backgroundImageView)
        view.addSubview(weatherTableView)
    }
    
    func setupConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        weatherTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(10)
            make.leading.trailing.equalToSuperview().inset(25)
        }
    }
}

/*

 SOLID = single respnsibility, open-closed, liskov,
 DRY = Don't repeat yourself
 KISS = keep it simple stupid
 
*/
