import 'package:flutter/material.dart';

import '../app_shimmer.dart';

class DetailShimmer extends StatelessWidget {
  const DetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
        child: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              color: Colors.white,
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              height: 30.0,
              width: 200.0,
              color: Colors.white,
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              height: 20.0,
              width: 150.0,
              color: Colors.white,
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              height: 200.0,
              width: double.infinity,
              color: Colors.white,
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              height: 30,
              width: double.infinity,
              color: Colors.white,
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              height: 40.0,
              width: 40.0,
              color: Colors.white,
            ),
          ],
        ),
      ),
    ));
  }
}
