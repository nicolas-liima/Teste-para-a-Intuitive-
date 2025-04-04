import os
import pandas as pd
import zipfile
import tabula

def extractorDados():
    BASE_DIR = os.path.dirname(os.path.abspath(__file__))
    DOWNLOADS_DIR = os.path.abspath(os.path.join(BASE_DIR, '..', 'downloads'))

    PDF_PATH = os.path.join(DOWNLOADS_DIR, 'Anexo_I.pdf')
    CSV_FILENAME = os.path.join(DOWNLOADS_DIR, "dados_convertidos.csv")
    ZIP_FILENAME = os.path.join(DOWNLOADS_DIR, "Teste_Nicolas.zip")

    print("Extraindo as tabelas do PDF")
    tabelas = tabula.read_pdf(PDF_PATH, pages="all", multiple_tables=True)

    df_total = pd.concat(tabelas, ignore_index=True)

    if "OD" in df_total.columns:
        df_total["OD"] = df_total["OD"].replace({
            "X": "Procedimento Odontológico",
            "": "Não se aplica",
            None: "Não se aplica"
        })

    if "AMB" in df_total.columns:
        df_total["AMB"] = df_total["AMB"].replace({
            "X": "Ambulatorial",
            "": "Não se aplica",
            None: "Não se aplica"
        })

    df_total.to_csv(CSV_FILENAME, index=False)
    print(f"CSV salvo em: {CSV_FILENAME}")

    with zipfile.ZipFile(ZIP_FILENAME, "w", zipfile.ZIP_DEFLATED) as zipf:
        zipf.write(CSV_FILENAME, arcname="dados_convertidos.csv")

    print(f"Arquivo zipado criado: {ZIP_FILENAME}")
