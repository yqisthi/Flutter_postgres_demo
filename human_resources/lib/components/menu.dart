import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:human_resources/datas/icons.dart';
import 'package:human_resources/theme.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var itemCount = menuIcons.length;
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 15,
      ),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: whitePearl,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Align icons to the top
              children: [
                ...menuIcons.sublist(0, 3).map((icon) => Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            child: SvgPicture.asset(
                              'assets/icons/${icon.icon}.svg',
                              // color: blue1,
                            ),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Text(
                            icon.title,
                            // style: semibold14.copyWith(color: Colors.white),
                          )
                        ],
                      ),
                    )),
              ],
            ),

            // SECOND ROW
            Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align icons to the top
              children: [
                ...menuIcons.sublist(3).map((icon) => Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            child: SvgPicture.asset(
                              'assets/icons/${icon.icon}.svg',
                              // color: blue1,
                            ),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Text(
                            icon.title,
                            // style: semibold14.copyWith(color: Colors.white),
                          )
                        ],
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
