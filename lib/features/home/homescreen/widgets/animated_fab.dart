import 'dart:math' as math;

import 'package:flutter/material.dart';

class AnimatedFab extends StatefulWidget {
  const AnimatedFab({super.key, required this.children, required this.distance});

  final List<Widget> children; 
  final double distance;

  @override
  State<AnimatedFab> createState() => _AnimatedFabState();
}

class _AnimatedFabState extends State<AnimatedFab> with SingleTickerProviderStateMixin {
  
  late AnimationController _controller;
  late Animation<double> _expandAnimation; 
  bool _open = false; 

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this
    );

  _expandAnimation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
    reverseCurve: Curves.easeOutQuad);
  }

  void _toggle(){
    setState(() {
      _open = !_open;
      if(_open){
        _controller.forward();
      } else {
        _controller.reverse();
      } 
    });
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }
   

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          _tapToClose(),
          ..._buildExpandedFabButton(),
          _tapToOpen()
        ],
      ),
    );
  }

  Widget _tapToClose(){
    return SizedBox(
      height: 55,
      width: 55,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4,
          child: InkWell(
            onTap: () => _toggle,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.close,
                color: Colors.black,
              ),
            ),
            ),
          ),
        ),
      );
  }

  Widget _tapToOpen(){
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      transformAlignment: Alignment.center,
      transform: Matrix4.diagonal3Values(
        _open ? 0.7 : 1.0,
        _open ? 0.7 : 1.0,
        1.0,
      ),
      curve: Curves.easeOut,
      child: AnimatedOpacity(
        opacity: _open ? 0.0 : 1.0,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 250),
        child: FloatingActionButton(
          onPressed: _toggle,
          child: const Icon(Icons.add_rounded, size: 40,),
        ),
      ),
    );
  }

  List<Widget> _buildExpandedFabButton(){
    final List<Widget> children = <Widget>[]; 
    final count = widget.children.length;
    final step = 90.0 / (count - 1);

    for(var i = 0, angleInDegrees = 0.0; i< count; i++, angleInDegrees += step){
      children.add(
        _ExpandableFab(
          directionDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i]
        )
      );
    }
    return children;
  }

}

class _ExpandableFab extends StatelessWidget {
  const _ExpandableFab({super.key, required this.directionDegrees, required this.maxDistance, required this.progress, required this.child});

  final double directionDegrees;
  final double maxDistance;
  final Animation<double>? progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress!,
      builder: (context, child){
        final offset = Offset.fromDirection(
          directionDegrees * (math.pi / 180),
          progress!.value * maxDistance,
        );
        return Positioned(
          right: 4.0 + offset.dx,
          bottom: 4.0 + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress!.value) * (math.pi / 2),
            child: child,
          ));
      },
      child: FadeTransition(
        opacity: progress!,
        child: child,
      ),
      );
  }
}