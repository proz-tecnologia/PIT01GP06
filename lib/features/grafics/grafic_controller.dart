// import '../transactions/transactions_repository.dart';
// import 'grafic_expenses.dart';

// class GraficController {
//   final TransactionsRepository _transactionsRepository;
//   GraficController(this._transactionsRepository);

//   Future<List<MyData>?> getExpensesSnapshot() async {
//     List<MyData>? dataSavings = [];

//     try {
//       dataSavings = await _transactionsRepository.getExpensesSnapshot(1, 2023);
      

//       //dataSavings = savings.map((e) => MyData(e.nomeInstituicao, e.balance as double)).toList();
//       // for (var saving in savings) {
//       //   dataSavings.add(MyData(saving.nomeInstituicao, saving.balance as double));
//       // }
//       print(dataSavings);
//        return dataSavings;
//     } catch (e) {
//        return null;
//     }
//   }
// }
