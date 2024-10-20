import '../model/history_event_club_model.dart';

abstract class HistoryEventClubState {}

class HistoryEventClubLoadSuccess extends HistoryEventClubState {
  final List<HistoryEventClubModel> listHistory;

  HistoryEventClubLoadSuccess(this.listHistory);
}

class HistoryEventClubLoading extends HistoryEventClubState {}

class HistoryEventClubIdle extends HistoryEventClubState {}

class HistoryEventClubError extends HistoryEventClubState {}
