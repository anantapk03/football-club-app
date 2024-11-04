import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../components/util/helper.dart';
import '../../../components/util/state.dart';
import '../model/team_model.dart';
import '../repository/team_repository.dart';
import 'list_league_state.dart';
import 'team_state.dart';

class TeamController extends GetxController {
  final isFocusNodeSearch = FocusNode();
  var isSearchFocused = false.obs;
  final TeamRepository _repository;
  TeamState teamState = TeamIdle();
  ListLeagueState listLeagueState = ListLeagueIdle();
  final _logger = Logger();
  var searchQuery = "".obs;
  List<TeamModel> allTeams = [];
  var searchResults = <TeamModel>[].obs;
  TeamController(this._repository);
  final isShowMore = false.obs;

  @override
  void onInit() {
    super.onInit();
    isFocusNodeSearch.addListener(() {
      isSearchFocused.value = isFocusNodeSearch.hasFocus;
    });
    _loadAllTeam();
    _loadAllLeagues();
  }

  @override
  void onClose() {
    isFocusNodeSearch
        .dispose(); // Pastikan untuk dispose FocusNode saat tidak dipakai
    super.onClose();
  }

  void _loadAllTeam() {
    teamState = TeamLoading();
    update();
    _repository.loadTeams(
        response: ResponseHandler(onSuccess: (listTeam) {
      teamState = TeamLoadSuccess(listTeam);
      allTeams = listTeam;
      searchResults.value = listTeam;
    }, onFailed: (e, message) {
      _logger.e(e);
      AlertModel.showBasic("Error", message);
      teamState = TeamError();
    }, onDone: () {
      update();
    }));
  }

  void _loadAllLeagues() {
    listLeagueState = ListLeagueLoading();
    update();
    _repository.loadListLeagues(
        response: ResponseHandler(onSuccess: (listLeague) {
      listLeagueState = LisLeagueLoadSuccess(listLeague);
    }, onFailed: (e, message) {
      _logger.e(e);
      AlertModel.showBasic("Error", message);
      listLeagueState = ListLeagueError();
    }, onDone: () {
      update();
    }));
  }

  void searchTeams(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      searchResults.value = allTeams;
    } else {
      List<TeamModel> filteredTeams = allTeams.where((team) {
        return team.nameTeam!.toLowerCase().contains(query.toLowerCase());
      }).toList();
      searchResults.value = filteredTeams;
    }
    update();
  }
}
