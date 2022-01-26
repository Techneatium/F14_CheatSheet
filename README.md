***
### Changelog - 2022.01.25

- Renamed format file to `checklistformat_f14`
- Moved `tabwidth` and `tabdepth` to top of format
- Removed outdated troubleshooting reference
- Global definitions with `enumitem`
  - Defined `label=(\alph*)` for enumerate
  - Defined `label=\textbf{\textbullet}` for itemize
- Updated `4x3print` option to increase `tabdepth` to 9.5mm
  - As well as increasing `outermar` by 1.5mm
  - Need to figure out what all is necessary here to keep same page area as a5
- Added formatting for using `Spartan` font (closer to Futura-DemiBold)
  - `Spartan` slightly taller -> Requires `Scale=0.85` to keep sizing
  - Requires `tocloft` package to fix table of contents spacing
    - Increased `sftsubsecnumwidth` from `1.55em` to `3.10em`
- Consolidated black color variable into `color1`
  - still needs control of titlepage `tikz`
  - Need variable for textcolor?
  - Move Color variables to top of formating?
- **Considering moving to having `\chapter` in place of `\section`**
  - Maybe have first page of chapter be blank
  - Maybe individual table of content for chapter
  - Would require moving from `article` to `report` or `book`

***
### Changelog - 2022.01.16

- Previous Changes
  - Jost SemiBold -> Bold
  - Added LetterSpacing 2.5
- Added option for 4x3 sizing
  - A5 paper is 210x148
  - I added 210x(148+8) for tabs
  - 4x3 would be 210x157.5 so I added 1.5 to Width
  - Inmar was inceased from 16 to 17.5

***
### Changelog - 2021.12.12

- Changed font
  - gill sans -> Jost
  - bold -> SemiBold
