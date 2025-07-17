import 'package:flutter/material.dart';

import '../widgets/CustomButton.dart';
import '../widgets/home_app_bar.dart';
import 'AddFlashcardPage.dart';
import 'StudyPage.dart';

class HomePageViewBody extends StatelessWidget {
  const HomePageViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Ready to Learn?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26)),
            const SizedBox(height: 12),
            const Text(
              "Start studying or manage your flashcards",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 32),
            CustomButton(
              text: "Start Studying",
              color: const Color(0xFF1DA1F2),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const StudyPage()));
              },
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: "Add Flashcards",
              color: Colors.blueGrey,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const AddFlashcardPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
