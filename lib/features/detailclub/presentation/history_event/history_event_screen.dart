import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../../../components/widget/app_shimmer.dart';
import '../../model/history_event_club_model.dart';
import '../history_event_club_state.dart';
import 'history_event_card.dart';
import 'history_event_controller.dart';

class HistoryEventScreen extends StatefulWidget {
  final String? id;

  const HistoryEventScreen({super.key, required this.id});

  @override
  State<HistoryEventScreen> createState() => _HistoryEventScreenState();
}

class _HistoryEventScreenState extends State<HistoryEventScreen> {
  final HistoryEventController _controller = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.id.value = widget.id ?? "";
    _controller.loadListHistoryEventClub();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: _buildListHistoryEvent(),
    );
  }

  Widget _buildListHistoryEvent() {
    return GetBuilder<HistoryEventController>(
      builder: (ctrl) {
        final state = ctrl.historyEventClubState;

        if (state is HistoryEventClubLoading) {
          return AppShimmer(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), color: Colors.white),
            ),
          ));
        }

        if (state is HistoryEventClubLoadSuccess) {
          return _listHistoryEvent(state.listHistory);
        }

        if (state is HistoryEventClubError) {
          return const Center(
            child: Text("Error"),
          );
        }

        return Container();
      },
    );
  }

  Widget _listHistoryEvent(
    List<HistoryEventClubModel> listData,
  ) {
    if (listData.isNotEmpty) {
      return ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: listData.length,
          itemBuilder: (context, index) {
            final historyEvent = listData[index];
            return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                child: HistoryEventCard(clubModel: historyEvent));
          });
    } else {
      return Center(
        child: Text(AppLocalizations.of(context)?.emptyHistoryEvent ??
            "Empty History Event"),
      );
    }
  }
}
