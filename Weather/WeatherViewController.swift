//
//  WeatherViewController.swift
//  Weather
//
//  Created by Macbook on 31.10.2023.
//


import UIKit
import Combine

class WeatherViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var myLocationTempLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBAction func getMyPosTemp(_ sender: Any) {
        
    }
    
    var viewModel = WeatherViewModel()
    var cancellables = Set<AnyCancellable>()
       
       override func viewDidLoad() {
           super.viewDidLoad()
           
           viewModel.$weather
               .receive(on: DispatchQueue.main)
               .sink { [weak self] weather in
                   self?.updateView(with: weather)
               }
               .store(in: &cancellables)
           
           searchTextField.delegate = self
       }
       
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           textField.resignFirstResponder()
           if let city = textField.text {
               viewModel.fetchWeatherData(for: city)
           }
           return true
       }
       
       private func updateView(with weather: Weather?) {
           if let weather = weather {
               cityLabel.text = weather.name
               temperatureLabel.text = "Средняя температура \((weather.main["temp"] ??  0))°C"
           } else {
               cityLabel.text = "Ошибка загрузки данных"
               temperatureLabel.text = ""
           }
       }
   }
