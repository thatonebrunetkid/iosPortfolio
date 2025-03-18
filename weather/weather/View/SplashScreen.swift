//
//  SplashScreen.swift
//  weather
//
//  Created by Mateusz Augustyniak on 18/03/2025.
//

import Foundation
import SwiftUI
import Lottie
struct SplashScreen: View
{
    @State private var goToWeather: Bool = false
    
    var body: some View
    {
        NavigationStack
        {
            ZStack
            {
                Color(.purple).ignoresSafeArea()
                VStack
                {
                    LottieView(animation: .named("lottie"))
                        .playing()
                        .looping()
                        .padding(100)
                    
                    Text("gWeather")
                        .font(.system(size: 35))
                        .foregroundColor(.white)
                    
                    Text("powered by")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                    Spacer()
                    HStack
                    {
                        Image(.icon)
                            .resizable()
                            .frame(width: 50, height: 50)
                        Text("graph")
                            .font(.custom("Quicksand-Light", size: 20))
                    }
                }
            }.navigationDestination(isPresented: $goToWeather)
            {
                WeatherScreen().navigationBarBackButtonHidden()
            }
        }.onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0)
            {
                goToWeather = true;
            }
        })
    }
}
