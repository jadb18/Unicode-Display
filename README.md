#  Unicode Display

This program accepts entry of a Unicode code point and displays the corresponding character, while displaying the UTF-8 and UTF-16 encodings and byte size. I made this for personal learning about encoding logic so the code is rather clunky and not well tested. I tried to implement basic input validation, but some additions remain beyond the scope of this project.

## Overview

Intended to work with UTF-8 and UTF-16 encodings, and I would like to implement composite characters (emoji variations, flags, diacritics, etc.) Anything in the Unicode Character Database (UCD) can be represented, at is still possible to view the encodings for characters in other languages even if a necessary font is not installed to display the characters

### Example usage (relatively current state of the program):

![Example showing the codepoint 1f312 being input one character at a time to generate the hatching chick emoji](/Resources/Example%20Usage.gif)

### Iterative examples

#### The Playing Cards block — Only of these characters is an emoji!

![Example of a speedy interation through the Playing Cards block as the code points and bytes update](/Resources/Playing%20Cards.gif)
  
#### CJK Compatibility Units

![Example of a speedy iteration through the CJK Compatibility block as the code points and bytes update](/Resources/CJK%20Compatibility%20Units.gif)

### Crashes discovered so far
~~Attempting to use dictation in the text field sometimes causes a crash but not recently, unsure why (currently Swift Version 5.9 on macOS 14 beta 5)~~
