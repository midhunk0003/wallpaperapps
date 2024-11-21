import 'package:flutter/material.dart';

class Categoryphoto extends StatefulWidget {
  String imgSrc;
  Categoryphoto({Key? key, required this.imgSrc}) : super(key: key);

  @override
  _CategoryphotoState createState() => _CategoryphotoState();
}

class _CategoryphotoState extends State<Categoryphoto> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
                height: 50,
                width: 100,
                fit: BoxFit.cover,
                "https://images.pexels.com/photos/210019/pexels-photo-210019.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
          ),
          Container(
            width: 100,
            height: 50,
            decoration: BoxDecoration(
              color: const Color.fromARGB(108, 0, 0, 0),
            ),
          ),
          Positioned(
            left: 30,
            top: 15,
            child: Text(
              "Car",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}
