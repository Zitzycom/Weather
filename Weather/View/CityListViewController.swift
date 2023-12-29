//
//  CityListViewController.swift
//  Weather
//
//  Created by Macbook on 21.12.2023.
//

import UIKit
import Combine

class CityListViewController: UIViewController, UITextFieldDelegate {
    //MARK: - Private properties
    private let labelWeather: UILabel = {
        let label = UILabel()
        label.text = LocalConstants.labelText
        label.translatesAutoresizingMaskIntoConstraints = false
        return  label
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = LocalConstants.placeholderText
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let weatherView = ViewCurrentWeather()
    private let viewModel = WeatherViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: - Live cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        getPermanentConstraints()
        textField.delegate = self
    }
    //MARK: - Private metods
    private func addSubviews() {
        [textField, labelWeather].forEach { views in
            views.backgroundColor = .gray
            self.view.addSubview(views)
        }
    }
    
    private func getPermanentConstraints() {
        NSLayoutConstraint.activate([
            labelWeather.topAnchor.constraint(equalTo: view.topAnchor, constant: LocalConstants.mediumIndent),
            labelWeather.leftAnchor.constraint(equalTo: view.leftAnchor, constant: LocalConstants.smallIndent),
            labelWeather.widthAnchor.constraint(equalToConstant: LocalConstants.widthLabel), labelWeather.heightAnchor.constraint(equalToConstant: LocalConstants.heightLabel),
            
            textField.topAnchor.constraint(equalTo: labelWeather.bottomAnchor, constant: LocalConstants.mediumIndent), textField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: LocalConstants.smallIndent), textField.widthAnchor.constraint(equalToConstant: LocalConstants.widthLabel), textField.heightAnchor.constraint(equalToConstant: LocalConstants.heightLabel)
        ])
    }
    
    private func getWeatherViewConstraint() {
        NSLayoutConstraint.activate([
            weatherView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: LocalConstants.mediumIndent), weatherView.centerXAnchor.constraint(equalTo: view.centerXAnchor), weatherView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -LocalConstants.smallIndent), weatherView.widthAnchor.constraint(equalToConstant: LocalConstants.widthLabel)])
    }
    
    private func getCurrentWeather() {
        viewModel.$weather
            .receive(on: DispatchQueue.main)
            .sink { [weak self] weather in
                guard let self else {return}
                self.viewModel.updateView(with: weather, views: self.weatherView)
            }
            .store(in: &cancellables)
    }
    
    //MARK: - Delegate metods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        weatherView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(weatherView)
        getCurrentWeather()
        getWeatherViewConstraint()
        textField.resignFirstResponder()
        if let city = textField.text {
            self.viewModel.fetchWeatherData(for: city)
        }
        return true
    }
}
//MARK: - Local constants
extension CityListViewController {
    private struct LocalConstants {
        static let heightLabel: CGFloat = 30
        static let widthLabel: CGFloat = 250
        static let mediumIndent: CGFloat = 20
        static let smallIndent: CGFloat = 10
        static let labelText = "Погода"
        static let placeholderText = "Введите название города"

    }
}
