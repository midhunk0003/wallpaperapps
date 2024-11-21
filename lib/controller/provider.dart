import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaperapp/model/photomodel.dart';

class WallpaperProvider extends ChangeNotifier {
  final String _apiKey =
      "wdGJaXETthKJm8pPTrytSCMzN8SymmyrqR1aVaci2R36PYUfkOq7xeVo";

  // State variables
  List<PhotoModel> _trendingWallpapers = [];
  List<PhotoModel> _searchWallpapers = [];
  bool _isLoading = false;

  // Getters
  List<PhotoModel> get trendingWallpapers => _trendingWallpapers;
  List<PhotoModel> get searchWallpapers => _searchWallpapers;
  bool get isLoading => _isLoading;

  // Fetch Trending Wallpapers
  Future<void> fetchTrendingWallpapers() async {
    _isLoading = true;
    notifyListeners(); // Notify listeners about the loading state

    try {
      final response = await http.get(
        Uri.parse("https://api.pexels.com/v1/curated"),
        headers: {"Authorization": _apiKey},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        final List photos = jsonData["photos"];

        _trendingWallpapers =
            photos.map((element) => PhotoModel.fromApi2App(element)).toList();
      } else {
        throw Exception("Failed to load trending wallpapers");
      }
    } catch (e) {
      print("Error fetching trending wallpapers: $e");
    } finally {
      _isLoading = false;
      notifyListeners(); // Notify listeners about state changes
    }
  }

  // Search Wallpapers
  Future<void> searchWallpaperss(String query) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=$query&per_page=30&page=1"),
        headers: {"Authorization": _apiKey},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        final List photos = jsonData["photos"];

        _searchWallpapers =
            photos.map((element) => PhotoModel.fromApi2App(element)).toList();
      } else {
        throw Exception("Failed to search wallpapers");
      }
    } catch (e) {
      print("Error searching wallpapers: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Clear Search Results
  void clearSearchResults() {
    _searchWallpapers.clear();
    notifyListeners();
  }
}
