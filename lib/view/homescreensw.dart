import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaperapp/controller/provider.dart';
// import 'package:wallpaperapp/controller/wallpaper_provider.dart';
import 'package:wallpaperapp/view/fullscreen.dart';
import 'package:wallpaperapp/view/widgets/searchbar.dart';

class Homescreenw extends StatefulWidget {
  const Homescreenw({Key? key}) : super(key: key);

  @override
  State<Homescreenw> createState() => _HomescreenwState();
}

class _HomescreenwState extends State<Homescreenw> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    // Fetch initial wallpapers
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WallpaperProvider>(context, listen: false)
          .fetchTrendingWallpapers();
    });

    // Add scroll listener for lazy loading
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        Provider.of<WallpaperProvider>(context, listen: false)
            .fetchTrendingWallpapers();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WallpaperProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Wallpaper App"),
      ),
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: provider.isLoading && provider.trendingWallpapers.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Search Bar
                Container(
                  padding: const EdgeInsets.only(top: 60),
                  width: double.infinity,
                  color: const Color.fromARGB(255, 12, 11, 11),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SearchBarWid(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // Grid View
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 224, 224, 223),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: const BoxDecoration(
                        // color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: GridView.builder(
                        controller: _scrollController,
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: 400,
                          crossAxisCount: 2,
                          crossAxisSpacing: 13,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: provider.trendingWallpapers.length + 1,
                        itemBuilder: (context, index) {
                          if (index == provider.trendingWallpapers.length) {
                            return provider.isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : const SizedBox.shrink();
                          }
                          final wallpaper = provider.trendingWallpapers[index];
                          return GridTile(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Fullscreen(imgUrl: wallpaper.imgSrc);
                                }));
                              },
                              child: Hero(
                                tag: wallpaper.imgSrc,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      wallpaper.imgSrc,
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
                ),
              ],
            ),
    );
  }
}
