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
    private var bytesUsed = 0
    private var utf8: UInt32 = 0
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
//        let hexCharacters = CharacterSet(charactersIn: "0123456789ABCDEF")
//        let allHex: Bool = codePoint.uppercased().rangeOfCharacter(from: hexCharacters) != nil
        let controlCharEnd: UInt32 = 0x20
        let lastCodePoint: UInt32 = 0x10FFFF
        let pointRange: ClosedRange<UInt32> = controlCharEnd...lastCodePoint
        
        // Check that the codePoint string can become a hex number/only contains hex characters
        if let codeHex = UInt32(codePoint, radix: 16) {
            // Check that the hex number is in a valid point range of displayable Unicode characters
            if pointRange.contains(codeHex) {
                self.codePoint = codeHex
                set_utf8()
                setChar()
                setCodePlane()
            }
        }
    }
    
    func set_utf8() -> Void {
        let fourBytes: ClosedRange<UInt32> = 0x10000...0x10FFFF
        let threeBytes: ClosedRange<UInt32> = 0x0800...0xFFFF
        let twoBytes: ClosedRange<UInt32> = 0x0080...0x07FF
        let oneByte: ClosedRange<UInt32> = 0x0000...0x007F
        let continuationByte: UInt8 = 0b1000_0000
        
        utf8 = 0
        
        if fourBytes.contains(codePoint) {
            bytesUsed = 4
            let byte1 = (0b111_10000 + UInt8(codePoint >> 18))
            let byte2 = (continuationByte + UInt8((codePoint & 0x3FFF) >> 12))
            let byte3 = (continuationByte + UInt8((codePoint & 0x3FF) >> 6))
            let byte4 = (continuationByte + UInt8(codePoint & 0x3F))
            // TODO: clean implementation?
            
            utf8 = UInt32(byte1) << 24 + UInt32(byte2) << 16 + UInt32(byte3) << 8 + UInt32(byte4)
            
        } else if threeBytes.contains(codePoint)  {
            bytesUsed = 3
        } else if twoBytes.contains(codePoint) {
            bytesUsed = 2
            let bytes = split16BitNum(UInt16(codePoint))
            let byte1 = (bytes.0 << 3) + (bytes.1 >> 6)
            let byte2 = bytes.1 & 0x3F
            utf8 += UInt32(0b1100_0000 + byte1) << UInt8.bitWidth
            utf8 += UInt32(continuationByte + byte2)
        } else if oneByte.contains(codePoint) {
            bytesUsed = 1
            utf8 = UInt32(0b1000_0000 + UInt8(codePoint))
        } else {
            print("Invalid code point: \(codePoint)")
        }
    }
    
    func get_utf8() -> UInt32 {
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
