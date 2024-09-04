//
//  NetworkService.swift
//  FindMyIP
//
//  Created by Senthil Kumar R on 04/09/24.
//

import Foundation
import Combine

protocol NetworkProtocol{
    func fetchMYIP(url: URL) -> AnyPublisher<Data, URLError>
}

public class NetworkService: NetworkProtocol {
    let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchMYIP(url: URL) -> AnyPublisher<Data, URLError> {
        return self.session.dataTaskPublisher(for: url)
            .map(\.data)
            .eraseToAnyPublisher()
    }
}
