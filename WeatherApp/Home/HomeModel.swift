//
//  HomeModel.swift
//  WeatherApp
//
//  Created by Harsh Yadav on 14/01/22.
//

import Foundation
let apiKey = "40e22274d96b307af48ca2883d88a538"
/*
 https://api.openweathermap.org/data/2.5/weather?q=Bikaner&appid=40e22274d96b307af48ca2883d88a538
 
 api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}
 */

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let jSON = try? newJSONDecoder().decode(JSON.self, from: jsonData)

import Foundation

// MARK: - JSON
/*
 clear sky -> sun.max.fill
 few clouds -> cloud.sun.rain
 scattered clouds -> cloud.fill
 *broken clouds -> cloud.fill
 shower rain -> cloud.rain.fill
 rain ->  cloud.heavyrain.fill
 thunderstorm -> cloud.bolt.rain.fill
 snow -> cloud.snow.fill
 mist -> cloud.fog.fill
 
 Drizzle -> cloud.drizzle.fill
 Rain -> cloud.bolt.rain.fill
 Smoke -> smoke.fill
 Haze -> cloud.fog.fill
 Dust -> sun.dust.fill
 Fog -> cloud.fog.fill
 Sand -> sun.dust.fill
 Dust -> sun.dust
 *Ash -> sun.dust
 Squall -> wind
 Tornado -> tornado
 Clear -> sun.min.fill
 Clouds -> cloud.fill
 */

struct HomeModel: Codable {
    let coord: Coord?
    let weather: [Weather]?
    let base: String?
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let clouds: Clouds?
    let dt: Int?
    let sys: Sys?
    let timezone: Int?
    let id: Int?
    let name: String?
    let cod: Int?

    enum CodingKeys: String, CodingKey {
        case coord = "coord"
        case weather = "weather"
        case base = "base"
        case main = "main"
        case visibility = "visibility"
        case wind = "wind"
        case clouds = "clouds"
        case dt = "dt"
        case sys = "sys"
        case timezone = "timezone"
        case id = "id"
        case name = "name"
        case cod = "cod"
    }
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int?

    enum CodingKeys: String, CodingKey {
        case all = "all"
    }
}

// MARK: - Coord
struct Coord: Codable {
    let lon: Double?
    let lat: Double?

    enum CodingKeys: String, CodingKey {
        case lon = "lon"
        case lat = "lat"
    }
}

// MARK: - Main
struct Main: Codable {
    let temp: Double?
    let feelsLike: Double?
    let tempMin: Double?
    let tempMax: Double?
    let pressure: Int?
    let humidity: Int?

    enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure = "pressure"
        case humidity = "humidity"
    }
}

// MARK: - Sys
struct Sys: Codable {
    let type: Int?
    let id: Int?
    let country: String?
    let sunrise: Int?
    let sunset: Int?

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case id = "id"
        case country = "country"
        case sunrise = "sunrise"
        case sunset = "sunset"
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int?
    let main: String?
    let weatherDescription: String?
    let icon: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case main = "main"
        case weatherDescription = "description"
        case icon = "icon"
    }
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double?
    let deg: Int?

    enum CodingKeys: String, CodingKey {
        case speed = "speed"
        case deg = "deg"
    }
}
