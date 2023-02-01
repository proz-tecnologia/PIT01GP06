import 'dart:developer';

import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  var index = 0;

  void navigation(int index) {
    switch (index) {
      case 0:
        {
          Navigator.of(context).pushNamed('/screen');
        }
        break;

      case 1:
        {
          Navigator.of(context).pushNamed('/addCard');
        }
        break;

      case 2:
        {
          Navigator.of(context).pushNamed('/metas');
        }
        break;

      case 3:
        {
          Navigator.of(context).pushNamed('/grafic');
        }
        break;

      default:
        {
          Navigator.of(context).pushNamed('/screen');
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topRight: Radius.circular(16), topLeft: Radius.circular(16)),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {
            index = value;
            navigation(index);
            log("O valor de index é: $index");
          });
        },
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: index,
        items: const <BottomNavigationBarItem>[
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
      ),
    );
  }
}
