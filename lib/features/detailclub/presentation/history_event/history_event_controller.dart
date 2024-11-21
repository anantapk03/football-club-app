import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../../components/util/helper.dart';
import '../../../../components/util/state.dart';
import '../../model/history_event_club_model.dart';
import '../../repository/detailclub_repository.dart';
import '../history_event_club_state.dart';

class HistoryEventController extends GetxController {
  final DetailclubRepository _repository;
  HistoryEventClubState historyEventClubState = HistoryEventClubIdle();

  final _logger = Logger();
  final isFullDetailDescription = false.obs;

  HistoryEventController(
    this._repository,
  );

  List<HistoryEventClubModel>? listHistoryClub = [];
  Rx<double> latitude = 0.0.obs;
  Rx<double> longitude = 0.0.obs;
  final id = "".obs;

  Future<void> loadListHistoryEventClub() async {
    historyEventClubState = HistoryEventClubLoading();
    update();
    _repository.loadHistoryEventClub(
        response: ResponseHandler(onSuccess: (listHistoryEventClub) {
          historyEventClubState =
              HistoryEventClubLoadSuccess(listHistoryEventClub);
          listHistoryClub = listHistoryEventClub;
        }, onFailed: (e, message) {
          _logger.e(e);
          AlertModel.showBasic("Error", message);
          historyEventClubState = HistoryEventClubError();
        }, onDone: () {
          update();
        }),
        idTeam: id.value);
  }
}
