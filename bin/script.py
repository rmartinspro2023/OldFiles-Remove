import os
from datetime import datetime

# Defina o diretório que você deseja verificar
diretorio = r'C:\Caminho\Para\O\Seu\Diretorio'

# Verifica se o diretório existe
if not os.path.exists(diretorio):
    print(f"Diretório não encontrado: {diretorio}")
    exit()

# Lista todos os arquivos no diretório
arquivos = [os.path.join(diretorio, arquivo) for arquivo in os.listdir(diretorio) if os.path.isfile(os.path.join(diretorio, arquivo))]

# Verifica se há apenas um arquivo no diretório
if len(arquivos) <= 1:
    print("Nenhum ou apenas um arquivo encontrado no diretório. Nada a ser feito.")
    exit()

# Encontra o arquivo mais antigo
arquivo_mais_antigo = None
data_mais_antiga = None

for arquivo in arquivos:
    data_arquivo = datetime.fromtimestamp(os.path.getmtime(arquivo))
    
    if arquivo_mais_antigo is None or data_arquivo < data_mais_antiga:
        arquivo_mais_antigo = arquivo
        data_mais_antiga = data_arquivo

# Remove o arquivo mais antigo
if arquivo_mais_antigo:
    print(f"Removendo o arquivo mais antigo: {arquivo_mais_antigo}")
    os.remove(arquivo_mais_antigo)
    print("Arquivo removido com sucesso!")
else:
    print("Nenhum arquivo encontrado no diretório.")

input("Pressione Enter para sair...")