//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Macbook on 31.10.2023.
//
import UIKit
import Combine
import CoreLocation

class WeatherViewModel {
    @Published var weather: Weather?
    @Published var error: Error?
    
    private var cancellables = Set<AnyCancellable>()

    
    func fetchWeatherData(for location: String) {
        guard let encodedLocation = location.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }

        let apiKey = "9b225a8d598b08412b9e88bc06835be7"
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(encodedLocation)&units=metric&appid=\(apiKey)"
        print (urlString)
        guard let url = URL(string: urlString) else {
            return
        }
        
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
}




