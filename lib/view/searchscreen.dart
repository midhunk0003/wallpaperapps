import 'package:flutter/material.dart';
import 'package:wallpaperapp/controller/apiOp.dart';
import 'package:wallpaperapp/model/photomodel.dart';
import 'package:wallpaperapp/view/fullscreen.dart';
import 'package:wallpaperapp/view/widgets/categoryphoto.dart';
import 'package:wallpaperapp/view/widgets/searchbar.dart';

class SearchScreen extends StatefulWidget {
  final String qury;
  SearchScreen({Key? key, required this.qury}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<PhotoModel> searchResult = [];
  bool isLoading = true;

  getSearchResult() async {
    setState(() {
      isLoading = true; // Start loading
    });
    searchResult = await Apiop.getSearchBar(widget.qury);
    setState(() {
      isLoading = false; // End loading
    });
  }

  @override
  void initState() {
    super.initState();
    getSearchResult();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(), // Show loading indicator
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 60),
                    width: double.infinity,
                    height: 200,
                    color: const Color.fromARGB(255, 12, 11, 11),
                    child: Column(
                      children: [
                        // Search bar
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: SearchBarWid(),
                        ),
                        // Category
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 12),
                          child: SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 30,
                              itemBuilder: (context, item) {
                                return Categoryphoto(
                                  imgSrc: '',
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // GridView
                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 224, 224, 223),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      height: MediaQuery.of(context).size.height,
                      child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: 400,
                          crossAxisCount: 2,
                          crossAxisSpacing: 13,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: searchResult.length,
                        itemBuilder: (context, index) {
                          return GridTile(
                            child: InkWell(
                              onTap: () {
                                print("fullscreen");
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Fullscreen(
                                      imgUrl: searchResult[index].imgSrc);
                                }));
                              },
                              child: Container(
                                height: 500,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    fit: BoxFit.cover,
                                    searchResult[index].imgSrc,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
