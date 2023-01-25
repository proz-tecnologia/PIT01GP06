import '../features/transactions/despesas/despesas_model.dart';
import '../features/wallets/bank_account/bank_account_model.dart';

class ListaBank {
  final List<BankAccountModel> listBank;
  ListaBank(this.listBank);
}

class ListaDespesa {
  final List<DespesasModel> listDespesa;
  ListaDespesa(this.listDespesa);
}
