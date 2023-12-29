//
//  WeatherForecastTableViewCell.swift
//  Weather
//
//  Created by Macbook on 20.12.2023.
//

import UIKit

class WeatherForecastTableViewCell: UITableViewCell {
    static var identifier: String {"\(Self.self)"}
    
    //MARK: - Private properties
    private lazy var feelsLikeLabel: UILabel = { setLabel() }()
    
    private lazy var tempLabel: UILabel = {
        setLabel()
        }()

    private lazy var visibility: UILabel = {
        setLabel()
    }()
    
    private lazy var timeLabel: UILabel = {
        setLabel()
    }()
        
    private lazy var speedWindLabel: UILabel = {
        setLabel()
    }()
    
    //MARK: - Live cicle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        [tempLabel, visibility, timeLabel, speedWindLabel, feelsLikeLabel].forEach { label in
            contentView.addSubview(label)
        }
        contentView.backgroundColor = .gray
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Metods
    override func prepareForReuse() {
        super.prepareForReuse()
        tempLabel.text = nil
        visibility.text = nil
        timeLabel.text = nil
        speedWindLabel.text = nil
        feelsLikeLabel.text = nil
    }
    
    func configure(weather: HourlyWeather) {
        tempLabel.text = "\(weather.main.temp)"
        visibility.text = "Видимость \(weather.visibility) м"
        timeLabel.text = weather.dtTxt
        speedWindLabel.text = "Скорость ветра \(weather.wind.speed) м/с"
        feelsLikeLabel.text = "Ощщущается как \(weather.main.feelsLike)"
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: topAnchor, constant: .zero),
            timeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            tempLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: .zero),
            tempLabel.bottomAnchor.constraint(equalTo: feelsLikeLabel.topAnchor, constant: .zero),
            tempLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            feelsLikeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            feelsLikeLabel.bottomAnchor.constraint(equalTo: visibility.topAnchor, constant: .zero),
            
            visibility.rightAnchor.constraint(equalTo: rightAnchor, constant: -LocalConstants.smallIndent),
            visibility.bottomAnchor.constraint(equalTo: speedWindLabel.topAnchor, constant: .zero),
                
            speedWindLabel.rightAnchor.constraint(equalTo: rightAnchor , constant: -LocalConstants.smallIndent),
            speedWindLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: .zero),])
        }
    
    private func setLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: LocalConstants.fontSize, weight: .medium)
        return label
    }
}

extension WeatherForecastTableViewCell {
    private struct LocalConstants{
        static let smallIndent: CGFloat = 8
        static let fontSize: CGFloat = 16
    }
}
