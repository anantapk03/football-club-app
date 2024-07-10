// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:logger/logger.dart';
import '../../features/detailclub/model/detail_club_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteHelper {
  static const String FAVORITES_KEY = "favorite_teams";
  final _logger = Logger();

  Future<void> addFavorite(DetailClubModel team) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList(FAVORITES_KEY) ?? [];
    favorites.add(jsonEncode(team.toJson()));
    await prefs.setStringList(FAVORITES_KEY, favorites);
  }

  Future<void> removeFavorite(String idTeam) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList(FAVORITES_KEY) ?? [];
    favorites.removeWhere(
        (team) => DetailClubModel.fromJson(jsonDecode(team)).idTeam == idTeam);
    await prefs.setStringList(FAVORITES_KEY, favorites);
  }

  Future<List<DetailClubModel>> getFavoriteTeams() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList(FAVORITES_KEY) ?? [];
    _logger.i("Loaded ${favorites.length} favoorite teams");
    return favorites
        .map((team) => DetailClubModel.fromJson(jsonDecode(team)))
        .toList();
  }

  Future<bool> isFavorite(String idTeam) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList(FAVORITES_KEY) ?? [];
    return favorites.any(
        (team) => DetailClubModel.fromJson(jsonDecode(team)).idTeam == idTeam);
  }
}
