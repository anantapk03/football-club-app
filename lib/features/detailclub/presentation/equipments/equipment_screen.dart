import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/widget/shimmer/list_club_shimmer.dart';
import '../../model/equipment_item_model.dart';
import 'equipment_card.dart';
import 'equipment_controller.dart';
import 'equipment_state.dart';

class EquipmentScreen extends StatefulWidget {
  final String? idTeam;

  const EquipmentScreen({super.key, this.idTeam});

  @override
  State<EquipmentScreen> createState() => _EquipmentScreenState();
}

class _EquipmentScreenState extends State<EquipmentScreen> {
  final EquipmentController _controller = Get.find();

  @override
  void initState() {
    super.initState();
    _controller.id.value = widget.idTeam ?? "123455";
    _controller.loadHistoryEquipment();
  }

  @override
  Widget build(BuildContext context) {
    return _buildListEquipment();
  }

  Widget _buildListEquipment() {
    return GetBuilder<EquipmentController>(builder: (ctrl) {
      final equipmentState = ctrl.equipmentState;

      if (equipmentState is EquipmentLoading) {
        return const ListClubShimmer();
      }
      if (equipmentState is EquipmentError) {
        return const Center(
          child: Text("Error"),
        );
      }

      if (equipmentState is EquipmentLoadSuccess) {
        if (equipmentState.listEquipment?.equipment == null) {
          return _buildEmptyState();
        }
        return _contentListEquipment(
            equipmentState.listEquipment?.equipment ?? []);
      }
      return Container();
    });
  }

  Widget _contentListEquipment(List<EquipmentItemModel>? items) {
    if (items!.isEmpty) {
      return const Center(
        child: Text("No Equipment Available"),
      );
    }
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Jumlah kolom dalam grid
        mainAxisSpacing: 8, // Jarak antar baris
        crossAxisSpacing: 8, // Jarak antar kolom
        childAspectRatio: 0.8, // Rasio ukuran item grid
      ),
      itemCount: items.length,
      padding: const EdgeInsets.all(8), // Padding untuk seluruh GridView
      itemBuilder: (context, index) {
        final item = items[index];
        return EquipmentCard(
          itemModel: item,
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error,
          color: Colors.red,
        ),
        SizedBox(
          height: 8.0,
        ),
        Text("Data Tidak Ditemukan")
      ],
    );
  }
}
