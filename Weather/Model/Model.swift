//
//  Model.swift
//  Weather
//
//  Created by Macbook on 31.10.2023.
//

import Foundation
//MARK: - Models Weather Data
struct Weather: Codable {
    let list: [HourlyWeather]
    let city: City
}

struct City: Codable {
    let name: String
}

struct HourlyWeather: Codable {
    let main: MainDetails
    let wind: Wind
    let visibility: Int
    let dtTxt: String

    enum CodingKeys: String, CodingKey {
        case main, wind, visibility
        case dtTxt = "dt_txt"
    }
}

struct MainDetails: Codable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct Wind: Codable {
    let speed: Double
}
