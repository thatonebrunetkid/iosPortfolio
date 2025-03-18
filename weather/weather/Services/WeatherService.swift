//
//  WeatherService.swift
//  weather
//
//  Created by Mateusz Augustyniak on 18/03/2025.
//

import Foundation
import Alamofire

class WeatherService
{
    static let shared = WeatherService()
    
    private let apiKey = "67c6dc4a26e5f5af6ce5ede347e86113"
    private let baseUrl = "https://api.openweathermap.org/data/2.5/weather"
    
    func fetchWeather(lat: Double, lon: Double, completion: @escaping (Result<WeatherModel, Error>) -> Void)
    {
        let parameters: [String: Any] = [
            "lat": lat,
            "lon": lon,
            "appid": apiKey,
            "units": "metric",
            "lang": "pl"
        ]
        
        AF.request(baseUrl, parameters: parameters)
            .validate()
            .responseDecodable(of: WeatherModel.self)
        {
            response in
            switch response.result
            {
            case .success(let weatherData):
                completion(.success(weatherData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
