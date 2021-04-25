import 'package:DevQuiz/challenge/challenge_page.dart';
import 'package:DevQuiz/challenge/widgets/quiz/quiz_widget.dart';
import 'package:DevQuiz/core/app_colors.dart';
import 'package:DevQuiz/home/home_controller.dart';
import 'package:DevQuiz/home/home_state.dart';
import 'package:DevQuiz/home/widgets/appbar/app_bar_widget.dart';
import 'package:DevQuiz/home/widgets/level_button/level_button_widget.dart';
import 'package:DevQuiz/home/widgets/quiz_card/quiz_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

enum Level { facil, medio, dificil, perito }

extension LevelExt on Level {
  String get parse =>
      {
        Level.facil: "facil",
        Level.medio: "medio",
        Level.dificil: "dificil",
        Level.perito: "perito"
      }[this]!;
}

extension LevelStrinExt on String {
  Level get parse =>
      {
        "facil": Level.facil,
        "medio": Level.medio,
        "dificil": Level.dificil,
        "perito": Level.perito
      }[this]!;
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();
  String curLevel = "facil";

  @override
  void initState() {
    super.initState();
    controller.getUser();
    controller.getQuizzes();
    controller.stateNotifier.addListener(() {
      setState(() {});
    });
    controller.currentLevelNotifier.addListener(() {
      controller.currentLevel = curLevel;
    });
  }

  setNewLevel(String newLevel) {
    setState(() {
      curLevel = newLevel;
    });
  }

  Widget _getQuiz() {
    List<Widget> _list = [];

    controller.quizzes.forEach((e) {
      if (curLevel.parse.toString() == e.level.toString()) {
        _list.add(QuizCardWidget(
          title: e.title,
          completed:
          "${e.questionAwnsered} de ${e.questions.length} ",
          percent:
          e.questionAwnsered / e.questions.length,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ChallengePage(
                        questions: e.questions,
                        title: e.title,
                      ),
                ));
          },
        ));
      }
    });

    return GridView.count(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      crossAxisCount: 2,
      children: _list,
    );
  }

  @override
  Widget build(BuildContext context) {
    return (controller.state == HomeState.success)
        ? Scaffold(
      appBar: AppBarWidget(user: controller.user!),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    LevelButtonWidget(
                      label: "Fácil",
                      currentLevel: curLevel,
                      onTap: () =>
                          setState(() {
                            curLevel = "facil";
                          }),
                    ),
                    SizedBox(width: 8),
                    LevelButtonWidget(
                      label: "Médio",
                      currentLevel: curLevel,
                      onTap: () =>
                          setState(() {
                            curLevel = "medio";
                          }),
                    ),
                    SizedBox(width: 8),
                    LevelButtonWidget(
                      label: "Difícil",
                      currentLevel: curLevel,
                      onTap: () =>
                          setState(() {
                            curLevel = "dificil";
                          }),
                    ),
                    SizedBox(width: 8),
                    LevelButtonWidget(
                      label: "Perito",
                      currentLevel: curLevel,
                      onTap: () =>
                          setState(() {
                            curLevel = "perito";
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Expanded(
            child: ValueListenableBuilder<String>(
              valueListenable: controller.currentLevelNotifier,
              builder: (context, value, _) => _getQuiz(),
            ),
          ),
        ],
      ),
    )
        : Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.darkGreen),
        ),
      ),
    );
  }
}
