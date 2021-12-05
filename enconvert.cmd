@echo off
setlocal EnableDelayedExpansion

:: Обрабатываем команду /?
if '%1'=='/?' (
	echo Converts the encoding of all files of the form *.txt from CP866 to UTF-8 in the specified directory
	echo encovert.cmd DIRECTORY_NAME
	exit /b
)

:: Сообщение, как получить справку
if '%1'=='' (
	echo Enter /? for help
	exit /b
)

:: Проверяем существование переданной директории
if not exist %1 (
	echo The specified folder doesn't exist
	exit /b
)
:: Меняем кодировку  файлов вида *.txt в указанной директории
for /r %1 %%f in (*.txt) do (
	:resetRand
	set rand=!RANDOM!
	if exist "%%f-!rand!.txt" (
		goto resetRand
	) else (
		GnuWin32\bin\iconv.exe -c -f cp866 -t utf-8 "%%f" > "%%f-!rand!.txt"
		del "%%f"
		rename "%%f-!rand!.txt" "*."
		rename "%%f-!rand!" "*.txt"
	)
)
echo File encoding successfully converted from CP866 to UTF-8
exit /b