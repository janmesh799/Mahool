//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Harsh Yadav on 14/01/22.
//

import Foundation

enum ViewState{
    case sucess
    case failure
    case loading
    case notFound
}

class HomeViewModel:ObservableObject{
    //input
    @Published var userInput:String = ""
    
    //response
    @Published var cityName:String = "Bikaner"
    @Published var temps:String = "69"
    @Published var description:String = "Description"
    @Published var country:String = "XX"
    @Published var img:String = "bolt.fill"
    @Published var data:HomeModel?
    
    
    @Published var state:ViewState = .sucess
    let vm = Networking()
    func getWeatherData(){
        
        vm.Networking(city: userInput) { [weak self] (result:Result<HomeModel,networkingError>) in
            switch result {
            case .success(let success):
                
                DispatchQueue.main.async {
                    let temp = success.main?.temp ?? 69

                    self?.temps = "\(round((temp-273.15)*100)/100)"
                    self?.description = success.weather?.first?.main ?? "-"
                    self?.cityName = success.name ?? "--"
                    self?.country = success.sys?.country ?? "Hot"
                    self?.state = .sucess
                    self?.img = success.weather?.first?.main ?? "aqi.low"

                    self?.data = success
//                    data?.main?.tempMax = round((temp-273.15)*100)/100
                    switch success.weather?.first?.main{
                    case "clear sky":
                        self?.img = "sun.max.fill"
                           
                    case "few clouds":
                        self?.img = "cloud.sun.rain"

                    case "scattered clouds":
                        self?.img = "cloud.fill"
                            
                    case "broken clouds":
                        self?.img = "cloud.fill"

                    case "shower rain":
                        self?.img = "cloud.rain.rain"

                    case "rain":
                        self?.img = "cloud.heavyrain.fill"

                    case "thunderstorm":
                        self?.img = "cloud.bolt.rain.fill"
    
                    case "snow":
                        self?.img = "cloud.snow.fill"

                    case "mist":
                        self?.img = "cloud.fog.fill"

                    case "Drizzle":
                        self?.img = "cloud.drizzle.fill"

                    case "Rain":
                        self?.img = "cloud.bolt.rain.fill"

                    case "Smoke":
                        self?.img = "smoke.fill"

                    case "Haze":
                        self?.img = "cloud.fog.fill"

                    case "Dust":
                        self?.img = "sun.dust.fill"

                    case "Fog":
                        self?.img = "cloud.fog.fill"

                    case "Ash":
                        self?.img = "sun.dust"

                    case "Sand":
                        self?.img = "sun.dust.fill"

                    case "Squall":
                        self?.img = "wind"
                            
                    case "Tornado":
                        self?.img = "tornado"

                    case "Clear":
                        self?.img = "sun.min.fill"

                    case "Clouds":
                        self?.img = "cloud.fill"

                    default:
                        self?.img = "sun.max.fill"

                    }
                }
                
            case .failure(let failure):
                DispatchQueue.main.async {
                    switch failure{
                    case .notFound:
                        self?.state = .notFound
                    case .invalidInput:
                        self?.state = .failure
                    case .invalidURL:
                        self?.state = .failure
                    case .badResponse:
                        self?.state = .failure
                    case .error:
                        self?.state = .failure
                    case .nilData:
                        self?.state = .notFound
                    }
                }
            }
        }
    }
}
