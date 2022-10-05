//
//  MoreDetailView.swift
//  WeatherApp
//
//  Created by Harsh Yadav on 06/10/22.
//

import SwiftUI

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

//struct MoreDetailView_Previews: PreviewProvider {
//    static var previews: some View {
////        MoreDetailView()
//    }
//}
