//
//  Converter.swift
//  Unicode Display
//
//  Created by Jad Beydoun on 8/7/23.
//

import Foundation

//struct utf8 {
//    
//}

class Converter {
    private var encodedChar = Character("\u{200B}")
    private var codePoint: UInt32 = 0
    private var utf8: UInt32 = 0
    private var utf16: UInt32 = 0
    private var utf8BytesUsed = 0
    private var utf16BytesUsed = 0
    private var codePlane = 0
//    let utf8codec: Unicode.UTF8
    
    init() {}
    
    func reset() {
        encodedChar = Character("\u{200B}")
        (codePoint, utf8, utf16, utf8BytesUsed, utf16BytesUsed) = (0, 0, 0, 0, 0)
    }
    
    /// Sets the converter's `codePoint` to the input, checks for valid hex code and length
    /// - Parameter codePoint: An input codepoint intended to be received from user input
    /// - Returns: no return value
    func setCodePoint(_ codePoint: String) -> Void {
//        let hexCharacters = CharacterSet(charactersIn: "0123456789ABCDEF")
//        let allHex: Bool = codePoint.uppercased().rangeOfCharacter(from: hexCharacters) != nil
        let controlCharEnd: UInt32 = 0x20
        let lastCodePoint: UInt32 = 0x10FFFF
        let pointRange: ClosedRange<UInt32> = controlCharEnd...lastCodePoint
        
        // Check that the codePoint string can become a hex number/only contains hex characters
        if let codeHex = UInt32(codePoint, radix: 16) {
            // Supposedly can set variables without error
            self.codePoint = codeHex
            set_utf8()
            set_utf16()
            set_codePlane()
            // Check that the codePoint is in a valid point range of displayable Unicode characters
            if pointRange.contains(self.codePoint) {
                set_char()
            } else {
                // Control character/invalid so set to zero width space
                encodedChar  = Character("\u{200B}")
            }
        } else {
            // Not valid codePoint/hex input
            reset()
        }
    }
    
    func set_utf8() -> Void {
        let fourBytes: ClosedRange<UInt32> = 0x10000...0x10FFFF
        let threeBytes: ClosedRange<UInt32> = 0x0800...0xFFFF
        let twoBytes: ClosedRange<UInt32> = 0x0080...0x07FF
        let oneByte: ClosedRange<UInt32> = 0x0000...0x007F
        let continuationByte: UInt8 = 0b1000_0000
        var byte1: UInt8 = 0
        var byte2: UInt8 = 0
        var byte3: UInt8 = 0
        var byte4: UInt8 = 0
        
        utf8 = 0
        
        if fourBytes.contains(codePoint) {
            utf8BytesUsed = 4
            byte1 = (0b1111_0000 + UInt8(codePoint >> 18))
            byte2 = (continuationByte + UInt8((codePoint & 0x3FFF) >> 12))
            byte3 = (continuationByte + UInt8((codePoint & 0x3FF) >> 6))
            byte4 = (continuationByte + UInt8(codePoint & 0x3F))
        } else if threeBytes.contains(codePoint)  {
            utf8BytesUsed = 3
            byte1 = (0b1110_0000 + UInt8(codePoint >> 12))
            byte2 = (continuationByte + UInt8((codePoint & 0xFFF) >> 6))
            byte3 = (continuationByte + UInt8(codePoint & 0x3F))
        } else if twoBytes.contains(codePoint) {
            utf8BytesUsed = 2
            byte1 = (continuationByte + UInt8(codePoint >> 6))
            byte2 = (continuationByte + UInt8(codePoint & 0x3F))
        } else if oneByte.contains(codePoint) {
            utf8BytesUsed = 1
            byte1 = UInt8(codePoint)
        } else {
            print("Invalid code point: \(codePoint)")
            return
        }
        
        let byte1Shift = (utf8BytesUsed - 1) * UInt8.bitWidth
        let byte2Shift = utf8BytesUsed >= 2 ? ((utf8BytesUsed - 2) * UInt8.bitWidth) : 0
        let byte3Shift = utf8BytesUsed >= 3 ? ((utf8BytesUsed - 3) * UInt8.bitWidth) : 0
        utf8 = UInt32(byte1) << byte1Shift + UInt32(byte2) << byte2Shift
        utf8 += UInt32(byte3) << byte3Shift + UInt32(byte4)
    }
    
    func get_utf8() -> UInt32 {
        return utf8
    }
    
    func set_utf16() -> Void {
        // Trying C implementation
        utf16 = cset_utf16(codePoint)
        utf16BytesUsed = utf16 <= 0xFFFF ? 2 : 4
        return
    }
    
    func get_utf16() -> UInt32 {
        return utf16
    }
    
    func get_char() -> Character {
        return encodedChar
    }
    
    func get_utf8Bytes() -> Int {
        return utf8BytesUsed
    }
    
    func get_utf16Bytes() -> Int {
        return utf16BytesUsed
    }
    
    /// Sets the member `encodedChar` to a Unicide.Scalar, (presumably) simulating valid UTF encoding
    /// - Returns: no return value
    private func set_char() -> Void {
        if let scalar = Unicode.Scalar(codePoint) {
            encodedChar = Character(scalar)
        } else {
            encodedChar = Character("\u{200B}")
        }
        return
    }
    
    /// Calculates the code plane from the member code point, not currently used but for inspection purposes
    /// - Returns: no return value
    private func set_codePlane() -> Void {
        let planeBits = codePoint >> 16
        codePlane = Int(planeBits)
        
        return
    }
}
