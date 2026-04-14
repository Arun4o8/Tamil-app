import 'package:flutter/material.dart';

class CelebrationItem {
  final String name;
  final String type;
  final String emoji;
  final String description;
  final Color color;
  final String assetFolder;

  const CelebrationItem({
    required this.name,
    required this.type,
    required this.emoji,
    required this.description,
    required this.color,
    required this.assetFolder,
  });
}

const List<CelebrationItem> allCelebrations = [
  CelebrationItem(
    name: 'Bhogi',
    type: 'Winter Solstice',
    emoji: '🔥',
    assetFolder: 'bhogi',
    color: Color(0xFFFF6F00),
    description:
        'Bhogi is the first day of the Pongal festival, celebrated on the last day of the Tamil month of Margazhi. It is a day of discarding old things and welcoming new beginnings. Bonfires are lit in the morning to burn old items and household waste.',
  ),
  CelebrationItem(
    name: 'Thaipongal',
    type: 'Harvest Festival',
    emoji: '🌾',
    assetFolder: 'thaipongal',
    color: Color(0xFFFDD835),
    description:
        'Thaipongal is the main day of the four-day Pongal festival. It is a harvest festival celebrated on the first day of the Tamil month Thai. The sweet rice dish called Pongal is prepared as an offering to the Sun God (Surya).',
  ),
  CelebrationItem(
    name: 'Mattu Pongal',
    type: 'Cattle Thanksgiving',
    emoji: '🐄',
    assetFolder: 'mattupongal',
    color: Color(0xFF00897B),
    description:
        'Mattu Pongal is celebrated on the third day of Pongal. It is a day dedicated to cattle, which are worshipped for their contribution to the agricultural community. Cows and bullocks are bathed, decorated with paint and garlands, and fed Pongal.',
  ),
  CelebrationItem(
    name: 'Kaanum Pongal',
    type: 'Family Reunion',
    emoji: '👨‍👩‍👧‍👦',
    assetFolder: 'kaanumpongal',
    color: Color(0xFF3949AB),
    description:
        'Kaanum Pongal is the fourth and final day of the Pongal festival. "Kaanum" means "to see" in Tamil. It is a day for family outings, visiting relatives, and spending time together. Young people seek blessings from their elders.',
  ),
  CelebrationItem(
    name: 'Deepavali',
    type: 'Festival of Lights',
    emoji: '🪔',
    assetFolder: 'deepavali',
    color: Color(0xFFF57F17),
    description:
        'Deepavali (Diwali) is the festival of lights celebrated by Tamils and people across India. It signifies the victory of light over darkness and good over evil. Homes are lit with oil lamps and fireworks fill the sky in celebration.',
  ),
  CelebrationItem(
    name: 'Aadi Pattam',
    type: 'Monsoon Gateway',
    emoji: '🌧️',
    assetFolder: 'aadipattam',
    color: Color(0xFF1565C0),
    description:
        'Aadi Pattam marks the beginning of the Tamil month of Aadi, which coincides with the beginning of the monsoon season in Tamil Nadu. It is considered an auspicious time, and special prayers and offerings are made to deities at temples.',
  ),
];
