@echo off

REM Variables.
set tesseractexe="C:\PortableApps\tesseract-ocr\tesseract.exe"
set input=%*
set outputdirectory="C:\Users\YOURNAME\Desktop\"

REM ------------ Copyright ------------
REM -----------------------------------
REM Copyright (C) 2012-toyear  aude
REM
REM This program is free software: you can redistribute it and/or modify
REM it under the terms of the GNU General Public License as published by
REM the Free Software Foundation, either version 3 of the License, or
REM (at your option) any later version.
REM
REM This program is distributed in the hope that it will be useful,
REM but WITHOUT ANY WARRANTY; without even the implied warranty of
REM MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
REM GNU General Public License for more details.
REM
REM You should have received a copy of the GNU General Public License
REM along with this program.  If not, see <http://www.gnu.org/licenses/>.

REM Intro.
echo Will OCR input files using Tesseract ...
echo.

REM If not file was input, go to the end of the batch.
if not exist "%~1" (
	echo No file was input.
	echo Will now exit ...
	echo.
	
	REM Flee!
	goto endmessage
)

REM Make working directory the path of the "outputdirectory" variable, if set. Else, keep current.
if defined outputdirectory (
	cd /d %outputdirectory%
)

:setlanguage
REM Ask for which language to expect.
set /p lang=Which language to use [eng,nor,spa]?: 
echo.

REM Check for valid answer.
if "%lang%" equ "q" (
	goto endmessage
)
if "%lang%" neq "eng" (
	if "%lang%" neq "nor" (
		if "%lang%" neq "spa" (
			REM Inform.
			echo Your input "%lang%" is not valid.
			echo Please input a correct language code.
			echo ^(Or enter q to quit.^)
			echo.
			goto setlanguage
		)
	)
)

REM Loop through input files, and convert 'em all.
for %%a in (%input%) do (
	REM Inform.
	echo Will OCR "%%~a" and output to "%cd:"=%\%%~na.txt" ...
	echo.
	
	REM Execute.
	%tesseractexe% "%%~a" %%~na -l %lang%
	echo.
)

:endmessage
echo -------- End of batch --------
echo.
