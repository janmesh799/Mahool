//
//  ErrorView.swift
//  WeatherApp
//
//  Created by Harsh Yadav on 15/01/22.
//

import SwiftUI

struct ErrorView: View {
    @State var citySearch:String = ""
    @State var vm:HomeViewModel
    var body: some View {
        VStack{
            TextField("Search City", text: $citySearch) { edit in
                if edit{
                    print("editing")
                }
                else{
                    print("not editing")
                }
            } onCommit: {
                print("searching")
            }
            .padding()
            .background(Color.gray.opacity(0.3).cornerRadius(10))
            .padding(.horizontal)
            .disableAutocorrection(true)
            .textCase(.uppercase)
//            .textInputAutocapitalization(.characters)
            .disabled(true)
            Spacer()
            Image(systemName: "exclamationmark.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200, alignment: .center)
                .padding()
                .foregroundColor(Color.red)
            
            Text("Error")
                .font(.headline)
                
            Button {
                vm.state = .sucess
            } label: {
                Text("Retry")
                    .font(.title2)
                    .padding()
                    .foregroundColor(.white)
                    .frame(width: 150, height: 60, alignment: .center)
                    .background(Color.blue.cornerRadius(10))
            }

            Spacer()
            
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(vm: HomeViewModel())
            .preferredColorScheme(.dark)
    }
}
