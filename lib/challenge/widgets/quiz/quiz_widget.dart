import 'package:DevQuiz/challenge/widgets/awnser/awnser_widget.dart';
import 'package:DevQuiz/core/app_text_styles.dart';
import 'package:DevQuiz/shared/models/awnser_model.dart';
import 'package:DevQuiz/shared/models/question_model.dart';
import 'package:flutter/material.dart';

class QuizWidget extends StatefulWidget {
  final QuestionModel question;
  final ValueChanged<bool> onSelected;

  QuizWidget({Key? key, required this.question, required this.onSelected}) : super(key: key);

  @override
  _QuizWidgetState createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  int indexSelected = -1;

  AwnserModel awnser(int index) => widget.question.awnser[index];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.question.title,
          style: AppTextStyles.heading,
        ),
        SizedBox(
          height: 24,
        ),
        for (var i = 0; i < widget.question.awnser.length; i++)
          AwnserWidget(
            awnser: awnser(i),
            disabled: indexSelected != -1,
            isSelected: indexSelected == i,
            onTap: (value) {
              indexSelected = i;
              setState(() {});
              widget.onSelected(value);
            },
          ),
      ],
    );
  }
}
