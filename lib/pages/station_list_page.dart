import 'package:flutter/material.dart';
import '../models/constants.dart';

class StationListPage extends StatelessWidget {
  final String selectType;
  const StationListPage({super.key, required this.selectType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(selectType)),
      body: ListView.separated(
        itemCount: stationList.length,
        separatorBuilder: (_, __) =>
            Divider(color: Colors.grey[300]!, height: 1),
        itemBuilder: (context, index) {
          final station = stationList[index];
          return GestureDetector(
            onTap: () => Navigator.pop(context, station),
            child: Container(
              height: 50,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                station,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
