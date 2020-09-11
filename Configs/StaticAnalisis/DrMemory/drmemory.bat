@echo off

::
:: File:    drmemory.bat
:: Tool:    Dr.Memory 1.5.0-5, http://code.google.com/p/drmemory
:: Note:    run Dr.Memory for checking bugs
:: LDFLAGS: -m32 -g -ggdb -fno-inline -fno-omit-frame-pointer 
::          -static-libgcc (-static-libstdc++)
::
:: Flags description:
::
:: -suppress %SUPPRESS_FILE% - File containing errors to suppress
:: -callstack_max_frames 100 - How many call stack frames to record
:: -ignore_asserts           - Do not abort on debug-build asserts
:: -check_uninit_non_moves   - Check definedness of all non-move instructions
:: -check_uninit_all         - Check definedness of all instructions    
:: -strict_bitops            - Fully check definedness of bit operations
:: -warn_null_ptr            - Warn if NULL passed to free/realloc
:: -check_handle_leaks       - Check for handle leak errors
:: -leaks_only               - Check only for leaks and not memory access errors
::
:: Example:
::
:: drmemory.bat gui/wi-free.exe drmemory_suppress_win.txt
::


:: set vars
set DRMEMORY_FILE="%DRMEMORY_DIR%/bin/drmemory.exe"
set TARGET_FILE="%1"
set SUPPRESS_FILE="%2"

:: checks
if %DRMEMORY_DIR%=="" (
    echo Environment variable %%DRMEMORY_DIR%% don't set
    exit 0
)

if not exist %DRMEMORY_FILE% (
    echo File %DRMEMORY_FILE% don't exist
    exit 0
)

if %TARGET_FILE%=="" (
    echo Usage: %DRMEMORY_FILE% [target_file] [suppress_file]
    exit 0
)

if %SUPPRESS_FILE%=="" (
    echo Usage: %DRMEMORY_FILE% [target_file] [suppress_file]
    exit 0
)

:: run Dr.Memory
%DRMEMORY_FILE% ^
    -suppress %SUPPRESS_FILE% ^
    -callstack_max_frames 100 ^
    -ignore_asserts ^
    -check_uninit_non_moves ^
    -check_uninit_all ^
    -strict_bitops ^
    -check_handle_leaks ^
    -batch ^
    -leaks_only ^
    ^
    -- %TARGET_FILE%

exit 1
