//
//  ConverterHelpers.swift
//  Unicode Display
//
//  Created by Jad Beydoun on 8/10/23.
//

import Foundation

func split16BitNum(_ num: UInt16) -> (UInt8, UInt8) {
    let msB = UInt8(num >> 8)
    let lsB = UInt8(num & 0xFF)
    
    return (msB, lsB)
}

func split32BitNum(_ num: UInt32) -> (UInt8, UInt8, UInt8, UInt8) {
    let (msB, middle1) = split16BitNum(UInt16(num >> 16))
    let (middle2, lsB) = split16BitNum(UInt16(num & 0xFFFF))
    
    return (msB, middle1, middle2, lsB)
}
