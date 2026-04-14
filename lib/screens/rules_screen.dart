import 'package:flutter/material.dart';

class RulesScreen extends StatelessWidget {
  const RulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text('Learning Guidelines 📜', style: TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFFFF6B2B),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _ruleCard(
            icon: Icons.directions_run,
            iconColor: const Color(0xFF00C9A7),
            title: '🏃 Learning Steps',
            rules: [
              'Read one cultural topic daily',
              'Listen to the audio pronunciations carefully',
              'Take quizzes to test your knowledge',
              'Explore different festivals and traditions',
            ],
          ),
          const SizedBox(height: 14),
          _ruleCard(
            icon: Icons.favorite,
            iconColor: Colors.red,
            title: '❤️ Safety First',
            rules: [
              'Always warm up before starting any session',
              'Keep your back straight to avoid strain',
              'Stay hydrated during practice',
              'Never push through pain — rest if needed',
            ],
          ),
          const SizedBox(height: 14),
          _ruleCard(
            icon: Icons.auto_awesome,
            iconColor: Colors.amber,
            title: '🙏 Cultural Respect',
            rules: [
              'Respect the traditions and your Guru',
              'Wear appropriate practice costume',
              'Understand the stories behind the art',
              'Practice with dedication and humility',
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF6B2B),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text('Back to Home 🏠', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _ruleCard(
      {required IconData icon, required Color iconColor, required String title, required List<String> rules}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.09), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: iconColor.withOpacity(0.12), shape: BoxShape.circle),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 12),
            Text(title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF2C3E50))),
          ]),
          const SizedBox(height: 14),
          ...rules.map((rule) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Icon(Icons.circle, size: 7, color: iconColor),
                    const SizedBox(width: 10),
                    Expanded(child: Text(rule, style: const TextStyle(fontSize: 14, color: Color(0xFF4A5568)))),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
