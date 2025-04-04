from fastapi.testclient import TestClient
from app.app import app

client = TestClient(app)

class TestBuscarEndpoint:

    def test_buscar_operadora_existente(self):
        response = client.get("/buscar?term=SAUDE")
        assert response.status_code == 200
        assert "resultado" in response.json()
        assert len(response.json()["resultado"]) > 0

    def test_buscar_operadora_inexistente(self):
        response = client.get("/buscar?term=XYZ123")
        assert response.status_code == 200
        assert "resultado" in response.json()
        assert len(response.json()["resultado"]) == 0

    def test_buscar_termo_curto(self):
        response = client.get("/buscar?term=a")
        assert response.status_code == 422

    def test_buscar_sem_parametro(self):
        response = client.get("/buscar")
        assert response.status_code == 422
