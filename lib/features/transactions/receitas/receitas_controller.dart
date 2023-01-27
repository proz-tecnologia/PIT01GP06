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
    {'id': 2, 'categoria' : 'Presente'},
    {'id': 3, 'categoria' : 'Rendimentos'},
    {'id': 4, 'categoria' : 'Salário'},
    {'id': 5, 'categoria' : 'Serviços'},
    {'id': 6, 'categoria' : 'Vale-alimentação'},
    {'id': 7, 'categoria' : 'Vale-refeição'},
    {'id': 8, 'categoria' : 'Vale-transporte'},
    {'id': 9, 'categoria' : 'Vendas'},
  ];



}