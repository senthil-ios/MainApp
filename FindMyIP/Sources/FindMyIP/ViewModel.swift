//
//  ViewModel.swift
//  FindMyIP
//
//  Created by Senthil Kumar R on 04/09/24.
//

import Foundation
import Combine
import Alamofire

public class ViewModel: ObservableObject {
    @Published public var isLoad = true
    @Published var isError = ""
    @Published var ipModel: IPModel?
    var networkService: NetworkService
    var cancellable: Set<AnyCancellable> = []
    let url = URL(string: "https://ipapi.co/json/")!
    
    public init(service:NetworkService){
        self.networkService = service
    }
    
    public func getMYIPDetailsAF(){
        AF.request(url,method: .get)
            .validate()
            .publishDecodable(type:IPModel.self)
            .receive(on: DispatchQueue.main)
            .sink { response in
                if let error = response.error {
                    self.isError = error.localizedDescription
                } else{
                    self.ipModel = response.value
                    self.isLoad = false
                }
            }
            .store(in: &cancellable)
    }
    
    public func getMYIPDetails(){
        self.networkService.fetchMYIP(url: url)
            .receive(on: DispatchQueue.main)
            .decode(type: IPModel.self, decoder: JSONDecoder())
            .sink { result in
                switch result {
                case .finished:
                    self.isLoad = false
                case .failure(let error):
                    self.isLoad = false
                    self.isError = error.localizedDescription
                }
            } receiveValue: { response in
                self.ipModel = response
            }
            .store(in: &cancellable)
    }
}
