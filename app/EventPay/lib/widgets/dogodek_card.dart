import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../router/routes.dart';
import '../style/colors.dart';
import '../style/constants.dart';

class DogodekCard extends StatelessWidget {
  final String datum;
  final String kraj;
  final String naslov;
  final String slika;

  final Function()? onTap;

  const DogodekCard(
      {Key? key,
      required this.datum,
      required this.kraj,
      required this.naslov,
      required this.slika,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12.0)),
              image: DecorationImage(
                image: NetworkImage(slika),
                fit: BoxFit.fill,
              ),
            ),
            width: double.infinity,
            height: h * 0.26,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12.0)),
              color: EPColor.almostBlack.withOpacity(0.25)
            ),
            width: double.infinity,
            height: h * 0.26,
          ),
          Padding(
            padding: EdgeInsets.only(right: w * 0.04, bottom: h * 0.025),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      kraj,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 10,),
                    Icon(Icons.location_city, color: Colors.white,)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      datum.split("T")[0],
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 10,),
                    Icon(Icons.calendar_month, color: Colors.white,)
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    naslov,
                    style: const TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
