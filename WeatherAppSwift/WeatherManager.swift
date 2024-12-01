//
//  WeatherManager.swift
//  WeatherAppSwift
//
//  Created by Naman Dhiman on 27/11/24.
//

import Foundation

class WeatherManager: ObservableObject{
    
//    private let apiKey = "f6ecf2f6f958a9aed7631592550608fe"
    private let apiKey = Constants.apiKey
//    private let baseUrl = "https://api.openweathermap.org/data/2.5/weather"
    private let baseUrl = Constants.baseUrl
    
    @Published var temperature: Double?
    @Published var weather: WeatherResponse? = nil
    @Published var error: String?
    
    func fetchWeather(lat: Double, long: Double){
        
        let urlString = "\(baseUrl)?lat=\(lat)&lon=\(long)&appid=\(apiKey)&units=metric"
//        print("lat \(lat) lon \(long)")
        guard let url = URL(string: urlString) else{
            error = "Invalid Url"
            return
        }
        
        URLSession.shared.dataTask(with: url){ data, response, error in
            
            if let error = error{
                DispatchQueue.main.async {
                    self.error = "Error: \(error.localizedDescription)"
                }
                return
            }
            //lat 28.6138954 lon 77.2090057
            //lat 37.785834 lon -122.406417
            
            guard let data = data else{
                DispatchQueue.main.async {
                    self.error = "No Data"
                }
                return
            }
            
            //Printing of data from api
//            do{
//                let data = try JSONSerialization.jsonObject(with: data)
//                print("data is \(data)")
//            }catch{
//                print("error in serialization of data")
//            }
            
            do {
                let weatherData = try JSONDecoder().decode(WeatherResponse.self, from: data)
                DispatchQueue.main.async{
                    print("place name \(weatherData.name) lat \(lat) lon \(long)")
                    self.weather = weatherData
                    self.temperature = weatherData.main.temp
                    self.weather?.weatherMessage = getMessage(temp: Int(self.temperature ?? 0.0))
                }
            }
            catch{
                DispatchQueue.main.async {
                                   self.error = "Failed to decode data"
                               }
            }
        }.resume()
        
    }
    
    
}

func getMessage(temp: Int)-> String {
  if (temp > 25) {
    return "It's 🍦 time";
  } else if (temp > 20) {
    return "Time for shorts and 👕";
  } else if (temp < 10) {
    return "You'll need 🧣 and 🧤";
  } else {
    return "Bring a 🧥 just in case";
  }
}

struct WeatherResponse: Codable {
    struct Main: Codable {
        var temp: Double
    }
    struct Weather: Codable{
        var main: String
        var description: String
    }
    var main: Main
    var name: String
    var weather: [Weather]
    var weatherMessage: String?
}
