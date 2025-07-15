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
  final Set<int> selectedSeats = {};

  void toggleSeat(int i) {
    setState(() {
      if (selectedSeats.contains(i)) selectedSeats.remove(i);
      else selectedSeats.add(i);
    });
  }

  void onBook() {
    if (selectedSeats.isEmpty) return;

    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text('예매 확인'),
        content: Text(
            '${widget.departure} → ${widget.arrival} 좌석 ${selectedSeats.map((e) => e).join(', ')}'),
        actions: [
          CupertinoDialogAction(
            child: const Text('취소'),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            child: const Text('확인'),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.departure,
                  style: const TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                const SizedBox(width: 10),
                const Icon(
                  Icons.arrow_circle_right_outlined,
                  size: 30,
                ),
                const SizedBox(width: 10),
                Text(
                  widget.arrival,
                  style: const TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(width:24, height:24, decoration: BoxDecoration(color: Colors.purple, borderRadius: BorderRadius.circular(8))),
                const SizedBox(width:4),
                const Text('선택됨'),
                const SizedBox(width:20),
                Container(width:24, height:24, decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(8))),
                const SizedBox(width:4),
                const Text('선택 안 됨'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 20),
                itemCount: 20,
                itemBuilder: (context, row) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (col) {
                      int seatNum = row * 4 + col + 1;
                      bool isSelected = selectedSeats.contains(seatNum);
                      return GestureDetector(
                        onTap: () => toggleSeat(seatNum),
                        child: Container(
                          width: 50,
                          height: 50,
                          margin: const EdgeInsets.all(2),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.purple : Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text('$seatNum'),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: selectedSeats.isNotEmpty ? onBook : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text(
                  '예매 하기',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
