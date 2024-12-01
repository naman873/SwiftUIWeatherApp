//
//  splash_screen.swift
//  WeatherAppSwift
//
//  Created by Naman Dhiman on 25/11/24.
//

import Foundation
import SwiftUI

struct SplashScreen:View {
    @State var showSplashScreen:Bool = false
    @Binding var currentScreen:Screen
    var body: some View {
        ZStack{
            
                Rectangle().background(.black)
                VStack{
                    Image("splash").resizable().scaledToFit().frame(width: 300,height:300)
                    Text("Weather App").foregroundStyle(.white).font(.system(size: 30))
                }
            
        }.onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now()+2){
                withAnimation{
//                    self.showSplashScreen=true;
                    currentScreen = .screen2
                }
            }
        }
    }
}


#Preview {
    SplashScreen(currentScreen: .constant(.screen1))
}
