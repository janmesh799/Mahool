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

struct WeatherData{
    var temp:String
    var country:String
    var cityName:String
    var image:String
    var description:String
    
    var minTemp:String
    var maxTemp:String
    var pressure:String
    var humidity:String
    var windSpeed:String
}
class HomeViewModel:ObservableObject{
    
    let networkingManager = NetworkingManager()
    
    @Published var userInput:String = ""
    @Published var weatherData:WeatherData = WeatherData(temp: "69", country: "--", cityName: "Bikaner", image: "bolt.fill",description: "Description",minTemp: "",maxTemp: "",pressure: "",humidity: "",windSpeed: "")
    
    @Published var responseError:String = ""
    @Published var isLoading:Bool = false
    @Published var showAlert:Bool = false
    
    
    
    func getWeatherData() async{
        await MainActor.run{
            self.isLoading = true
        }
        do{
            let result = try await networkingManager.getJSON(url: "https://api.openweathermap.org/data/2.5/weather?q=\(userInput)&appid=40e22274d96b307af48ca2883d88a538", type: HomeModel.self)
            if(result.cod == 404){
                await MainActor.run{
                    self.showAlert = true
                }
                throw NetworkingError.invalidInput
            }
            await MainActor.run{
                self.weatherData.temp = "\(result.main?.temp ?? 69)"
                self.weatherData.cityName = result.name ?? "-"
                self.weatherData.country = result.sys?.country ?? "-"
                self.weatherData.image = getImage(of: result.weather?.first?.main ?? "")
                self.weatherData.description = result.weather?.first?.main ?? "Description"
                self.weatherData.minTemp = "\(round(((result.main?.tempMin ?? 259.21)-273.15)*100)/100)"
                self.weatherData.maxTemp = "\(round(((result.main?.tempMax ?? 259.21)-273.15)*100)/100)"
                self.weatherData.pressure = "\(result.main?.pressure ?? 69) hPa"
                self.weatherData.humidity = "\(result.main?.humidity ?? 69)%"
                self.weatherData.windSpeed = "\(result.wind?.speed ?? 6.9)m/sec"
            }
            
            await MainActor.run{
                self.isLoading = false
            }
        }
        catch(let err){
            await handleErrors(error: err as! NetworkingError)
            await MainActor.run {
                self.isLoading = false
                self.showAlert = true
            }
            print("Error: \(err.localizedDescription)")
        }
    }
}




extension HomeViewModel{
    
    private func handleErrors(error:NetworkingError) async{
//        await MainActor.run{
            self.responseError = await Helper.handleErrors(error: error)
//        }
    }
    
    private func getImage(of response:String)->String{
        switch response{
        case "clear sky":
            return "sun.max.fill"
               
        case "few clouds":
            return "cloud.sun.rain"

        case "scattered clouds":
            return "cloud.fill"
                
        case "broken clouds":
            return "cloud.fill"

        case "shower rain":
            return "cloud.rain.rain"

        case "rain":
            return "cloud.heavyrain.fill"

        case "thunderstorm":
            return "cloud.bolt.rain.fill"

        case "snow":
            return "cloud.snow.fill"

        case "mist":
            return "cloud.fog.fill"

        case "Drizzle":
            return "cloud.drizzle.fill"

        case "Rain":
            return "cloud.bolt.rain.fill"

        case "Smoke":
            return "smoke.fill"

        case "Haze":
            return "cloud.fog.fill"

        case "Dust":
            return "sun.dust.fill"

        case "Fog":
            return "cloud.fog.fill"

        case "Ash":
            return "sun.dust"

        case "Sand":
            return "sun.dust.fill"

        case "Squall":
            return "wind"
                
        case "Tornado":
            return "tornado"

        case "Clear":
            return "sun.min.fill"

        case "Clouds":
            return "cloud.fill"

        default:
            return "sun.max.fill"

        }
    }
}
