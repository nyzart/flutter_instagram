import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  Header(this.param);

  final String param;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.width;

    return Column(
      children: [
        SizedBox(
            height: height / 4,
          ),
        Center(
          child:
            Text(
            param,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 32  
              )
            )
        ),
        SizedBox(
          height: height / 20,
        )
      ]
    );
  }
}