import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../../../components/widget/app_shimmer.dart';
import '../../../../components/widget/header_title_widget.dart';
import '../../../../components/widget/social_media_icon.dart';
import '../../model/detail_club_model.dart';
import '../../model/history_event_club_model.dart';
import '../history_event_club_state.dart';
import 'history_event_card.dart';
import 'history_event_controller.dart';

class HistoryEventScreen extends StatefulWidget {
  final String? id;
  final DetailClubModel? detailClub;
  const HistoryEventScreen({super.key, required this.id, this.detailClub});

  @override
  State<HistoryEventScreen> createState() => _HistoryEventScreenState();
}

class _HistoryEventScreenState extends State<HistoryEventScreen> {
  final HistoryEventController _controller = Get.find();

  @override
  void initState() {
    super.initState();
    _controller.id.value = widget.id ?? "";
    _controller.loadListHistoryEventClub();
  }

  @override
  Widget build(BuildContext context) {
    return _buildListHistoryEvent(widget.detailClub ?? DetailClubModel());
  }

  Widget _buildListHistoryEvent(DetailClubModel detailClub) {
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
          return _bodyContent(detailClub, state.listHistory);
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

  Widget _bodyContent(
      DetailClubModel detailClub, List<HistoryEventClubModel> listData) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Column(
              children: [
                HeaderTitleWidget(
                    icon: Icons.info,
                    label: AppLocalizations.of(context)?.description ?? ""),
                const SizedBox(
                  height: 8.0,
                ),
                Obx(() {
                  return GestureDetector(
                    onTap: () {
                      _controller.isFullDetailDescription.value =
                          !_controller.isFullDetailDescription.value;
                    },
                    child: Text(
                      detailClub.description ?? "",
                      textAlign: TextAlign.justify,
                      maxLines:
                          _controller.isFullDetailDescription.value ? null : 2,
                      overflow: _controller.isFullDetailDescription.value
                          ? null
                          : TextOverflow.ellipsis,
                    ),
                  );
                }),
                const SizedBox(
                  height: 8.0,
                ),
                HeaderTitleWidget(
                    icon: Icons.description,
                    label: AppLocalizations.of(context)?.socialMedia ??
                        "Social Media"),
                const SizedBox(
                  height: 8.0,
                ),
                _socialMediaLinks(detailClub),
                const SizedBox(
                  height: 8.0,
                ),
                HeaderTitleWidget(
                    icon: Icons.history,
                    label: AppLocalizations.of(context)?.historyEvent ??
                        "History Event"),
              ],
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          SizedBox(height: 228, child: _listHistoryEvent(listData)),
        ],
      ),
    );
  }

  Widget _socialMediaLinks(DetailClubModel detailClub) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SocialMediaIcon(
          url: detailClub.facebookUrl ?? "www.facebook.com/anantapadmakusuma5",
          icon: Icons.facebook,
          color: Colors.blue,
        ),
        const SizedBox(width: 16),
        SocialMediaIcon(
          url: detailClub.instagramUrl ?? "www.instagram.com/anantapk03",
          icon: Icons.camera_alt,
          color: Colors.pink,
        ),
        const SizedBox(width: 16),
        SocialMediaIcon(
          url: detailClub.twitterUrl ?? "www.x.com/anantapk03",
          icon: Icons.alternate_email,
          color: Colors.lightBlue,
        ),
      ],
    );
  }

  Widget _listHistoryEvent(
    List<HistoryEventClubModel> listData,
  ) {
    if (listData.isNotEmpty) {
      return ListView.builder(
          scrollDirection: Axis.horizontal,
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
