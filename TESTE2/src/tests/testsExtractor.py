import os
import zipfile
import pandas as pd
import sys

EXTRACTOR_PATH = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', "downloads"))
sys.path.append(EXTRACTOR_PATH)

from extractor.extractorDados import extractorDados

def setup_module(module):
    extractorDados()

CSV_FILENAME = os.path.join(EXTRACTOR_PATH, 'dados_convertidos.csv')
ZIP_FILENAME = os.path.join(EXTRACTOR_PATH, 'Teste_Nicolas.zip')


def test_se_csv_existe():
    assert os.path.exists(CSV_FILENAME), "Ocorreu um erro: CSV não foi gerado."


def test_se_zip_existe():
    assert os.path.exists(ZIP_FILENAME), "Ocorreu um erro: ZIP não foi gerado."

# o "r" serve para abrir o arquivo
# se fosse para criar eu usaria "w"
# se fosse para abrir e adicionar arquivos seria o "a"
def test_se_zip_contem_csv():
    with zipfile.ZipFile(ZIP_FILENAME, 'r') as zipf:
        assert 'dados_convertidos.csv' in zipf.namelist(), "Ocorreu um erro: CSV não está dentro do ZIP."


def test_para_substituicoes_od_amb():
    df = pd.read_csv(CSV_FILENAME)
    if 'OD' in df.columns:
        assert not df['OD'].str.contains('X', na=False).any(), "Ocorreu um erro: 'X' ainda existe na coluna OD"
    if 'AMB' in df.columns:
        assert not df['AMB'].str.contains('X', na=False).any(), "Ocorreu um erro: 'X' ainda existe na coluna AMB"
