
@echo off
set INPUT_DIR=docs\mermaid_graphs
set OUTPUT_DIR=docs\images

if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"

for %%f in (%INPUT_DIR%\*.mmd) do (
    echo Rendering %%~nxf
    mmdc -i "%%f" -o "%OUTPUT_DIR%\%%~nf.png" -b transparent
)

echo Done.
