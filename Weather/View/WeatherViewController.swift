//
//  WeatherViewController.swift
//  Weather
//
//  Created by Macbook on 31.10.2023.
//

import UIKit
import Combine

class WeatherViewController: UIViewController {
    //MARK: - Private properties
    private let views = ViewCurrentWeather()
    private let locationManager = LocationManager()
    private let viewModel = LocationViewModel()
    private var cancellables = Set<AnyCancellable>()
    //MARK: - Live cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        views.frame = self.view.bounds
        getCurrentWeather()
    }
    //MARK: - Flow
    func getCurrentWeather() {
        locationManager.$location
            .compactMap { $0 }
            .sink { [weak self] location in
                guard let self else {return}
                self.viewModel.fetchWeatherData(for: location)
            }
            .store(in: &cancellables)

        viewModel.$weatherLocation
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] weather in
                guard let self else {return}
                self.viewModel.updateView(with: weather, views: self.views)
                self.view.addSubview(self.views)
            })
            .store(in: &cancellables)
    }
}
