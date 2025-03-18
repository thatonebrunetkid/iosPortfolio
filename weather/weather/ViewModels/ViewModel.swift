//
//  ViewModel.swift
//  weather
//
//  Created by Mateusz Augustyniak on 18/03/2025.
//
import Foundation
import Combine
class WeatherViewModel: ObservableObject
{
    @Published var weather: WeatherModel?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    func fetchWeather(latitude: Double, longitude: Double)
    {
        isLoading = true
        errorMessage = nil
        
        WeatherService.shared.fetchWeather(lat: latitude, lon: longitude)
        {
            [weak self] result in
            DispatchQueue.main.async
            {
                self?.isLoading = false
                switch result
                {
                case .success(let weatherData):
                    self?.weather = weatherData
                case .failure(let error):
                    self?.errorMessage = "Something went wrong"
                }
            }
        }
    }
}
