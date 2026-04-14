class QuizQuestion {
  final String question;
  final List<String> options;
  final int answerIndex;
  final String topic;

  const QuizQuestion({
    required this.question,
    required this.options,
    required this.answerIndex,
    required this.topic,
  });
}

const List<QuizQuestion> quizQuestions = [
  // Arts & Dances
  QuizQuestion(
    question: 'Which dance is performed with a pot balanced on the head?',
    options: ['Oyillattam', 'Karakattam', 'Mayil Aattam'],
    answerIndex: 1,
    topic: 'Arts & Dances',
  ),
  QuizQuestion(
    question: 'What is the primary instrument used in Silambattam?',
    options: ['Bamboo Staff', 'Sword', 'Short Stick'],
    answerIndex: 0,
    topic: 'Arts & Dances',
  ),
  QuizQuestion(
    question: 'Which dance involves dummy horses?',
    options: ['Poikkal Kuthirai', 'Puliyattam', 'Kavadi Attam'],
    answerIndex: 0,
    topic: 'Arts & Dances',
  ),
  QuizQuestion(
    question: 'Which art form uses puppets to tell stories?',
    options: ['Villu Paatu', 'Therukoothu', 'Bommalattam'],
    answerIndex: 2,
    topic: 'Arts & Dances',
  ),
  QuizQuestion(
    question: 'Which dance is performed in honor of Lord Murugan?',
    options: ['Kavadi Attam', 'Devaraattam', 'Kummi'],
    answerIndex: 0,
    topic: 'Arts & Dances',
  ),
  QuizQuestion(
    question: 'Which classical dance form originated in Tamil Nadu?',
    options: ['Kathak', 'Bharatanatyam', 'Kuchipudi'],
    answerIndex: 1,
    topic: 'Arts & Dances',
  ),
  QuizQuestion(
    question: 'What is the popular traditional street theatre of Tamil Nadu?',
    options: ['Villu Paatu', 'Therukoothu', 'Silambattam'],
    answerIndex: 1,
    topic: 'Arts & Dances',
  ),
  QuizQuestion(
    question: 'Which traditional music instrument is closely associated with Carnatic music and Goddess Saraswati?',
    options: ['Veena', 'Tabla', 'Sitar'],
    answerIndex: 0,
    topic: 'Arts & Dances',
  ),

  // Festivals & Food
  QuizQuestion(
    question: 'What is the traditional Tamil harvest festival called?',
    options: ['Deepavali', 'Pongal', 'Karthigai Deepam'],
    answerIndex: 1,
    topic: 'Festivals & Food',
  ),
  QuizQuestion(
    question: 'Which special dish is traditionally cooked in earthen pots outdoors during Thai Pongal?',
    options: ['Payasam', 'Sakkarai Pongal', 'Kesari'],
    answerIndex: 1,
    topic: 'Festivals & Food',
  ),
  QuizQuestion(
    question: 'During which festival are homes commonly decorated with glowing earthen lamps (Diyas)?',
    options: ['Navaratri', 'Deepavali', 'Karthigai Deepam'],
    answerIndex: 2,
    topic: 'Festivals & Food',
  ),
  QuizQuestion(
    question: 'What is the traditional new year of the Tamil calendar known as?',
    options: ['Puthandu', 'Onam', 'Ugadi'],
    answerIndex: 0,
    topic: 'Festivals & Food',
  ),
  QuizQuestion(
    question: 'Which spicy soup-like dish is considered a staple in Tamil cuisine?',
    options: ['Sambar', 'Rasam', 'Kuzhambu'],
    answerIndex: 1,
    topic: 'Festivals & Food',
  ),

  // History & Literature
  QuizQuestion(
    question: 'Who is the author of the ancient Tamil text "Tirukkural"?',
    options: ['Bharathiar', 'Avvaiyar', 'Thiruvalluvar'],
    answerIndex: 2,
    topic: 'History & Literature',
  ),
  QuizQuestion(
    question: 'Which Tamil empire built the famous Brihadisvara Temple at Thanjavur?',
    options: ['Chola Empire', 'Pandya Empire', 'Pallava Empire'],
    answerIndex: 0,
    topic: 'History & Literature',
  ),
  QuizQuestion(
    question: 'Which ancient Tamil grammar work is the oldest surviving Tamil literature?',
    options: ['Silappatikaram', 'Tolkappiyam', 'Manimekalai'],
    answerIndex: 1,
    topic: 'History & Literature',
  ),
  QuizQuestion(
    question: 'Which ancient city was the capital of the Pandya dynasty?',
    options: ['Madurai', 'Kanchipuram', 'Thanjavur'],
    answerIndex: 0,
    topic: 'History & Literature',
  ),
  QuizQuestion(
    question: 'Who is known as Mahakavi, a pioneer of modern Tamil poetry?',
    options: ['Subramania Bharathi', 'Kambar', 'Avvaiyar'],
    answerIndex: 0,
    topic: 'History & Literature',
  ),
];
