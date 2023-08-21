#  Unicode Display

This program accepts entry of a Unicode code point and displays the corresponding character, while displaying the UTF-8 and UTF-16 encodings and byte size. I made this for personal learning about encoding logic so the code is quite clunky and not well tested. I tried to implement basic input validation, but some additions remain beyond the scope of this project unfortunately.

## Overview

Intended to work with UTF-8 and UTF-16 encodings, and I would like to implement composite characters (emoji variations, flags, diacritics, etc.)
It is still possible to view the encodings for characters in other languages even if the font is not installed to display the characters.

Example usage (relatively current state of the program):

![Program screenshot displaying the Chinese character *biang* followed by four text fields, input of U+30EDD, UTF-8: f0808b9d, UTF-16: d883dedd, UTF-8 Bytes: 4, UTF-16 Bytes: 4](/Resources/U+30EDD%20Sample.png)

### Crashes discovered so far
- Attempting to use dictation in the text field sometimes causes a crash but not recently, unsure why (currently Swift Version 5.9 on macOS 14 beta 5)
