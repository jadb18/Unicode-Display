//
//  ContentView.swift
//  Unicode Display
//
//  Created by Jad Beydoun on 8/7/23.
//

import SwiftUI

struct ContentView: View {
    @State private var codePoint: String
    @State private var displayChar: Character
    private let converter = Converter()
    
    
    init() {
        self.codePoint = ""
        self.displayChar = " "
    }
    
    var body: some View {
        VStack {
            Text(String(displayChar))
                .font(.system(size: 144))
            LabeledContent {
            TextField("Code Point", text: $codePoint)
            .frame(minWidth: 100, maxWidth: 100)
            .onChange(of: codePoint) {
                converter.setCodePoint(codePoint)
                displayChar = Character(converter.getChar())
//                Converter("utf-8", codePoint)
            }
            } label: {
                Text("U+")
            }
            
        }
        .frame(minWidth: 500, maxWidth: 1280, minHeight: 500, maxHeight: 720)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
