//
//  searchLocation.swift
//  WeatherAppSwift
//
//  Created by Naman Dhiman on 26/11/24.
//

import Foundation
import SwiftUI

struct SearchLocation:View{
    
    @Binding var currentScreen:Screen
    
    @Environment(\.presentationMode) var presentationMode // For dismissing the view
    
    @State var searchText : String = ""
    
    @StateObject private var location = PlacesManager()
    
    @ObservedObject var weatherManager: WeatherManager
    
    
//    private var suggestions: Array<String> = ["Naman","Aman","ram","sham"]
//    
//    var filteredItem: [String] {
//        suggestions.filter{ item in
//            item.isEmpty || item.lowercased().contains(searchText.lowercased())
//        }
//    }
//    
    init(currentScreen: Binding<Screen>,weatherManager: WeatherManager) {
        self._currentScreen = currentScreen
        self.weatherManager = weatherManager
        // Customize the navigation bar appearance
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.black // Background color of the app bar
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white] // Title text color
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white] // Large title text color

        // Apply the appearance
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
//    
    var body: some View{
        NavigationView{
            ZStack{
                Color.black.ignoresSafeArea()
                VStack{
                    
                    TextField("Search Weather", text: $searchText).border(.white).padding().textFieldStyle(RoundedBorderTextFieldStyle()).padding().onChange(of: searchText,initial: false){ value,_  in
                        location.getPlaces(name: value)
                    }
                    
                    ForEach($location.places, id:\.id){ $item in
                        Text(item.placeName).foregroundStyle(.white).listRowBackground(Color.black).font(.system(size: 18)).frame(maxWidth: .infinity, alignment: .leading)  // Aligning to the left
                            .padding(.leading).padding(.vertical,10).onTapGesture {
                            weatherManager.fetchWeather(lat: Double(item.latitude), long: Double(item.longitude))
//                            currentScreen = .screen3
                            presentationMode.wrappedValue.dismiss()
                        }
                    }.listStyle(PlainListStyle()).background(.black).padding([.leading, .trailing],20)
                    Spacer()
                    
                }
            }.navigationTitle("Search Weather").navigationBarBackButtonHidden(true).navigationBarTitleDisplayMode(.inline) .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss() // Go back to the previous screen
//                        currentScreen = .screen3
                    }) {
                            Image(systemName: "arrow.backward").foregroundStyle(.white)
                    }
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
    
}

#Preview{
    SearchLocation(currentScreen: .constant(.screen4),weatherManager: WeatherManager())
}




//List(filteredItem, id : \.self){ item in
//    Text(item).foregroundStyle(.white).listRowBackground(Color.black)
//}.listStyle(PlainListStyle()).background(.black).padding([.leading, .trailing],20)
