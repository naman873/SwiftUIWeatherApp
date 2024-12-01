//
//  ContentView.swift
//  WeatherAppSwift
//
//  Created by Naman Dhiman on 21/11/24.
//

import SwiftUI

struct LoginPage: View {
    @State private var userName:String = "";
    @State private var password:String = "";
    @Binding var currentScreen:Screen


    var body: some View {
       
            VStack(alignment:.center,spacing: 20, content: {
                Image("rain").resizable().scaledToFill().frame(height: 400).clipped()
                
                Text("Welcome").foregroundStyle(.white).font(.system(size: 30,weight: .bold)).padding()
                
                TextField("Enter UserName",text: $userName).padding().background(.white).cornerRadius(10).overlay(RoundedRectangle(cornerRadius: 10).stroke(.white,lineWidth: 2)).padding()
                
                TextField("Enter Password",text: $password).padding().background(.white).cornerRadius(10).padding()
                
                Button(action: {
                    currentScreen = .screen3
                }){
                    Text("Login").font(.system(size: 25,weight: .bold)).foregroundStyle(.green).padding(.horizontal,20)
                }
                Spacer()
                
            }).background(.black).ignoresSafeArea().navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    LoginPage(currentScreen: .constant(.screen2))
}


//                Button(action: {}){
//                    Text("Login").font(.system(size: 25,weight: .bold)).foregroundStyle(.green).padding(.horizontal,20).padding(.vertical,5)
//                }.background(.white).cornerRadius(8).padding(.horizontal,20)

//            VStack(alignment: .center, content: {
//                HStack(alignment: .bottom, content: {
//                    Image(systemName: "globe")
//                        .imageScale(.large)
//                        .foregroundStyle(.black)
//                    Text("Hello, world!")
//                }).padding()
//                TextField("Name",text:$userName).border(Color.black).padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
//
//                NavigationLink(destination: SecondPage()){
//                    Text("Second page")
//                }.navigationBarBackButtonHidden(true)
//            })
