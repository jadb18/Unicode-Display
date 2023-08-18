//
//  calculate.c
//  Unicode Display
//
//  Created by Jad Beydoun on 8/7/23.
//

#include "calculate.h"

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
