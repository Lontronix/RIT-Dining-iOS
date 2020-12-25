//
//  LocationQuery.swift
//  RIT-Dining
//
//  Created by Lonnie Gerol on 12/24/20.
//

import Foundation
import Combine

class LocationQuery: ObservableObject {
    @Published var locations: [Location] = []
    var subscriptions: Set<AnyCancellable> = []

    init() {
        Just(URL(string: "http://rit-dining-api-rit-dining-api.apps.okd4.csh.rit.edu/api/v1/hours")!)
            .flatMap(fetchLocations)
            .receive(on: DispatchQueue.main)
            .assign(to: \.locations, on: self)
            .store(in: &subscriptions)
        //locations.append(Location(name: "Test", hours: [""], id: UUID()))
    }

    func fetchLocations(url: URL) -> AnyPublisher<[Location], Never>{
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: LocationResponse.self, decoder: JSONDecoder())
            .map(\.locations)
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
}
