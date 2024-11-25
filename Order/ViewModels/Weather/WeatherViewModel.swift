//
//  WeatherViewModel.swift
//  Order
//
//  Created by anh on 2024/11/24.
//

import Foundation

class WeatherViewModel: ObservableObject {
    var listWeather: [WeatherModel]
    var weather: WeatherModel
    init() {
        listWeather = [
            WeatherModel(name: "weather_hare", icon: "hare_48dp", value: WeatherState.hare.rawValue),
            WeatherModel(name: "weather_kumori", icon: "kumori_48dp", value: WeatherState.kumori.rawValue),
            WeatherModel(name: "weather_ame", icon: "ame_48dp", value: WeatherState.ame.rawValue),
            WeatherModel(name: "weather_yuki", icon: "yuki_48dp", value: WeatherState.yuki.rawValue),
            WeatherModel(name: "weather_hare_kumori", icon: "hare_kumori_48dp", value: WeatherState.harekumori.rawValue),
            WeatherModel(name: "weather_kumori_hare", icon: "kumori_hare_48dp", value: WeatherState.kumorihare.rawValue)
        ]
        
        weather = listWeather.first(where: { $0.value == Config.pref.lastWeather}) ?? listWeather.first(where: { $0.value == WeatherState.hare.rawValue})!
    }
}
