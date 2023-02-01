import 'package:flutter/material.dart';

//ignore: must_be_immutable
class BottomBar extends StatefulWidget {
  int index;
  BottomBar({Key? key, required this.index}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {

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
          Navigator.of(context).pushNamed('/graficos');
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
            widget.index = value;
            navigation(widget.index);
          });
        },
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: widget.index,
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
