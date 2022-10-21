import 'package:flutter/material.dart';

class Kop extends StatelessWidget {
  
  const Kop({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(margin: const EdgeInsets.only(bottom: 20),
      child: Column(
          children: [
            Row(mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(onTap: (){
                  Navigator.of(context).pop();
                },
                  child: Image.asset(
                    'images/logo.png',
                    width: 80,
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text(
                        textAlign: TextAlign.justify,
                        'JOYOTOMO',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            fontStyle: FontStyle.italic),
                      ),
                      Text(
                        textAlign: TextAlign.justify,
                        'Kauman RT 05 RW 01, Gemolong, Sragen',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                      Text(
                        textAlign: TextAlign.justify,
                        'TELP:08578181929',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Divider(
            //   height: 10,
            //   thickness: 2.5,
            //   color: Colors.black,
            // ),
            // Divider(
            //   height: 1,
            //   color: Colors.black,
            //   thickness: 2.5,
            // )
          ],
        ),
    );

  }
}
