//
//  HomeLoadingView.swift
//  WeatherApp
//
//  Created by Harsh Yadav on 15/01/22.
//

import SwiftUI

struct HomeLoadingView: View {
    
    @State var citySearch:String = ""
    @Binding var cancelSearch:Bool
    var body: some View {
        VStack{
            HStack{
                Text("Getting Data")
                    .fontWeight(.bold)
            }
            .font(.largeTitle)
            .padding()
            Spacer()
            Image(systemName: "aqi.low")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200, alignment: .center)
                .foregroundColor(.red)
                .padding()
            Spacer()
            ProgressView {
                Text("Loading Please Wait")
            }
            
            
            Button("Cancel Seach") {
                self.cancelSearch = true
            }
//            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
    }
}

struct HomeLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        HomeLoadingView(cancelSearch: .constant(true))
    }
}
