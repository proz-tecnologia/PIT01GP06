import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:projeto_final_flutter/features/home/homesignup/signup_controller.dart';
import 'package:projeto_final_flutter/theme/global/colors.dart';

class GlassmorfismCard extends StatefulWidget {
  final double? balanceRevenues;

  const GlassmorfismCard({Key? key, this.balanceRevenues}) : super(key: key);

  @override
  State<GlassmorfismCard> createState() => _GlassmorfismCardState();
}

class _GlassmorfismCardState extends State<GlassmorfismCard> {
  bool isVisible = false;
  final heightEffect = 113;
  final widthEffect = 83;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final ThemeData mode = Theme.of(context);
    var whichMode = mode.brightness;

    if (whichMode == Brightness.light) {
      return Stack(
          alignment: AlignmentDirectional.centerEnd,
          fit: StackFit.loose,
          children: [
            Positioned(
              top: 15,
              right: 70,
              child: Transform(
                origin: Offset(widthEffect / 2, heightEffect / 2),
                transform: Matrix4.rotationZ(-45 * pi / 180),
                child: Container(
                  height: heightEffect.toDouble(),
                  width: widthEffect.toDouble(),
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.elliptical(200, 300)),
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            const Color.fromRGBO(78, 203, 113, 1),
                            const Color.fromRGBO(68, 230, 181, 1)
                                .withOpacity(0.5)
                          ])),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadiusDirectional.circular(25),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    // height: size.height * .33,
                    width: size.width * .92,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(width: 2, color: Colors.white30),
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              const Color.fromRGBO(78, 143, 203, .25),
                              const Color.fromRGBO(78, 203, 113, 1)
                                  .withOpacity(0.5)
                            ])),
                    child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Olá,',
                              style: TextStyle(
                                  color: MyColor.lightThemesecondaryTextColor,
                                  fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              SignUpController.getUserName(),
                              style: const TextStyle(
                                  color: MyColor.lightThemesecondaryTextColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24),
                            ),
                            const SizedBox(height: 20),
                            const Text('Seu saldo total é de:',
                                style: TextStyle(
                                    color: MyColor.lightThemesecondaryTextColor,
                                    fontSize: 16)),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    isVisible
                                        ? 'R\$ ${widget.balanceRevenues?.toStringAsFixed(2).replaceAll('.', ',')}'
                                        : 'R\$ ....',
                                    style: const TextStyle(
                                        color: MyColor
                                            .lightThemesecondaryTextColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 24)),
                                IconButton(
                                    icon: isVisible
                                        ? const Icon(Icons.remove_red_eye)
                                        : const Icon(Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        isVisible = !isVisible;
                                      });
                                    })
                              ],
                            )
                          ],
                        )),
                  ),
                ),
              ),
            ),
          ]);
    } else {
      return Stack(
          alignment: AlignmentDirectional.centerEnd,
          fit: StackFit.loose,
          children: [
            Positioned(
              top: 15,
              right: 70,
              child: Transform(
                origin: Offset(widthEffect / 2, heightEffect / 2),
                transform: Matrix4.rotationZ(-45 * pi / 180),
                child: Container(
                  height: heightEffect.toDouble(),
                  width: widthEffect.toDouble(),
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.elliptical(200, 300)),
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            const Color.fromRGBO(78, 203, 113, 1),
                            const Color.fromRGBO(68, 230, 181, 1)
                                .withOpacity(0.5)
                          ])),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadiusDirectional.circular(25),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    height: size.height * .33,
                    width: size.width * .92,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(width: 2, color: Colors.white30),
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              const Color.fromRGBO(78, 203, 113, .25),
                              const Color.fromRGBO(78, 203, 113, 1)
                                  .withOpacity(0.5)
                            ])),
                    child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Olá,',
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              SignUpController.getUserName(),
                              style: const TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24),
                            ),
                            const SizedBox(height: 20),
                            const Text('Seu saldo atual é de:',
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 16)),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                
                                Text(
                                    isVisible
                                        ? 'R\$ ${widget.balanceRevenues?.toStringAsFixed(2).replaceAll('.', ',')}'
                                        : 'R\$ ....',
                                    style: const TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 24)),
                                IconButton(
                                    icon: isVisible
                                        ? const Icon(Icons.remove_red_eye)
                                        : const Icon(Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        isVisible = !isVisible;
                                      });
                                    })
                              ],
                            )
                          ],
                        )),
                  ),
                ),
              ),
            ),
          ]);
    }
  }
}
