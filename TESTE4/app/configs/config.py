import os
import pandas as pd
from remove_acento.remove_acento import remover_acentos

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
CSV_PATH = os.path.join(BASE_DIR, "..", "download", "Relatorio_cadop.csv")

if not os.path.exists(CSV_PATH):
    raise FileNotFoundError(f"Ocorreu um erro: O arquivo CSV não encontrado em: {CSV_PATH}")

try:
    df = pd.read_csv(CSV_PATH, encoding="utf-8", sep=";", low_memory=False)
    print("CSV carregado com sucesso")
except Exception as e:
    raise ValueError(f"Ocorreu um erro: Erro ao carregar CSV: {e}")

df["Razao_Social_SemAcento"] = df["Razao_Social"].fillna("").apply(remover_acentos)
df["Nome_Fantasia_SemAcento"] = df["Nome_Fantasia"].fillna("").apply(remover_acentos)
