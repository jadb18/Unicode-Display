#  Unicode Display

This project accepts entry of a Unicode code point and displays the relavent character, while displaying the UTF encodings and byte size. I made this for personal learning about encoding logic so the code is extremely clunky and not well tested. I tried to implement basic input validation, but some things remain beyond the scope of this project. Therefore it may crash on inputs I have yet to test for.

## Overview

Intended to work with UTF-8 and UTF-16 encodings. I hope to be able to add ability to input a 
character literal and display the code point and encodings as well.

### Crashes discovered so far
- Activating dictation in the text field causes a crash
