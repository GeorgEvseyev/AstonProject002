//
//  Model.swift
//  AstonProject002
//
//  Created by Георгий Евсеев on 10.10.23.
//

import Foundation


struct Weather: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

struct Main: Codable {
    var temp: Double = 0.0
    var pressure: Int = 0
    var humidity: Int = 0
}

struct WeatherData: Codable {
    var weather: [Weather] = []
    var main: Main = Main()
    var name: String = "city..."
    
}

