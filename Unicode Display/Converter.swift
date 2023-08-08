//
//  Converter.swift
//  Unicode Display
//
//  Created by Jad Beydoun on 8/7/23.
//

import Foundation

class Converter {
    private var codePoint: UInt32?
    private var numBytes: Int
    private var codePlane: Int
    private let hexCharacters = CharacterSet(charactersIn: "0123456789ABCDEF")
    private let fourBytes = 0x10000...0x10FFFF
    private let threeBytes = 0x0800...0xFFFF
    private let twoBytes = 0x0080...0x07FF
    private let oneByte = 0x0000...0x007F
    
    init() {
        codePoint = 0; numBytes = 0; codePlane = 0
    }
    
    init(_ encoding: String, _ codePoint: String) {
//        if encoding == "utf-8" {
//            
//        }
        self.codePoint = UInt32(codePoint)!
        numBytes = 0; codePlane = 0 // TODO: replace filler
    }
    
    func set_utf8(_ codePoint: String) -> Void {
        let validRange = 1...6 ~= codePoint.count
        let allHex: Bool = codePoint.uppercased().rangeOfCharacter(from: hexCharacters) != nil
    
        guard (allHex && validRange) else {
            return
        }
        
        self.codePoint = UInt32(codePoint, radix: 16)
    }
    
    func set_utf16(_ codePoint: String) -> Void {
        // TODO: convert from utf8 to utf16
        return
    }
    
    func genChar() {
        
    }
    
    private func calculateCodePlane(_ codePoint: UInt32) -> Void {
        let planeBits = codePoint >> 16
        codePlane = Int(planeBits == 0 ? planeBits : 0x00)
    }
    
    
    
}
