//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Macbook on 31.10.2023.


import UIKit
import Combine
import CoreLocation

class WeatherViewModel {
    //MARK: - Publisher
    @Published var weather: Weather?
    @Published var error: Error?
    private var cancellables = Set<AnyCancellable>()
    //MARK: - Metods
    func fetchWeatherData(for location: String) {
        guard let encodedLocation = location.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        let urlString = "https:/api.openweathermap.org/data/2.5/forecast?q=\(encodedLocation)&units=metric&appid=\(Constants.apiKey)"
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Weather.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.error = error
                }
            }, receiveValue: { [weak self] weather in
                self?.weather = weather
            })
            .store(in: &cancellables)
    }
    
    func updateView(with weather: Weather?, views: ViewCurrentWeather) {
        if let weather = weather {
            views.listArray = weather.list
            views.labelCity.text = weather.city.name
            views.currentTempLabel.text = "\(weather.list[0].main.temp)°C"
            views.tempminMax.text = "Макс.:\(weather.list[0].main.tempMax)°, мин.:\(weather.list[0].main.tempMin)°"
        } else {
            views.labelCity.text = "Ошибка загрузки данных"
        }
    }
}
