import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FirePage extends StatefulWidget {
  const FirePage({super.key});

  @override
  State<FirePage> createState() => FirePageState();
}

class FirePageState extends State<FirePage> {
  int _likes = 0;
  late final DatabaseReference _likesRef;
  late StreamSubscription<DatabaseEvent> _likesSubscription;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    _likesRef = FirebaseDatabase.instance.ref('likes');
    try {
      final likeSnapshot = await _likesRef.get();
      _likes = likeSnapshot.value as int;
    } catch (err) {
      debugPrint(err.toString());
    }

    _likesSubscription = _likesRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        _likes = (event.snapshot.value ?? 0) as int;
      });
    });
  }

  like() async {
    await _likesRef.set(ServerValue.increment(1));
  }

  @override
  void dispose() {
    _likesSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(onPressed: like, icon: const Icon(Icons.thumb_up)),
          Text(_likes.toString(), style: const TextStyle(fontSize: 20))
        ],
      ),
    ));
  }
}
