//
//  ContentView.swift
//  Unicode Display
//
//  Created by Jad Beydoun on 8/7/23.
//

import SwiftUI

struct ContentView: View {
    @State private var codePoint: String = ""
    @ObservedObject private var converter = Converter()
    
    init() {
    }
    
    var body: some View {
        VStack {
            Text(String(converter.encodedChar))
                .font(.system(size: 144))
            VStack {
                LabeledContent {
                    let maxLength = 6
                    TextField("Code Point", text: $codePoint)
                        .limitTextLength($codePoint, to: maxLength)
                        .frame(minWidth: 100, maxWidth: 100)
                        .onChange(of: codePoint) {
                            converter.setCodePoint(codePoint)
                        }
                } label: {
                    Text("U+")
                }
                Text("UTF-8: " + String(converter.utf8, radix: 16))
                Text("UTF-16: " + String(converter.utf16, radix:16))
                Text("UTF-8 Bytes: \(converter.utf8BytesUsed)")
                Text("UTF-16 Bytes: \(converter.utf16BytesUsed)")
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
