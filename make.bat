@echo off

rmdir /s /q bin
rmdir /s /q dist

mkdir bin
mkdir dist


SET GBDK_HOME=C:/gbdk

SET LCC_COMPILE_BASE=%GBDK_HOME%\bin\lcc -Iheaders -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG
SET LCC_COMPILE=%LCC_COMPILE_BASE% -c -o 

SETLOCAL ENABLEDELAYEDEXPANSION

:: Default to the hugedriver file
SET "COMPILE_OBJECT_FILES="

:: loop for all files in the default source folder
FOR %%X IN (source/default/*.c) DO (
    %LCC_COMPILE% bin/%%~nX.o source/default/%%X
    SET "COMPILE_OBJECT_FILES=bin/%%~nX.o !COMPILE_OBJECT_FILES!"

    echo Compiling %%X...
)


:: Compile a .gb file from the compiled .o files
%LCC_COMPILE_BASE% -Wm-yC -Wl-yt3 -o dist/FlappyBird.gb !COMPILE_OBJECT_FILES!

endlocal
