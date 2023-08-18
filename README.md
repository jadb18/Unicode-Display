#  Unicode Display

This project accepts entry of a Unicode code point and displays the relavent character, while displaying the UTF encodings and byte size. I made this for personal learning about encoding logic so the code is extremely clunky and not well tested. I tried to implement basic input validation, but some things remain beyond the scope of this project. Therefore it may crash on inputs I have yet to test for.

## Overview

Intended to work with UTF-8 and UTF-16 encodings. I hope to be able to add ability to input a 
character literal and display the code point and encodings as well.

Example usage (relatively current state of the program):

![Program screenshot displaying the Chinese character *biang* followed by four text fields, input of U+30EDD, UTF-8: f0808b9d, UTF-16: blank, and Bytes: 4](/Resources/U+30EDD%20Sample.png)

### Crashes discovered so far
- Attempting to use dictation in the text field sometimes causes a crash but not recently, unsure why.
