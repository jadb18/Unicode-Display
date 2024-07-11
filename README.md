#  Unicode Display

This program accepts entry of a Unicode code point and displays the corresponding character, while displaying the UTF-8 and UTF-16 encodings and byte size. I made this for personal learning about encoding logic so the code is a bit clunky and not fully tested. I implemented basic input validation, but some additions remain beyond the scope of this project.

## Overview

 Anything in the Unicode Character Database (UCD) can be represented, as is still possible to view the encodings for characters in other languages even if a necessary font is not installed to display the characters. As an example, the Traditional Chinese glyph for *biáng*, shown below, exists as of Unicode version 15.1, but not yet in many system fonts, so the glyph would appear as a blank or "�". I used a custom font to display it in the application.

![Chinese character for biáng with codepoint 30edd with UTF eight and sixteen encodings and byte size](/Resources/U+30EDD%20Example.png)

### Example usage (relatively current state of the program):
U+1 and U+1F are control characters representing headings and delimeters, so they have no visual representation besides caret notation.
![Example showing the codepoint 1f312 being input one character at a time to generate the hatching chick emoji](/Resources/Example%20Usage.gif)

### Iterative examples

#### CJK Compatibility Units

![Example of a speedy iteration through the CJK Compatibility block as the code points and bytes update](/Resources/CJK%20Compatibility%20Units.gif)

#### The Playing Cards block

![Example of a quick interation through the Playing Cards block as the code points and bytes update](/Resources/Playing%20Cards.gif)

### Crashes discovered so far
~~Attempting to use dictation in the text field sometimes causes a crash but not recently, unsure why (currently Swift Version 5.9 on macOS 14 beta 5)~~

Intended to work with UTF-8 and UTF-16 encodings, and I would like to implement composite characters (emoji variations, flags, diacritics, etc.)
