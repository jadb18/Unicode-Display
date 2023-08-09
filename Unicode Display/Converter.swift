//
//  Converter.swift
//  Unicode Display
//
//  Created by Jad Beydoun on 8/7/23.
//

import Foundation

class Converter {
    private let hexCharacters = CharacterSet(charactersIn: "0123456789ABCDEF")
    private let fourBytes = 0x10000...0x10FFFF
    private let threeBytes = 0x0800...0xFFFF
    private let twoBytes = 0x0080...0x07FF
    private let oneByte = 0x0000...0x007F
    private var codePoint: UInt32?
    private var numBytes: Int
    private var codePlane: Int
    private var encodedChar: Unicode.Scalar?
    
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
    
    /// Sets the converter's `codePoint` to the input , checks for valid hex code and length
    /// - Parameter codePoint: An input codepoint intended to be received from user input
    /// - Returns: no return value
    func setCodePoint(_ codePoint: String) -> Void {
        let validRange = 1...6 ~= codePoint.count
        let allHex: Bool = codePoint.uppercased().rangeOfCharacter(from: hexCharacters) != nil
        
        guard (allHex && validRange) else {
            return
        }
        
        self.codePoint = UInt32(codePoint, radix: 16)
        setChar()
        setCodePlane()
        // TODO: replace temp code of setting char with utf conversions
        
    }
    
    func set_utf8(_ codePoint: String) -> Void {
            
    }
    
    func set_utf16(_ codePoint: String) -> Void {
        // TODO: convert from utf8 to utf16
        return
    }
    
    func getChar() -> Unicode.Scalar {
        return encodedChar!
    }
    
    /// Sets the member `encodedChar` to a Unicide.Scalar, (presumably) simulating valid UTF encoding
    /// - Returns: no return value
    private func setChar() -> Void {
        if let codePoint = codePoint {
            encodedChar = Unicode.Scalar(codePoint)
        }
    }
    
    /// Calculates the code plane from the member code point, not currently used but for inspection purposes
    /// - Returns: no return value
    private func setCodePlane() -> Void {
        if let codePoint = codePoint {
            let planeBits = codePoint >> 16
            codePlane = Int(planeBits)
        }
        return
    }
}
