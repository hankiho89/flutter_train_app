import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SeatPage extends StatefulWidget {
  final String departure;
  final String arrival;

  const SeatPage({
    super.key,
    required this.departure,
    required this.arrival,
  });

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  String? selectedSeat;

  void toggleSeat(String seatId) {
    setState(() {
      selectedSeat = seatId;
    });
  }

  void onBook() {
    if (selectedSeat == null) return;

    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text('예매 확인'),
        content: Text(
          '${widget.departure} → ${widget.arrival}\n좌석: $selectedSeat',
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('취소'),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            child: const Text('확인'),
            onPressed: () {
              Navigator.pop(context); // 닫기
              Navigator.of(context).popUntil((route) => route.isFirst); // 홈으로
            },
          ),
        ],
      ),
    );
  }

  Widget seatBox(String seatId) {
    bool isSelected = seatId == selectedSeat;
    return GestureDetector(
      onTap: () => toggleSeat(seatId),
      child: Container(
        width: 50,
        height: 50,
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: isSelected ? Colors.purple : Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget buildSeatHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          SizedBox(
            width: 50,
            child: Center(
              child: Text('A', style: TextStyle(fontSize: 18)),
            ),
          ),
          SizedBox(
            width: 50,
            child: Center(
              child: Text('B', style: TextStyle(fontSize: 18)),
            ),
          ),
          SizedBox(width: 50),
          SizedBox(
            width: 50,
            child: Center(
              child: Text('C', style: TextStyle(fontSize: 18)),
            ),
          ),
          SizedBox(
            width: 50,
            child: Center(
              child: Text('D', style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSeatStatusBox(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(width: 4),
        Text(label),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('좌석 선택')),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.departure,
                style: const TextStyle(
                  color: Colors.purple,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.arrow_circle_right_outlined, size: 30),
              const SizedBox(width: 10),
              Text(
                widget.arrival,
                style: const TextStyle(
                  color: Colors.purple,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildSeatStatusBox(Colors.purple, '선택됨'),
              const SizedBox(width: 20),
              buildSeatStatusBox(Colors.grey[300]!, '선택 안 됨'),
            ],
          ),
          const SizedBox(height: 20),
          buildSeatHeader(),
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              itemBuilder: (_, row) {
                int rowNum = row + 1;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      seatBox('$rowNum-A'),
                      seatBox('$rowNum-B'),
                      Container(
                        width: 50,
                        alignment: Alignment.center,
                        child: Text(
                          '$rowNum',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      seatBox('$rowNum-C'),
                      seatBox('$rowNum-D'),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              height: 60,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: selectedSeat != null ? onBook : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  '예매 하기',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
