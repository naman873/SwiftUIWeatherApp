//
//  RootView.swift
//  WeatherAppSwift
//
//  Created by Naman Dhiman on 27/11/24.
//

import Foundation
import SwiftUI

struct RootView: View {
    @State var currentPage: Screen = .screen1
    
    @StateObject private var locationManager = LocationManager()
    @StateObject private var weatherManager = WeatherManager()
    var body: some View {
        VStack{
            switch currentPage{
            case .screen1:
                SplashScreen(currentScreen: $currentPage)
            case .screen2:
                LoginPage(currentScreen: $currentPage)
            case .screen3:
                Dashboard(currentScreen: $currentPage, locationManager: locationManager,
                          weatherManager: weatherManager)
            case .screen4:
                SearchLocation(currentScreen: $currentPage, weatherManager: weatherManager)
            }
        }
    }
}

enum Screen{
    
    case screen1, screen2, screen3, screen4
}

#Preview{
    RootView()
}
