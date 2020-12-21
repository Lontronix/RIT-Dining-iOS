//
//  Location.swift
//  RIT-Dining
//
//  Created by Lonnie Gerol on 12/21/20.
//

import Foundation

struct LocationResponse: Codable {
    var locations: [Location]
}

struct Location: Codable, Identifiable {
    var name: String
    var hours: [String]
    var id = UUID()

    enum CodingKeys: String, CodingKey {
        case name
        case hours
    }

}
