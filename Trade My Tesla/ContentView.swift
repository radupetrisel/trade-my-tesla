//
//  ContentView.swift
//  Trade My Tesla
//
//  Created by Radu Petrisel on 01.09.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                
                Spacer()
                
                Text("This app is not endorsed by Tesla, and any price is entirely fictional.")
                
                NavigationLink {
                    Text("Next view")
                } label: {
                    Text("PROCEED")
                        .font(.system(size: 30))
                }
            }
            .padding()
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.teslaRed)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
