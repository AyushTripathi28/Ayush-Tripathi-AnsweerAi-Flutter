class InitialQuestions {
  final String initialQuestions;
  final String initialQuestionsTitle;
  final String initialQuestionsSubtitle;

  InitialQuestions({
    required this.initialQuestions,
    required this.initialQuestionsTitle,
    required this.initialQuestionsSubtitle,
  });

  //convert message to map
  Map<String, dynamic> toMap() {
    return {
      'initialQuestions': initialQuestions,
      'initialQuestionsTitle': initialQuestionsTitle,
      'initialQuestionsSubtitle': initialQuestionsSubtitle,
    };
  }
}

List<InitialQuestions> initialQuestionsList = [
  InitialQuestions(
    initialQuestions: "Create a workout plan for resistance training",
    initialQuestionsTitle: "Create a workout plan",
    initialQuestionsSubtitle: "for resistance training",
  ),
  InitialQuestions(
    initialQuestions: "Give me tips to overcome procrastination",
    initialQuestionsTitle: "Give me tips",
    initialQuestionsSubtitle: "to overcome procrastination",
  ),
  InitialQuestions(
    initialQuestions:
        "Make up a story about Sharky, a tooth-brushing shark superhero",
    initialQuestionsTitle: "Make up a story",
    initialQuestionsSubtitle: "about Sharky, a tooth-brushing shark superhero",
  )
];
