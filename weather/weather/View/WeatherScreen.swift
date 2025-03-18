//
//  WeatherScreen.swift
//  weather
//
//  Created by Mateusz Augustyniak on 18/03/2025.
//
import Foundation
import SwiftUI
import Lottie
import CoreLocation
import SwiftUICore

struct WeatherScreen: View
{
    @StateObject private var viewModel = WeatherViewModel()
    @State private var locationManager = CLLocationManager()
    var body: some View
    {
        NavigationStack
        {
            ZStack{
                Color(.black).ignoresSafeArea()
                
                if let weather = viewModel.weather
                {
                    var sunriseTime: String
                    {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "HH:mm"
                        let sunriseDate = Date(timeIntervalSince1970: TimeInterval(weather.sys.sunrise))
                        return dateFormatter.string(from: sunriseDate)
                    }
                    
                    var sunsetTime: String
                    {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "HH:mm"
                        let sunsetDate = Date(timeIntervalSince1970: TimeInterval(weather.sys.sunset))
                        return dateFormatter.string(from: sunsetDate)
                    }
                    
                    VStack{
                        ZStack
                        {
                            RoundedRectangle(cornerRadius: 24, style: .continuous)
                                .foregroundStyle(.tint)
                                .aspectRatio(1.618, contentMode: .fit)
                            HStack
                            {
                                VStack{
                                    Text(weather.name)
                                        .font(.system(size: 20))
                                        .foregroundColor(.white)
                                        .padding(.leading, 30)
                                    HStack{
                                        Text("\(Int(weather.main.temp))")
                                            .font(.system(size: 70))
                                            .foregroundColor(.white)
                                            .padding(.leading, 30)
                                        Image(.celsius)
                                            .resizable()
                                            .frame(width: 80, height: 80)
                                    }.padding(.leading, 10)
                                    Text(weather.weather.first!.description)
                                        .font(.system(size: 20))
                                        .foregroundColor(.white)
                                        .padding(.leading, 50)
                                }
                                VStack{
                                    LottieView(animation: .named("01"))
                                        .playing()
                                        .looping()
                                        .padding(.trailing, 10)
                                        .frame(width: 150, height: 150)
                                }
                            }
                        }.padding()
                        
                        VStack
                        {
                            HStack
                            {
                                ZStack
                                {
                                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                                        .foregroundStyle(.gray)
                                        .frame(width: 150, height: 150)
                                    VStack{
                                        Image(.wind)
                                            .resizable()
                                            .frame(width: 100, height: 100)
                                        Text("Speed: \(weather.wind.speed)")
                                            .font(.system(size: 15))
                                            .foregroundColor(.black)
                                        Text("Deg: \(weather.wind.deg)")
                                            .font(.system(size: 15))
                                            .foregroundColor(.black)
                                    }.padding()
                                }
                                
                                ZStack{
                                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                                        .foregroundStyle(.gray)
                                        .frame(width: 150, height: 150)
                                    VStack{
                                        Image(.clouds)
                                            .resizable()
                                            .frame(width: 100, height: 100)
                                        Text("Level: \(weather.clouds.all)")
                                            .font(.system(size: 15))
                                            .foregroundColor(.black)
                                        Text("Visibility: \(weather.visibility)")
                                            .font(.system(size: 15))
                                            .foregroundColor(.black)
                                    }.padding()
                                }
                            }
                            
                            HStack
                            {
                                ZStack
                                {
                                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                                        .foregroundStyle(.gray)
                                        .frame(width: 150, height: 150)
                                    VStack
                                    {
                                        Image(.thermometer)
                                            .resizable()
                                            .frame(width: 80, height: 80)
                                        Text("Feels like: \(Int(weather.main.feels_like))")
                                            .font(.system(size: 15))
                                            .foregroundColor(.black)
                                        Text("Min: \(Int(weather.main.temp_min))")
                                            .font(.system(size: 15))
                                            .foregroundColor(.black)
                                        Text("Max: \(Int(weather.main.temp_max))")
                                            .font(.system(size: 15))
                                            .foregroundColor(.black)
                                    }.padding()
                                    
                                }
                                
                                ZStack{
                                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                                        .foregroundStyle(.gray)
                                        .frame(width: 150, height: 150)
                                    VStack
                                    {
                                        Image(.eclipse)
                                            .resizable()
                                            .frame(width: 100, height: 100)
                                        Text("Pressure: \(weather.main.pressure)")
                                            .font(.system(size: 15))
                                            .foregroundColor(.black)
                                        Text("Humidity: \(weather.main.humidity)")
                                            .font(.system(size: 15))
                                            .foregroundColor(.black)
                                    }.padding()
                                }
                            }
                            
                            HStack
                            {
                                ZStack
                                {
                                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                                        .foregroundColor(.gray)
                                        .frame(width: 300, height: 150)
                                    HStack
                                    {
                                        Image(.sunset)
                                            .resizable()
                                            .frame(width: 150, height: 150)
                                        VStack
                                        {
                                            Text("Sunrise: \(sunsetTime)")
                                                .font(.system(size: 15))
                                                .foregroundColor(.black)
                                            Text("Sunset: \(sunriseTime)")
                                                .font(.system(size: 15))
                                                .foregroundColor(.black)
                                        }
                                    }.padding()
                                }
                            }
                        }
                    }
                }
            }
        }.onAppear(perform: {
            requestLocation()
        })
    }
    
    private func requestLocation()
    {
        locationManager.requestWhenInUseAuthorization()
        if let location = locationManager.location{
            viewModel.fetchWeather(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        }
    }
}
