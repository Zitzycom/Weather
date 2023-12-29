//
//  LocationViewModel.swift
//  Weather
//
//  Created by Macbook on 27.12.2023.
//

import Combine
import CoreLocation
import Foundation

class LocationViewModel {
    //MARK: - Publiher
    @Published var weatherLocation: Weather?
    @Published var error: Error?
    private var cancellables = Set<AnyCancellable>()
    //MARK: - Metods
    func fetchWeatherData(for location: CLLocation) {
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&units=metric&appid=\(Constants.apiKey)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Weather.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.error = error
                }
            }, receiveValue: { [weak self] weather in
                self?.weatherLocation = weather
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
