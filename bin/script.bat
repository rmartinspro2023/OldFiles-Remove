@echo off
setlocal enabledelayedexpansion

REM Defina o diretório que você deseja verificar
set "diretorio=C:\Caminho\Para\O\Seu\Diretorio"

REM Verifica se o diretório existe
if not exist "%diretorio%" (
    echo Diretório não encontrado: %diretorio%
    exit /b
)

REM Navega para o diretório especificado
cd /d "%diretorio%"

REM Conta quantos arquivos existem no diretório
set "contador=0"
for %%F in (*) do (
    if not "%%~aF"=="d" (
        set /a "contador+=1"
    )
)

REM Verifica se há apenas um arquivo no diretório
if %contador% leq 1 (
    echo Nenhum ou apenas um arquivo encontrado no diretório. Nada a ser feito.
    exit /b
)

REM Configura uma variável para armazenar o nome do arquivo mais antigo e a data do arquivo mais antigo
set "arquivo_mais_antigo="
set "data_mais_antiga="

REM Percorre todos os arquivos do diretório
for %%F in (*) do (
    REM Verifica se o arquivo é realmente um arquivo (não é um diretório)
    if not "%%~aF"=="d" (
        REM Verifica se a variável do arquivo mais antigo está vazia (ainda não há arquivo selecionado)
        if not defined arquivo_mais_antigo (
            set "arquivo_mais_antigo=%%F"
            set "data_mais_antiga=%%~tF"
        ) else (
            REM Compara as datas dos arquivos para encontrar o mais antigo
            for /f "usebackq tokens=1-3 delims=/: " %%A in ('echo %%~tF') do (
                set "dia_atual=%%A"
                set "mes_atual=%%B"
                set "ano_atual=%%C"
            )
            for /f "usebackq tokens=1-3 delims=/: " %%A in ('echo !data_mais_antiga!') do (
                set "dia_antigo=%%A"
                set "mes_antigo=%%B"
                set "ano_antigo=%%C"
            )
            if !ano_atual! lss !ano_antigo! (
                set "arquivo_mais_antigo=%%F"
                set "data_mais_antiga=%%~tF"
            ) else if !ano_atual! equ !ano_antigo! (
                if !mes_atual! lss !mes_antigo! (
                    set "arquivo_mais_antigo=%%F"
                    set "data_mais_antiga=%%~tF"
                ) else if !mes_atual! equ !mes_antigo! (
                    if !dia_atual! lss !dia_antigo! (
                        set "arquivo_mais_antigo=%%F"
                        set "data_mais_antiga=%%~tF"
                    )
                )
            )
        )
    )
)

REM Verifica se foi encontrado algum arquivo no diretório
if not defined arquivo_mais_antigo (
    echo Nenhum arquivo encontrado no diretório: %diretorio%
    exit /b
)

REM Remove o arquivo mais antigo
echo Removendo o arquivo mais antigo: %arquivo_mais_antigo%
del "%arquivo_mais_antigo%"
echo Arquivo removido com sucesso!

pause