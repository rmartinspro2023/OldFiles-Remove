# OldFiles-Remove
Projeto realizado em batch script (.bat) para automatizar tarefa de remover arquivos antigos de um diretório em especifico

## VARIAVES A SEREM ALTERADAS

Altere o valor do caminho do diretório que você deseja verificar na linha 5

>Set "diretorio=C:\Caminho\Para\O\Seu\Diretorio"

Para efeito de teste, comente a linha 80 que possui o seguinte codigo:
>del "%arquivo_mais_antigo%"

e adicione o comando

>echo %arquivo_mais_antigo%

sendo assim consegue testar se o valor que será removido da pasta é o correto que deseja.


### Creditos
by  Rogério Martins