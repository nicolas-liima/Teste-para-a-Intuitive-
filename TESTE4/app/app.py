from fastapi import FastAPI, Query
from fastapi.middleware.cors import CORSMiddleware 
from configs.config import df

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"], 
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

def buscar_operadoras(term: str):
    "Filtra o operadoras pelo seu nome ou razão social."
    filtro = df[
        df["Razao_Social"].fillna("").str.contains(term, case=False, na=False) |
        df["Nome_Fantasia"].fillna("").str.contains(term, case=False, na=False)
    ]
    filtro = filtro.fillna("")
    return filtro.to_dict(orient="records")

@app.get("/buscar")
def buscar(term: str = Query(..., min_length=2, description="Termo de busca")):
    print("RECEBIDO:", term)
    resultado = buscar_operadoras(term)
    print("ENCONTRADO:", len(resultado), "resultados")
    return {"resultado": resultado}
