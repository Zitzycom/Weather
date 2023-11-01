//
//  Model.swift
//  Weather
//
//  Created by Macbook on 31.10.2023.
//

import Foundation

struct Weather: Decodable {
    let name: String
    let main: [String: Double]
}
