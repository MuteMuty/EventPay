import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../router/routes.dart';
import '../../style/colors.dart';
import '../../style/constants.dart';

class EPCard extends StatelessWidget {
  final String title;
  final num money;
  final String pic;

  final Function()? onTap;

  const EPCard(
      {Key? key,
      required this.title,
      required this.money,
      required this.pic,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                image: DecorationImage(
                  image: NetworkImage(pic),
                  fit: BoxFit.fill,
                ),
              ),
              width: double.infinity,
              height: h * 0.26,
            ),
            Container(
              width: double.infinity,
              height: h * 0.26,
              color: EPColor.almostBlack.withOpacity(0.25),
            ),
            Padding(
              padding: EdgeInsets.only(right: w * 0.04, bottom: h * 0.025),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    money.toString() + ' €',
                    style: const TextStyle(
                      fontSize: 48,
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
