@echo off
:: Проверяем число аргументов
set argNumber=0
for %%x in (%*) do set /a argNumber+=1
if %argNumber% GTR 1 (
	echo The number of arguments must not be more than 1
	exit /b
)

:: Сообщение, как получить справку
if %argNumber%==0 (
	echo Enter /? for help
	exit /b
)

:: Обрабатываем команду /?
if %argNumber%==1 if %1=="/?" (
	echo Help
	exit /b
)

:: Проверяем существование переданной директории
if not exist %1 (
	echo The specified folder doesn't exist
	exit /b
)

:: Меняем кодировку  файлов вида *.txt в указанной директории
for /r %1 %%f in (*.txt) do (
	if exist "%%f-utf8.txt" (
		echo The temporary file needed to create %%f already exists. Rename it to a different name
		exit /b
	) else (
		GnuWin32\bin\iconv.exe -c -f cp866 -t utf-8 "%%f" > "%%f-utf8.txt"
		del "%%f"
		rename "%%f-utf8.txt" "*."
		rename "%%f-utf8" "*.txt"
	)
)
echo File encoding successfully translated from CP866 to UTF-8
exit /b