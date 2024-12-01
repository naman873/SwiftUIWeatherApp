import Foundation


class PlacesManager: ObservableObject {
//    private var baseUrl = "https://api.mapbox.com/geocoding/v5/mapbox.places/"
    private var baseUrl = Constants.baseUrlPlaces
    @Published var error: String?
    @Published var places: [PlaceModel] = []
//    private var token = "pk.eyJ1IjoibmFtYW4wMDA3IiwiYSI6ImNsbjkyMGs3ZDAzZDAycWxiaXFhc283dzEifQ.KU3Xpxbpv7YMWELZfoVG8Q"
    
    private var token = Constants.token
    
    func getPlaces(name: String) {
        // Construct the URL with the place name and token
        let urlString = "\(baseUrl)\(name).json?access_token=\(token)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                DispatchQueue.main.async {
                    self.error = "Error: \(error.localizedDescription)"
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.error = "Invalid URL or empty data."
                }
                return
            }
            
            // Debug: print the raw JSON
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                print("Data from API is \(jsonObject)")
            } catch {
                print("Error parsing JSON: \(error)")
            }
            
            // Decode the data into PlaceResponse and map to PlaceModel
            do {
                let placeResponse = try JSONDecoder().decode(PlaceResponse.self, from: data)
                
                // Map the features to PlaceModel
                DispatchQueue.main.async {
                    self.places = placeResponse.features.map {
                        PlaceModel(
                            placeName: $0.place_name,
                            latitude: $0.geometry.coordinates[1],
                            longitude: $0.geometry.coordinates[0]
                        )
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.error = "Failed to decode data."
                }
            }
            
        }.resume()
    }
}


//struct PlaceModel: Codable, Identifiable, Hashable{
//    var place_id: Int
//    var display_name: String
//    var lat: String
//    var lon: String
//    var id: Int { place_id }
//}

//struct PlaceResponse: Decodable {
//    let features: [PlaceFeature]
//}
//
//struct PlaceFeature: Decodable {
//    let place_name: String
//    let geometry: Geometry
//}
//
//struct Geometry: Decodable {
//    let coordinates: [Double] // [longitude, latitude]
//}
//
//struct PlaceModel: Codable, Identifiable, Hashable {
//    var id = UUID()
//    let placeName: String
//    let latitude: Double
//    let longitude: Double
//}

struct PlaceResponse: Decodable {

    let features: [PlaceFeature]
}

// Feature represents each place in the response
struct PlaceFeature: Decodable {
    let id: String
    let place_name: String
    let geometry: Geometry
    
}


// Geometry contains the coordinates of the place
struct Geometry: Decodable {
    let type: String
    let coordinates: [Double] // [longitude, latitude]
}


// PlaceModel for displaying information in your app
struct PlaceModel: Identifiable {
    var id = UUID()
    let placeName: String
    let latitude: Double
    let longitude: Double
}
