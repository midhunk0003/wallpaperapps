import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class Fullscreen extends StatefulWidget {
  final String imgUrl;

  const Fullscreen({super.key, required this.imgUrl});

  @override
  State<Fullscreen> createState() => _FullscreenState();
}

class _FullscreenState extends State<Fullscreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    log("aagagsg --- ${widget.imgUrl}");
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: ElevatedButton(
        onPressed: () async {
          final res = await http.get(Uri.parse(widget.imgUrl));
          final directory = await getTemporaryDirectory();
          final tempPath = directory.path;
          // Split the URL at the '?' to remove query parameters
          final splitUrl = widget.imgUrl.split('?');

          // Extract the file name from the first part
          final fileName = splitUrl[0].split('/').last;
          // Create a file path
          final filePath = '$tempPath/$fileName';

          // Save the image to the file
          final file = File(filePath);
          await file.writeAsBytes(res.bodyBytes);
          await Share.shareXFiles([XFile(file.path)]);
        },
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Download"),
            SizedBox(width: 5), // Add spacing between text and icon
            Icon(Icons.download),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(widget.imgUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
