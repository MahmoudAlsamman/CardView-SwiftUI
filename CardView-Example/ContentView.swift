//
//  ContentView.swift
//  CardView-Example
//
//  Created by Mahmoud Alsamman on 31/05/2021.
//

import SwiftUI

struct ContentView: View {
    
    /// Card presentation state
    @State var isPresented: Bool = false
    
    var body: some View {
        VStack {
            Button(action: { isPresented.toggle() }) {
                Text("Show card")
            }
        }
        .cardView(title: "Selected Photo📸", isPresented: $isPresented) {
            // Add view that you want to embed inside CardView.
            SelectedPhotoView()
        }
    }
}

struct SelectedPhotoView: View {
    
    var body: some View {
        VStack{
        Text("Neon Gallery")
            .multilineTextAlignment(.center)
            .font(.title3)
        Image("IMG_8995")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: 200)
            .cornerRadius(12)
            .shadow(color: .black, radius: 20)
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
