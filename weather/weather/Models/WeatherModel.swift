//
//  WeatherModel.swift
//  weather
//
//  Created by Mateusz Augustyniak on 18/03/2025.
//
import Foundation
struct Sys: Codable
{
    let country: String
    let sunrise: Int
    let sunset: Int
}

struct Clouds: Codable
{
    let all: Int
}

struct Wind: Codable
{
    let speed: Double
    let deg: Int
    let gust: Double?
}

struct Main: Codable
{
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
}

struct Weather: Codable
{
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Coord: Codable
{
    let lon: Double
    let lat: Double
}

struct WeatherModel: Codable
{
    let coord: Coord
    let weather: [Weather]
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let sys: Sys
    let name: String
    let timezone: Int
    let id: Int
    let cod: Int
}
