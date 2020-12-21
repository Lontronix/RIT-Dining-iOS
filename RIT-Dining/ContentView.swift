//
//  ContentView.swift
//  RIT-Dining
//
//  Created by Lonnie Gerol on 12/21/20.
//

import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject var locationQuery = LocationQuery()

    var body: some View {
        NavigationView {

            List {
                ForEach(locationQuery.locations) { location in
                    Section(header: Text(location.name)) {
                        ForEach(location.hours, id: \.self) { segment in
                            Text(segment)
                        }
                    }
                }
            }.navigationTitle(Text("Locations"))

        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
