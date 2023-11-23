//
//  ContentViewContainer.swift
//  Speakly
//
//  Created by Nur Azizah on 22/11/23.
//

import SwiftUI

struct ContentViewContainer: View {
    var body: some View {
        ContentView()
            .navigationDestination(for: Route.self) { route in
                Routes(route: route)
            }
    }
}

#Preview {
    ContentViewContainer()
}
