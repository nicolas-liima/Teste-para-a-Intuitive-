import unicodedata

def remover_acentos(texto):
    "Remove o acentos de uma string e faz a busca certa."
    if isinstance(texto, str):
        return "".join(
            c for c in unicodedata.normalize("NFD", texto) if unicodedata.category(c) != "Mn"
        )
    return texto
