import 'package:flutter/material.dart';
import 'package:wallpaperapp/controller/apiOp.dart';
import 'package:wallpaperapp/model/photomodel.dart';
import 'package:wallpaperapp/view/fullscreen.dart';
import 'package:wallpaperapp/view/widgets/categoryphoto.dart';
import 'package:wallpaperapp/view/widgets/searchbar.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<PhotoModel> trendingwallList = [];
  bool isLoading = true; // Add this flag to track loading state

  Future<void> GetTrendingWallpaper() async {
    try {
      trendingwallList = await Apiop.getTrendingWallpaper();
    } catch (e) {
      // Handle error (optional)
      print("Error fetching wallpapers: $e");
    } finally {
      setState(() {
        isLoading = false; // Set loading to false when data fetch is complete
      });
    }
  }

  @override
  void initState() {
    GetTrendingWallpaper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wallpaper app"),
      ),
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
                    color: const Color.fromARGB(255, 0, 0, 0),
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
                              itemCount: trendingwallList.length,
                              itemBuilder: (context, index) {
                                return Categoryphoto(
                                  imgSrc: trendingwallList[index].imgSrc,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Grid view
                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        )),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      height: 700,
                      child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: 400,
                          crossAxisCount: 2,
                          crossAxisSpacing: 13,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: trendingwallList.length,
                        itemBuilder: (context, index) {
                          return GridTile(
                            child: InkWell(
                              onTap: () {
                                print("fullscreen");
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Fullscreen(
                                      imgUrl: trendingwallList[index].imgSrc);
                                }));
                              },
                              child: Hero(
                                tag: trendingwallList[index].imgSrc,
                                child: Container(
                                  height: 500,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      trendingwallList[index].imgSrc,
                                      fit: BoxFit.cover,
                                    ),
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
