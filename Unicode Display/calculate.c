//
//  calculate.c
//  Unicode Display
//
//  Created by Jad Beydoun on 8/7/23.
//

#include "calculate.h"

/// Checks whether or not the code point is in within the basic multilingual plane and shifts the bits if not. Only two bytes would
/// be needed in theory in in the BMP, so the actual value of utf16 would not really need the full 32 bits to represent itself.
/// - Parameter codePoint: A 32-bit value representing a unicode code point
uint32_t cset_utf16(uint32_t codePoint) {
    uint32_t utf16 = 0;
    uint32_t non_basic_start = 0x10000;
    uint32_t non_basic_end = 0x10FFFF;
    uint16_t basic_plane = 0xFFFF;
    
    if (codePoint <= basic_plane) {
        utf16 = codePoint;
    } else if (codePoint >= non_basic_start && codePoint <= non_basic_end) {
        uint16_t low_surrogate = 0xDC00;
        uint16_t high_surrogate = 0xD800;
        
        codePoint -= 0x10000;
        low_surrogate += codePoint & 0x3FF;
        high_surrogate += codePoint >> 10;
        utf16 += high_surrogate;
        utf16 <<= 16;
        utf16 += low_surrogate;
    } else {
        printf("Invalid code point %d", codePoint);
    }
    
    return utf16;
}

/// Checks which byte range the code point would fall in and constructs each byte according to the UTF-8 encoding process.
/// - Parameter codePoint: A 32-bit value representing a unicode code point
uint32_t cset_utf8(uint32_t codePoint) {
    int oneByte = 0x007F;
    int twoBytes = 0x07FF;
    int threeBytes = 0xFFFF;
    int fourBytes = 0x10FFFF;
    int byte1 = 0;
    int byte2 = 0;
    int byte3 = 0;
    int byte4 = 0;
    uint32_t utf8 = 0;
    uint8_t continuationByte = 0b10000000;
    
    if (codePoint <= fourBytes) {
        if (codePoint <= threeBytes) {
            if (codePoint <= twoBytes) {
                if (codePoint <= oneByte) {
                    byte1 = (uint8_t) codePoint;
                }
                byte1 = 0b11100000 + ((uint8_t) (codePoint >> 6));
                byte2 = continuationByte + ((uint8_t) (codePoint & 0x3F));
            }
            byte1 = 0b11100000 + ((uint8_t) (codePoint >> 12));
            byte2 = continuationByte + (((uint8_t) (codePoint & 0xFFF)) >> 6);
            byte3 = continuationByte + ((uint8_t) (codePoint & 0x3F));
        }
        byte1 = 0b11110000 + ((uint8_t) codePoint >> 18);
        byte2 = continuationByte + (((uint8_t) (codePoint & 0x3FFFF)) >> 12);
        byte3 = continuationByte + (((uint8_t) (codePoint & 0xFFF)) >> 6);
        byte4 = continuationByte + ((uint8_t) (codePoint & 0x3F));
    } else {
        printf("Invalid code point %d", codePoint);
    }
    
    utf8 = (byte1 << 24) + (byte2 << 16) + (byte3 << 8) + byte1;
    
    return utf8;
}
