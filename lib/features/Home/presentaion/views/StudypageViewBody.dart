import 'package:flutter/material.dart';
import '../widgets/FlipCardListView.dart';
import 'AddFlashcardPage.dart';

class StudypageViewBody extends StatelessWidget {
  const StudypageViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Study",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [

            const SizedBox(height: 6),
            const SizedBox(height: 20),
            const FlipCardListView(),
            const SizedBox(height: 10),



            const SizedBox(height: 20),

            ElevatedButton.icon(
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              label: const Text("Add Flashcard"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1DA1F2),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 8,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddFlashcardPage()),
                );
              },
            ),

            const SizedBox(height: 55),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.info_outline, color: Colors.blue),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Long-press a flashcard to edit or delete it.",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),

    );
  }
}
