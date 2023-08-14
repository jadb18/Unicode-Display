//
//  ContentView.swift
//  Unicode Display
//
//  Created by Jad Beydoun on 8/7/23.
//

import SwiftUI

struct ContentView: View {
    @State private var codePoint: String = ""
    @State private var displayChar = Character("\u{200B}")
    @State private var utf8: UInt32 = 0
    @State private var numBytes = 0
    private let converter = Converter()
    
    init() {}
    
    var body: some View {
        VStack {
            Text(String(displayChar))
                .font(.system(size: 144))
            VStack {
                LabeledContent {
                    let maxLength = 6
                    TextField("Code Point", text: $codePoint)
                        .limitTextLength($codePoint, to: maxLength)
                        .frame(minWidth: 100, maxWidth: 100)
                        .onChange(of: codePoint) {
                            displayChar = Character("\u{200B}")
                            utf8 = 0
                            numBytes = 0
                            converter.setCodePoint(codePoint)
                            displayChar = converter.getChar()
                            utf8 = converter.get_utf8()
                            numBytes = converter.getBytesUsed()
                        }
                } label: {
                    Text("U+")
                }
                Text("UTF-8: " + String(utf8, radix: 16) + " " + String(displayChar))
                Text("UTF-16: ")
                Text("Bytes: " + String(numBytes))
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
