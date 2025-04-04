<template>
  <div class="home-container">
    <h1>Buscar Operadoras</h1>
    <input 
      v-model="busca" 
      @input="buscarOperadoras" 
      class="search-input" 
      placeholder="Digite para buscar" 
    />

    <div v-if="resultados.length" class="resultados-container">
      <OperadorCard v-for="op in resultados" :key="op.registro_ans" :operadora="op" />
    </div>
    <p v-else class="no-results">Nenhum resultado.</p>
  </div>
</template>

<script>
import api from '@/services/api';
import OperadorCard from '@/components/OperadorCard.vue';

export default {
  name: 'HomeView',
  components: { OperadorCard },
  data() {
    return {
      busca: '',
      resultados: [],
    };
  },
  methods: {
    async buscarOperadoras() {
      if (this.busca.length < 3) {
        this.resultados = [];
        return;
      }

      try {
        const res = await api.get(`/buscar?term=${this.busca}`);
        this.resultados = res.data.resultado.map(op => ({
          razao_social: op.Razao_Social,
          cnpj: op.CNPJ,
          registro_ans: op.Registro_ANS,
        }));
      } catch (error) {
        console.error('Ocorreu um erro: Erro na busca:', error);
        this.resultados = [];
      }
    },
  },
};
</script>

<style scoped>
.home-container {
  padding: 20px;
  max-width: 900px;
  margin: 0 auto;
  font-family: 'Arial', sans-serif;
  color: #333;
}

h1 {
  text-align: center;
  margin-bottom: 20px;
  font-size: 2rem;
}

.search-input {
  width: 100%;
  padding: 10px;
  font-size: 1.1rem;
  border-radius: 8px;
  border: 1px solid #ccc;
  margin-bottom: 20px;
  transition: border-color 0.3s ease;
}

.search-input:focus {
  outline: none;
  border-color: #007BFF;
}

.resultados-container {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
  gap: 20px;
}

.no-results {
  text-align: center;
  color: #888;
  font-size: 1.2rem;
}
</style>
