import 'package:flutter/material.dart';
import 'station_list_page.dart';
import 'seat_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? departure;
  String? arrival;

  Future<void> selectStation(String type) async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (_) => StationListPage(selectType: type),
      ),
    );
    if (result != null) {
      setState(() {
        if (type == '출발역') departure = result;
        else arrival = result;
      });
    }
  }

  void goToSeatPage() {
    if (departure != null && arrival != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SeatPage(
            departure: departure!,
            arrival: arrival!,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('기차 예매')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => selectStation('출발역'),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '출발역',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            departure ?? '선택',
                            style: const TextStyle(fontSize: 40),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 2,
                    height: 50,
                    color: Colors.grey[400],
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => selectStation('도착역'),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '도착역',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            arrival ?? '선택',
                            style: const TextStyle(fontSize: 40),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed:
                    (departure != null && arrival != null) ? goToSeatPage : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text(
                  '좌석 선택',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
