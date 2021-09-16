import 'package:flutter/material.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:park_it/config/theme.dart';
import 'package:park_it/screens/booking/maps.dart';

class ParkingDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.loose,
          children: [
            MapView(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  BackButton(),
                  Text(
                    "Book a parking spot!".toUpperCase(),
                    style: TextStyle(
                      fontSize: 20,
                      color: Palette.red,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimSearchBar(
                  rtl: true,
                  width: size.width,
                  textController: textController,
                  onSuffixTap: null),
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: Palette.white,
                ),
                height: size.height * 0.8,
                width: size.width * 0.9,
                child: Column(
                  children: [
                    Spacer(),
                    ElevatedButton(
                        onPressed: () {
                          /* Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ConfirmBooking())); */
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.green.shade700)),
                        child: Text(
                          "Book A Slot",
                          style: TextStyle(color: Palette.white),
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* import 'package:flutter/material.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:park_it/config/theme.dart';

class ConfirmBooking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.loose,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  BackButton(),
                  Text(
                    "Book a parking spot!".toUpperCase(),
                    style: TextStyle(
                      fontSize: 20,
                      color: Palette.red,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimSearchBar(
                  rtl: true,
                  width: size.width,
                  textController: textController,
                  onSuffixTap: null),
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: Palette.white,
                ),
                height: size.height * 0.8,
                width: size.width * 0.9,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 */