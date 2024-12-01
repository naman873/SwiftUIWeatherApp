//
//  secondPage.swift
//  WeatherAppSwift
//
//  Created by Naman Dhiman on 24/11/24.
//

import Foundation
import SwiftUI


struct CommonTextStyle: ViewModifier{
    
    var weight: Font.Weight
    var size: CGFloat
    var color: Color
    
    func body(content: Content) -> some View {
        content.font(.system(size: size,weight: weight)).foregroundColor(color)
    }
}

extension View{
    func commmonTextStyle(size: CGFloat,weight: Font.Weight = .regular,color: Color)-> some View{
        self.modifier(CommonTextStyle(weight: weight, size: size, color: color))
    }
}

struct Dashboard:View{
    @Binding var currentScreen:Screen
    @ObservedObject var locationManager: LocationManager
    @ObservedObject var weatherManager: WeatherManager


    @State var placeName: String? = nil
    
    
    @State private var screen: Screen = .screen4

    var body: some View{
        NavigationView{
            ZStack{
                
                Image("background").resizable().scaledToFill().frame(height: 1000).clipped()
                
                VStack {
                    
                    if let weather = weatherManager.weather {
                        VStack(alignment:.center) {
                            Text("\(weather.name)").commmonTextStyle(size: 40, weight: .medium, color: .white)
                            
                            Text("\(Int(weather.main.temp))°").commmonTextStyle(size: 100, weight:.ultraLight,color: .white)
                            
                            Text("\(weather.weather[0].main)").commmonTextStyle(size: 25, color: .white)
                            
                            Text("\(weather.weatherMessage ?? "Bring a 🧥 just in case")").commmonTextStyle(size: 25, color: .white).padding(.top,5)
                           
                        }
                        .frame(width: 250).padding(.top,200)
                    }
                    else if let error = weatherManager.error{
                        VStack(alignment:.center) {
                            Text("Latitude \(error)").commmonTextStyle(size: 40, weight: .medium, color: .white)
                           
                        }
                        .frame(width: 200).padding(.top,200)
                    }
                    else{
                        VStack(alignment:.center,spacing:5){
                            Text("Loading..").commmonTextStyle(size: 40, weight: .medium, color: .white)
                    }.frame(width: 200).padding(.top,200)
                    }
                    
                    Spacer()
                    
//                    Button(action:{
//                        currentScreen = .screen4
//                        
//                    }){
//                        Text("Temp° Search").font(.system(size: 25,weight: .bold)).foregroundStyle(.white).padding().background(.blue).cornerRadius(30).padding()
//                    }.navigationBarBackButtonHidden(true)
                    NavigationLink(destination: SearchLocation(currentScreen: $screen, weatherManager: weatherManager)){
                        Text("Temp° Search").font(.system(size: 25,weight: .bold)).foregroundStyle(.white).padding().background(.blue).cornerRadius(30).padding()
                    }
                    
                    Spacer()
                }.onReceive(locationManager.$currentLocation, perform: { location in
                    if let location = location {
                                      weatherManager.fetchWeather(lat: location.coordinate.latitude, long: location.coordinate.longitude)
                                      
                                  }
                })
            }.ignoresSafeArea()
        }
      
        }
    }



#Preview {
    Dashboard(currentScreen: .constant(.screen3),locationManager: LocationManager(),weatherManager: WeatherManager())
}





//struct Person:Identifiable{
//    let name: String
//    let family: String
//    let email: String
//    let id = UUID()
//    var fullName:String {name+" "+family}
//}


//@State private var people=[
//    Person(name: "Naman", family: "Dhiman", email: "TEST@gmail.com"),
//    Person(name: "Aman", family: "Dhiman", email: "TEST1@gmail.com"),
//]
