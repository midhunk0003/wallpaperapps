import 'package:flutter/material.dart';
import 'package:wallpaperapp/controller/apiOp.dart';
import 'package:wallpaperapp/model/photomodel.dart';
import 'package:wallpaperapp/view/searchscreen.dart';

class SearchBarWid extends StatefulWidget {
  SearchBarWid({Key? key,}) : super(key: key);

  @override
  State<SearchBarWid> createState() => _SearchBarWidState();
}

class _SearchBarWidState extends State<SearchBarWid> {
  TextEditingController searchquerycontroller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: const Color.fromARGB(176, 189, 188, 188),
        border: Border.all(color: const Color.fromARGB(255, 250, 247, 247)),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchquerycontroller,
              decoration: InputDecoration(
                hintText: "Search Wallpaper",
                errorBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                border: InputBorder.none,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              print("searching......");
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SearchScreen(qury: searchquerycontroller.text);
              }));
            },
            child: Icon(Icons.search),
          )
        ],
      ),
    );
  }
}
