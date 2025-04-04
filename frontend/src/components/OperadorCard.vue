<template>
  <div class="card">
    <h3>{{ operadora.razao_social }}</h3>
    <p><strong>CNPJ:</strong> {{ operadora.cnpj }}</p>
    <p><strong>Registro ANS:</strong> {{ operadora.registro_ans }}</p>
  </div>
</template>

<script>
export default {
  name: 'OperadorCard',
  props: {
    operadora: Object,
  },
};
</script>

<style scoped>
.card {
  background-color: #fff;
  padding: 20px;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.162);
  transition: transform 0.3s ease, box-shadow 0.3s ease;
  cursor: pointer;
}

.card:hover {
  transform: translateY(-5px);
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.180);
}

h3 {
  font-size: 1.5rem;
  color: #333;
  margin-bottom: 10px;
}

p {
  font-size: 1rem;
  color: #555;
  margin-bottom: 8px;
}

strong {
  font-weight: bold;
  color: #007bff;
}
</style>
