import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'card_model.dart';

abstract class ICardRepository{
  Future<void> addCard(CardModel card);
}

class CardRepository implements ICardRepository{
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    final _uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Future<void> addCard(CardModel card) {
    return _db.collection('users')
    .doc(_uid)
    .collection('cards')
    .add(card.toMap());
  }

}