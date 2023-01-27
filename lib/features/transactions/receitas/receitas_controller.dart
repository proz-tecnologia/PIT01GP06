class ReceitasController{  

  double convertStringToDouble(String valor){
    double formattedValue = 0.0;
    if(valor.length >= 4 && valor.length <= 6){
      formattedValue = double.parse(valor.replaceFirst(RegExp(r','), '.'));
    } else{
      final newValue = valor.replaceAll('.', '');
      formattedValue = double.parse(newValue.replaceFirst(RegExp(r','), '.'));
    }
    return formattedValue;
  }
  
  List<Map<String, dynamic>> listaCategorias = [
    {'id': 0, 'categoria' : 'Outros'},
    {'id': 1, 'categoria' : 'Comissão'},
    {'id': 2, 'categoria' : 'Empréstimos'},
    {'id': 3, 'categoria' : 'Presente'},
    {'id': 4, 'categoria' : 'Rendimentos'},
    {'id': 5, 'categoria' : 'Salário'},
    {'id': 6, 'categoria' : 'Serviços'},
    {'id': 7, 'categoria' : 'Vale-alimentação'},
    {'id': 8, 'categoria' : 'Vale-refeição'},
    {'id': 9, 'categoria' : 'Vale-transporte'},
    {'id': 10, 'categoria' : 'Vendas'},
  ];



}