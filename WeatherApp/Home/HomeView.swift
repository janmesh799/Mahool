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
    
    @StateObject var viewModel = HomeViewModel()
    @State var cancelSearch:Bool = false
    @State var showAbout:Bool = false
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack{
                if(viewModel.isLoading){
                    HomeLoadingView(cancelSearch: $cancelSearch)
                }
                else{
                    VStack{
                        header
                        
                        searchBar
                        
                        homeBody
                        
                        Spacer()
                        
                        stats
                    }
                    .disabled(viewModel.isLoading)
                }

            }
        }
        .alert(self.viewModel.responseError, isPresented: $viewModel.showAlert, actions: {
            Button("Ok") {
                self.viewModel.showAlert = false
                self.viewModel.isLoading = false
            }
        })
        .onTapGesture {
            self.hideKeyboard()
        }
        .onChange(of: self.cancelSearch) { newValue in
            if(newValue){
                self.viewModel.isLoading = false
                self.viewModel.showAlert = false
                self.viewModel.userInput = ""
            }
        }
    }
}


extension HomeView{
    ///Header
    var header:some View{
        HStack{
            Image(systemName:"info.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25, alignment: .center)
                .padding(.leading)
                .onTapGesture {
                    showAbout.toggle()
                }.sheet(isPresented: $showAbout) {
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
    }
    
    var searchBar:some View{
        TextField("Search City", text: $viewModel.userInput) { edit in
            if edit{
                print("editing")
            }
            else{
                print("not editing")
            }
        } onCommit: {
            if viewModel.userInput.count > 3{
                Task{
                    await viewModel.getWeatherData()
                    viewModel.userInput = ""
                }
//                            viewModel.state = .loading
            }
        }
        .padding()
        .background(Color.gray.opacity(0.3).cornerRadius(10))
        .padding(.horizontal)
        .disableAutocorrection(true)
        .textCase(.uppercase)
//                    .textInputAutocapitalization(.characters)
    }
    
    
    /// Temperature, Description, Image & Location
    var homeBody:some View{
        VStack{
            //Temp
            Text("\(viewModel.weatherData.temp)℃")
                .font(.custom("dfg", fixedSize: 50))
                .fontWeight(.semibold)
            
            // Weather Description
            Text("\(viewModel.weatherData.description)")
                .font(.title)
            
            //Weather Image
            Image(systemName: viewModel.weatherData.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 170, height: 170, alignment: .center)
                .padding()
            
            Spacer()
            
            //Location
            HStack {
                Image(systemName: "location.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20, alignment: .center)
                    .foregroundColor(.blue)
                
                //City & Country Name
                Text("\(viewModel.weatherData.cityName), \(viewModel.weatherData.country)")
                    .font(.title)
            }
        }
    }
    ///Stats
    var stats:some View{
        VStack(alignment:.leading){
            MoreDetailView(entryName: "Max Temperature", data: self.viewModel.weatherData.maxTemp)
            MoreDetailView(entryName: "Min Temperature", data: self.viewModel.weatherData.minTemp)
            MoreDetailView(entryName: "Pressure", data: self.viewModel.weatherData.pressure)
            MoreDetailView(entryName: "Humidity", data: self.viewModel.weatherData.humidity)
            MoreDetailView(entryName: "Wind Speed", data: self.viewModel.weatherData.windSpeed)
        }
        .padding(.vertical,30)
        .background(Color.pink.opacity(0.1).cornerRadius(10))
        .padding(.horizontal,10)
        .padding(.vertical,10)
    }
    
    
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.light)
            
    }
}


