//
//  WeatherView.swift
//  Order
//
//  Created by anh on 2024/11/23.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var weatherVm: WeatherViewModel
    var buttonText: LocalizedStringKey
    var buttonClick: () -> Void
    @State private var isShowListWeather: Bool = false
    
    var body: some View {
        VStack {
            ZStack {
                Color.cyan
                VStack {
                    Spacer()
                    Spacer()
                    Text("weather today")
                        .font(.body)
                        .foregroundStyle(.white)
                  
                        
                        Button(action: {
                            withAnimation {
                                isShowListWeather = true
                            }
                        }, label: {
                            HStack {
                                Image(weatherVm.weather.icon)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 36, height: 36)
                                    .padding()
                                    .background(Color.white)
                                    .clipShape(Circle())
                                
                                Image(systemName: !isShowListWeather ? "chevron.down" : "chevron.up")
                                    .font(.body)
                                    .foregroundStyle(.white)
                            }
                        })
                   
                    Spacer()
                    HeadButtonView(text: buttonText, action: buttonClick)
                      
                    Spacer().frame(height: 60)
                }
            }
        }
        .overlayBottom(isPresented: $isShowListWeather, content: {
            DefaultBottomSheet(isPresented: $isShowListWeather, content: {
                WeatherMenuView(isPresented: $isShowListWeather, listWeather: $weatherVm.listWeather, click: { v in
                    weatherVm.weather = weatherVm.listWeather.first(where: {$0.value == v})!
                    Config.pref.setWeather(weather: v)
                })
            })
        })
    }
}

private struct WeatherMenuView: View {
    @Binding var isPresented: Bool
    @Binding var listWeather: [WeatherModel]
    var click: (Int) -> Void
    let columns = [GridItem(.flexible()),
                   GridItem(.flexible()),
                   GridItem(.flexible())]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20, content: {
            ForEach(listWeather) { weather in
                Button(action: {
                    withAnimation {
                        isPresented = false
                    }
                    click(weather.value)
                }, label: {
                    VStack {
                        Image(weather.icon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                        Text(LocalizedStringKey(weather.name))
                            .font(.caption)
                            .foregroundStyle(.black)
                    }
                })
            }
        })
    }
}
