import 'dart:developer';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  var index = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: (value) {
        setState(() {
          index = value;
          log("O valor de index é: $index");
        });
      },
      showSelectedLabels: true,
      showUnselectedLabels: true,
      currentIndex: index,
      items: const  <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          label: 'Inicio',
          icon: Icon(Icons.home),         
          ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet),
          label: 'Carteira',          
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.flag),
          label: 'Metas',          
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.leaderboard),
          label: 'Gráficos',         
        ),
      ],
    );
  }
}