import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../../components/util/helper.dart';
import '../../../components/util/state.dart';
import '../model/team_model.dart';
import '../repository/team_repository.dart';
import 'team_state.dart';

class TeamController extends GetxController {
  final TeamRepository _repository;
  TeamState teamState = TeamIdle();
  final _logger = Logger();
  var searchQuery = "".obs;
  List<TeamModel> allTeams = [];
  var searchResults = <TeamModel>[].obs;
  TeamController(this._repository);

  @override
  void onInit() {
    _loadAllTeam();
    super.onInit();
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

  void searchTeams(String query){
    searchQuery.value = query;
    if(query.isEmpty){
      // teamState = TeamLoadSuccess(allTeams);
      searchResults.value = allTeams;
    } else{
      List<TeamModel> filteredTeams = allTeams.where((team){
        return team.nameTeam!.toLowerCase().contains(query.toLowerCase());
      }).toList();
      searchResults.value = filteredTeams;
      // teamState = TeamLoadSuccess(filteredTeams);
    }

    update();
    
  }

}
