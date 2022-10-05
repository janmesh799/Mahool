//
//  HomeView.swift
//  WeatherApp
//
//  Created by Harsh Yadav on 15/01/22.
//

import SwiftUI
import UIKit
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
enum image{
    case clearSky
    case fewClouds
    case scatteredClouds
    case brokenClouds
    case showerRain
    case rain
    case thunderstorm
    case snow
    case mist
}

struct HomeView: View {
//    let state:ViewState = .sucess
    @StateObject var VM = HomeViewModel()
//    @Environment(\.colorScheme) var colorScheme
    @State var isprre:Bool = false
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            switch VM.state {
                
            case .sucess:
                VStack{
//                    MARK: Header
                    HStack{
                        Image(systemName:"info.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25, alignment: .center)
                            .padding(.leading)
                            .onTapGesture {
                                isprre.toggle()
                            }.sheet(isPresented: $isprre) {
                                print("Dismissed to sheet")
                            } content: {
                                Text("Hello")
                            }

                        Spacer()
                        
                        Text("माहोल")
                            .fontWeight(.bold)
                            .font(.custom("d", fixedSize: 45))
                        
                        Spacer()
                        
                        Image(systemName: "sun.max.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25, alignment: .center)
                            .padding(.trailing)
                            .onTapGesture {
//                                self.toggleColorScheme()
                            }
                    }.padding(.top,20)
                    
                    TextField("Search City", text: $VM.userInput) { edit in
                        if edit{
                            print("editing")
                        }
                        else{
                            print("not editing")
                        }
                    } onCommit: {
                        if VM.userInput.count > 3{
                            VM.getWeatherData()
                            VM.state = .loading
                            VM.userInput = ""
                        }
                        
                    }
                    .padding()
                    .background(Color.gray.opacity(0.3).cornerRadius(10))
                    .padding(.horizontal)
                    .disableAutocorrection(true)
                    .textCase(.uppercase)
//                    .textInputAutocapitalization(.characters)
             
//                    MARK: Temperature
                    Text("\(VM.temps)℃")
                        .font(.custom("dfg", fixedSize: 50))
                        .fontWeight(.semibold)
//                   MARK: Weather Description
                    Text("\(VM.data?.weather?.first!.weatherDescription ?? "XYX")")
                        .font(.title)
//                    MARK: Weather Image
                    Image(systemName: VM.img)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 170, height: 170, alignment: .center)
                        .padding()
                    
                    Spacer()
//                    MARK: Location
                    HStack {
                        Image(systemName: "location.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20, alignment: .center)
                            .foregroundColor(.blue)
                        
                        Text("\(VM.cityName), \(VM.country)")
                            .font(.title)
                    }
                    
                    Spacer()
                    

                    VStack(alignment:.leading){
                        MoreDetailView(entryName: "Max Temperature", data: "\(round(((VM.data?.main?.tempMax ?? 259.21)-273.15)*100)/100)")
                        MoreDetailView(entryName: "Min Temperature", data: "\(round(((VM.data?.main?.tempMin ?? 259.21)-273.15)*100)/100)")
                        MoreDetailView(entryName: "Pressure", data: "\(VM.data?.main?.pressure ?? 69) hPa")
                        MoreDetailView(entryName: "Humidity", data: "\(VM.data?.main?.humidity ?? 69)%")
//                        MoreDetailView(entryName: "Sea Level", data: "\(VM.data?.main. ?? 6.9)")
//                        MoreDetailView(entryName: "Ground Level", data: "39")
                        MoreDetailView(entryName: "Wind Speed", data: "\(VM.data?.wind?.speed ?? 6.9)m/sec")
                    }
                    .padding(.vertical,30)
                    .background(Color.pink.opacity(0.1).cornerRadius(10))
                    .padding(.horizontal,10)
                    .padding(.vertical,10)
                }
                
            case .failure:
                ErrorView(vm: VM)
            case .loading:
                HomeLoadingView()
            case .notFound:
                Text("Not find city")
            }
        }
        .onTapGesture {
            self.hideKeyboard()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.light)
            
    }
}

struct MoreDetailView:View{
    let entryName:String
    let data:String
    var body: some View{
        VStack {
            HStack{
                Text("\(entryName):")
                    
                Spacer()
                
                Text(data)
            }
            .font(.headline)
        .padding(.horizontal)
            Divider()
        }
    }
}
