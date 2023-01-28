
DateTime clickProximoMes(int ano, int mes, int dia) {
  if (mes > 12) {
    ano++;
    mes = 1;
  } else {
    mes++;
  }
  DateTime novaData = DateTime(ano, mes, dia);
  return novaData;
}

// Função que passa para o mês anterior
DateTime clickMesAnterior(int ano, int mes, int dia) {
  if (mes < 1) {
    ano--;
    mes = 12;
  } else {
    mes--;
  }
  DateTime novaData = DateTime(ano, mes, dia);
  return novaData;
}
