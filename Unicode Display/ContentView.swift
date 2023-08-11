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
            VStack {
                LabeledContent {
                    let maxLength = 6
                    TextField("Code Point", text: $codePoint)
                        .limitTextLength($codePoint, to: 6)
                        .frame(minWidth: 100, maxWidth: 100)
                        .onChange(of: codePoint) {
                            converter.setCodePoint(codePoint)
                            displayChar = Character(converter.getChar() ?? " ")
                        }
                } label: {
                    Text("U+")
                }
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

struct TextLengthLimiter: ViewModifier {
  @Binding var text: String
  let maxLength: Int

  func body(content: Content) -> some View {
    content
      .onReceive(text.publisher.collect()) { output in
        text = String(output.prefix(maxLength))
      }
  }
}

extension TextField {
  func limitTextLength(_ text: Binding<String>,
                       to maxLength: Int) -> some View {
    self.modifier(TextLengthLimiter(text: text,
                                    maxLength: maxLength))
  }
}
