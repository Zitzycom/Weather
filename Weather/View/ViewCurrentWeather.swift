//
//  ViewCurrentWeather.swift
//  Weather
//
//  Created by Macbook on 20.12.2023.
//

import UIKit

class ViewCurrentWeather: UIView {
    
    //MARK: - Properties
    lazy var labelCity: UILabel = {
        setLabel()
    }()
    
    lazy var currentTempLabel: UILabel = {
        setLabel()
    }()
    
     lazy var tempminMax: UILabel = {
        setLabel()
    }()

    var listArray: [HourlyWeather] = [] {
        didSet {
            tableWeatherForecast.reloadData()
        }
    }

    private lazy var tableWeatherForecast: UITableView = {
        let tableWeatherForecast = UITableView()
        tableWeatherForecast.backgroundColor = .gray
        tableWeatherForecast.register(WeatherForecastTableViewCell.self, forCellReuseIdentifier: WeatherForecastTableViewCell.identifier)
        tableWeatherForecast.rowHeight = UITableView.automaticDimension
        tableWeatherForecast.estimatedRowHeight = .leastNonzeroMagnitude
        tableWeatherForecast.translatesAutoresizingMaskIntoConstraints = false
        return tableWeatherForecast
    }()
    
    //MARK: - Live cicle
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableWeatherForecast.delegate = self
        tableWeatherForecast.dataSource = self
        addViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Metods
    private func setLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .gray
        return label
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            labelCity.centerXAnchor.constraint(equalTo: centerXAnchor), labelCity.topAnchor.constraint(equalTo: topAnchor, constant: LocalConstants.mediumIndent), labelCity.widthAnchor.constraint(equalToConstant: LocalConstants.widthLabel), labelCity.heightAnchor.constraint(equalToConstant: LocalConstants.heightLabel),
        
            currentTempLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            currentTempLabel.topAnchor.constraint(equalTo: labelCity.bottomAnchor, constant: LocalConstants.smallIndent), currentTempLabel.widthAnchor.constraint(equalToConstant: LocalConstants.widthLabel),
            currentTempLabel.heightAnchor.constraint(equalToConstant: LocalConstants.heightLabel),
        
        tempminMax.centerXAnchor.constraint(equalTo: centerXAnchor), tempminMax.topAnchor.constraint(equalTo: currentTempLabel.bottomAnchor, constant: LocalConstants.smallIndent), tempminMax.widthAnchor.constraint(equalToConstant: LocalConstants.widthLabel), tempminMax.heightAnchor.constraint(equalToConstant: LocalConstants.heightLabel),

            tableWeatherForecast.centerXAnchor.constraint(equalTo: centerXAnchor), tableWeatherForecast.topAnchor.constraint(equalTo: tempminMax.bottomAnchor, constant: LocalConstants.smallIndent), tableWeatherForecast.leftAnchor.constraint(equalTo: leftAnchor, constant: LocalConstants.smallIndent), tableWeatherForecast.rightAnchor.constraint(equalTo: rightAnchor, constant: -LocalConstants.smallIndent),
            tableWeatherForecast.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -LocalConstants.bigIndent)])
    }
    
    private func addViews() {
        [labelCity, currentTempLabel, tempminMax, tableWeatherForecast].forEach { view in
            addSubview(view)
        }
    }
}
//MARK: - Extension
extension ViewCurrentWeather: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableWeatherForecast.dequeueReusableCell(withIdentifier: WeatherForecastTableViewCell.identifier, for: indexPath) as? WeatherForecastTableViewCell else {return UITableViewCell()}
        let list = self.listArray[indexPath.row]
        cell.configure(weather: list)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listArray.count
    }
       
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        LocalConstants.sizeTableCell
    }
}

extension ViewCurrentWeather {
    private struct LocalConstants {
        static let sizeTableCell: CGFloat = 100
        static let heightLabel: CGFloat = 50
        static let widthLabel: CGFloat = 250
        static let mediumIndent: CGFloat = 30
        static let smallIndent: CGFloat = 10
        static let bigIndent: CGFloat = 60
    }
}
