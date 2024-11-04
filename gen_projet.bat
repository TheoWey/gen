
@echo off
:creation_src
if exist src\ (
    if exist main.cc (
        Goto creation_include
    ) else (
        (   
            echo #include"main.h"
            echo.
            echo int main(void^)^{
            echo    printf("hello world"^);
            echo ^}
            echo.
            echo void init(void^)^{
            echo.   
            echo ^}
            echo void loop(void^)^{;
            echo.   
            echo ^}
        )>src\main.cc
        Goto creation_include
    )   
) else (
    mkdir src
    Goto creation_src
)

:creation_include
if exist include\ (
    if exist main.h (
        Goto importmkfile
    ) else (
        (   
            echo #pragma region    //librairie externes
            echo #include "stdio.h"
            echo #include "stdlib.h"
            echo #include ^<cstdint^>
            echo #pragma endregion //librairie externes
            echo.
            echo #ifndef MAIN_H
            echo #define MAIN_H
            echo.
            echo #pragma region    //declaration des variables
            echo.
            echo.
            echo.
            echo #pragma endregion //declaration des variables
            echo.
            echo #pragma region    // declaration des fonctions
            echo.
            echo void init(void^);
            echo void loop(void^);
            echo.
            echo #pragma endregion // declaration des fonctions

            echo #endif
        )>include\main.h
        Goto importmkfile
    )   
) else (
    mkdir include
    Goto creation_include
)

:importmkfile
if exist makefile (
    Goto end
) else (
    copy "C:\Users\weyth\OneDrive\Theo\cours\CESI\a1\info\cpp\generique.mk" "%~dp0makefile"
    Goto end
)

:end

del "gen_projet.bat"
