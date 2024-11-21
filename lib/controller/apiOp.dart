import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wallpaperapp/model/photomodel.dart';

class Apiop {
  static List<PhotoModel> trendingWallpaper = [];
  static List<PhotoModel> searchwallpaper = [];
  static Future<List<PhotoModel>> getTrendingWallpaper() async {
    await http.get(Uri.parse("https://api.pexels.com/v1/curated"), headers: {
      "Authorization":
          "wdGJaXETthKJm8pPTrytSCMzN8SymmyrqR1aVaci2R36PYUfkOq7xeVo"
    }).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData["photos"];

      photos.forEach((element) {
        trendingWallpaper.add(PhotoModel.fromApi2App(element));
      });
    });
    return trendingWallpaper;
  }

  ///search wallpaper
  static Future<List<PhotoModel>> getSearchBar(String qury) async {
    await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=$qury&per_page=30&page=1"),
        headers: {
          "Authorization":
              "wdGJaXETthKJm8pPTrytSCMzN8SymmyrqR1aVaci2R36PYUfkOq7xeVo"
        }).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData["photos"];
      searchwallpaper.clear();
      photos.forEach((element) {
        searchwallpaper.add(PhotoModel.fromApi2App(element));
      });
    });
    return searchwallpaper;
  }
}





// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:wallpaperapp/model/photomodel.dart';

// class Apiop {
//   // static late List<PhotoModel> trendingWallpaper;
//    getTrendingWallpaper() async {
//     await http.get(Uri.parse("https://api.pexels.com/v1/curated"), headers: {
//       "Authorization":
//           "wdGJaXETthKJm8pPTrytSCMzN8SymmyrqR1aVaci2R36PYUfkOq7xeVo"
//     }).then((value) {
//       Map<String, dynamic> jsonData = jsonDecode(value.body);
//       List photos = jsonData["photos"];

//       photos.forEach((element) {
//         // trendingWallpaper.add(PhotoModel.fromApi2App(element));
//         Map<String, dynamic> src = element["src"];
//         print(src["portrait"]);
//       });
//     });
//     // return trendingWallpaper;
//   }
// }
