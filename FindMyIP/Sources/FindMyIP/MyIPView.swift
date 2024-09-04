//
//  ContentView.swift
//  FindMyIP
//
//  Created by Senthil Kumar R on 04/09/24.
//

import SwiftUI

public struct MyIPView: View {
    @ObservedObject var viewModel = ViewModel(service: NetworkService())
    
    public init() {}
    
    public var body: some View {
        ZStack{
            if viewModel.isLoad {
                ProgressView("Loading wait!")
            } else {
                if viewModel.isError.isEmpty {
                    VStack(alignment:.leading,spacing: 20) {
                        Text("IP: \(viewModel.ipModel?.ip ?? "")")
                            .foregroundColor(.black)
                            .font(.title)
                            .multilineTextAlignment(.leading)
                        Text("Network: \(viewModel.ipModel?.network ?? "")")
                            .foregroundColor(.gray)
                            .font(.headline)
                            .multilineTextAlignment(.leading)
                        Text("City: \(viewModel.ipModel?.city ?? "")")
                            .foregroundColor(.gray)
                            .font(.headline)
                            .multilineTextAlignment(.leading)
                        Text("Country: \(viewModel.ipModel?.country ?? "")")
                            .foregroundColor(.gray)
                            .font(.headline)
                            .multilineTextAlignment(.leading)
                        Text("Latitude: \(viewModel.ipModel?.latitude ?? 0.0)")
                            .foregroundColor(.blue)
                            .font(.headline)
                            .multilineTextAlignment(.leading)
                        Text("Longitude: \(viewModel.ipModel?.longitude ?? 0.0)")
                            .foregroundColor(.blue)
                            .font(.headline)
                            .multilineTextAlignment(.leading)
                    }
                } else {
                    Text("API error: \(viewModel.isError)")
                }
            }
        }.task {
            viewModel.getMYIPDetailsAF()
        }
        .padding()
    }
}

