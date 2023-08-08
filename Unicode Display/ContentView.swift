//
//  ContentView.swift
//  Unicode Display
//
//  Created by Jad Beydoun on 8/7/23.
//

import SwiftUI

struct ContentView: View {
    @State private var codePoint: String
    @State private var displayChar: Character.UnicodeScalarLiteralType?
    private let converter = Converter()
    
    
    init() {
        self.codePoint = ""
//        self.displayChar = "\u{000a}"
    }
    
    var body: some View {
        VStack {
//            CharacterView(displayChar)
            Text(String(displayChar ?? " "))
                .font(.system(size: 144))
            LabeledContent {
            TextField("Code Point", text: $codePoint)
            .frame(minWidth: 100, maxWidth: 100)
            .onChange(of: codePoint) {
//                Converter("utf-8", codePoint)
//                displayChar =
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
