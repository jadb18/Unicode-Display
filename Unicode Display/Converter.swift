//
//  Converter.swift
//  Unicode Display
//
//  Created by Jad Beydoun on 8/7/23.
//

import Foundation

struct utf8 {
    
}

class Converter {
    private let hexCharacters = CharacterSet(charactersIn: "0123456789ABCDEF")
    private let fourBytes: ClosedRange<UInt32> = 0x10000...0x10FFFF
    private let threeBytes: ClosedRange<UInt32> = 0x0800...0xFFFF
    private let twoBytes: ClosedRange<UInt32> = 0x0080...0x07FF
    private let oneByte: ClosedRange<UInt32> = 0x0000...0x007F
    
    private var byte1: UInt8 = 0b1111_0000
    private var byte2: UInt8 = 0b1000_0000
    private var byte3: UInt8 = 0b1000_0000
    private var byte4: UInt8 = 0b1000_0000
    var bytesUsed = 0
    
    private var utf8 = 0
    private var utf16: UInt32 = 0
    private var codePoint: UInt32 = 0
    private var codePlane: Int = 0
    private var encodedChar: Unicode.Scalar?
//    let utf8codec: Unicode.UTF8
    
    init() {}
    
    init(_ encoding: String, _ codePoint: String) {
        self.codePoint = UInt32(codePoint)!
    }
    
    /// Sets the converter's `codePoint` to the input , checks for valid hex code and length
    /// - Parameter codePoint: An input codepoint intended to be received from user input
    /// - Returns: no return value
    func setCodePoint(_ codePoint: String) -> Void {
        let controlCharEnd: UInt32 = 0x0
        let lastCodePoint: UInt32 = 0x10FFFF
        let pointRange: ClosedRange<UInt32> = controlCharEnd...lastCodePoint
        let validLength = 2...6 ~= codePoint.count // FIXME: Check for max 0x10FFFF
        let allHex: Bool = codePoint.uppercased().rangeOfCharacter(from: hexCharacters) != nil
        
        guard (allHex && validLength) else {
            return
        }
        
        // Sanity check that the codePoint string can indeed become a hex number
        if let codeHex = UInt32(codePoint, radix: 16) {
            // Ensure that the hex number is in a valid point range of Unicode characters
            if pointRange.contains(codeHex) {
                self.codePoint = codeHex
                set_utf8()
                setChar()
                setCodePlane()
            }
        }
        
        
        // TODO: replace temp code of setting char with utf conversions
        
    }
    
    func set_utf8() -> Void {
        utf8 = 0
        
        if fourBytes.contains(codePoint) {
            bytesUsed = 4
//            let utf8 = UInt32(codePoint)
            
        } else if threeBytes.contains(codePoint)  {
            bytesUsed = 3
        } else if twoBytes.contains(codePoint) {
            bytesUsed = 2
            let bytes = split16BitNum(UInt16(codePoint))
            let block1Bits = (bytes.0 << 3) + (bytes.1 >> 6)
            let block2Bits = bytes.1 ^ 0x3F
//            byte1 = 0b1100_0000 + bytes.0 >> (UInt8.bitWidth - block1Bits)
            byte1 += block1Bits
            byte2 += block2Bits
            utf8 += Int(byte1)
            utf8 <<= UInt8.bitWidth
            utf8 += Int(byte2)
        } else if oneByte.contains(codePoint) {
            bytesUsed = 1
            byte1 = 0b1000_0000 + UInt8(codePoint)
            utf8 += Int(byte1)
        } else {
            print("Invalid code point: \(codePoint)")
        }
    }
    
    func get_utf8() -> Int {
        return utf8
    }
    
    func set_utf16(_ codePoint: String) -> Void {
        // TODO: convert from utf8 to utf16
        return
    }
    
    func getChar() -> Unicode.Scalar? {
        return encodedChar
    }
    
    func getBytesUsed() -> Int {
        return bytesUsed
    }
    
    /// Sets the member `encodedChar` to a Unicide.Scalar, (presumably) simulating valid UTF encoding
    /// - Returns: no return value
    private func setChar() -> Void {
        encodedChar = Unicode.Scalar(codePoint)
        return
    }
    
    /// Calculates the code plane from the member code point, not currently used but for inspection purposes
    /// - Returns: no return value
    private func setCodePlane() -> Void {
        let planeBits = codePoint >> 16
        codePlane = Int(planeBits)
        
        return
    }
}
