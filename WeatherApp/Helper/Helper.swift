//
//  Helper.swift
//  WeatherApp
//
//  Created by Harsh Yadav on 06/10/22.
//

import Foundation

struct Helper{
    static func handleErrors(error:NetworkingError) async ->String {
        await MainActor.run {
            switch error{
            case .badURL:
                return "Bad URL"
            case .badResponse:
                return "Bad Reponse!"
            case .decodingFailed:
                return "Something went Wrong While Decoding!"
            case .unknownError:
                return "Something Unsual Went Wrong, Please Try Again after Sometime."
            case .encodingFailed:
                return "Encoding Failed!!"
            case .invalidInput:
                return "Invalid Input"
            }
        }
    }
}

struct Constant{
//    static var url:String = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=40e22274d96b307af48ca2883d88a538"
}
