//
//  Converter.swift
//  Unicode Display
//
//  Created by Jad Beydoun on 8/7/23.
//

import Foundation

class Converter {
    private let hexCharacters = CharacterSet(charactersIn: "0123456789ABCDEF")
    private let fourBytes: ClosedRange<UInt32> = 0x10000...0x10FFFF
    private let threeBytes: ClosedRange<UInt32> = 0x0800...0xFFFF
    private let twoBytes: ClosedRange<UInt32> = 0x0080...0x07FF
    private let oneByte: ClosedRange<UInt32> = 0x0000...0x007F
    
    private var utf8: UInt32 = 0
    private var utf16: UInt32 = 0
    private var codePoint: UInt32?
    private var numBytes: Int
    private var codePlane: Int
    private var encodedChar: Unicode.Scalar?
    
    init() {
        codePoint = 0; numBytes = 0; codePlane = 0
    }
    
    init(_ encoding: String, _ codePoint: String) {
        self.codePoint = UInt32(codePoint)!
        numBytes = 0; codePlane = 0 // TODO: replace filler
    }
    
    /// Sets the converter's `codePoint` to the input , checks for valid hex code and length
    /// - Parameter codePoint: An input codepoint intended to be received from user input
    /// - Returns: no return value
    func setCodePoint(_ codePoint: String) -> Void {
        let validRange = 1...5 ~= codePoint.count // FIXME: Check for max 0x10FFFF
        let allHex: Bool = codePoint.uppercased().rangeOfCharacter(from: hexCharacters) != nil
        
        guard (allHex && validRange) else {
            return
        }
        
        self.codePoint = UInt32(codePoint, radix: 16)
        setChar()
        setCodePlane()
        // TODO: replace temp code of setting char with utf conversions
        
    }
    
    func set_utf8() -> Void {
        var byte1: UInt8
        var byte2: UInt8
        var byte3: UInt8
        var byte4: UInt8
        
        let codePoint = self.codePoint!
        
        if fourBytes.contains(codePoint) {
            let utf8 = UInt32(codePoint)
            byte1 = 0b1111_0000
            byte2 = 0b1000_0000
            byte3 = 0b1000_0000
            byte4 = 0b1000_0000
        } else if threeBytes.contains(codePoint)  {
//            let codePoint = 
            byte1 = 0b1110_0000
            byte2 = 0b1000_0000
            byte3 = 0b1000_0000
        } else if twoBytes.contains(codePoint) {
            let bytes = split16BitNum(UInt16(codePoint))
            let block1Bits = (bytes.0 >> 5) << 2 + (bytes.1 >> 6)
            let block2Bits = bytes.1 >> 2
//            byte1 = 0b1100_0000 + bytes.0 >> (UInt8.bitWidth - block1Bits)
            byte1 = 0b1100_0000 + block1Bits
            byte2 = 0b1000_0000 + block2Bits
            
        } else if oneByte.contains(codePoint) {
            let byte = UInt8(codePoint)
            byte1 = 0b1000_0000 + byte
            utf8 = UInt32(byte1)
        } else {
            print("Invalid code point: \(codePoint)")
        }
    }
    
    func get_utf8() -> UInt32 {
        return 0
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
