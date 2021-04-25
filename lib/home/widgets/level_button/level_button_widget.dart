import 'package:DevQuiz/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LevelButtonWidget extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final String currentLevel;


  LevelButtonWidget({
    Key? key,
    required this.label,
    required this.currentLevel,
    required this.onTap,
  })   : assert(["Fácil", "Médio", "Difícil", "Perito"].contains(label)),
        super(key: key);

  final config = {
    "Fácil": {
      "color": AppColors.levelButtonFacil,
      "borderColor": AppColors.levelButtonBorderFacil,
      "fontColor": AppColors.levelButtonTextFacil,

    },
    "Médio": {
      "color": AppColors.levelButtonMedio,
      "borderColor": AppColors.levelButtonBorderMedio,
      "fontColor": AppColors.levelButtonTextMedio,

    },
    "Difícil": {
      "color": AppColors.levelButtonDificil,
      "borderColor": AppColors.levelButtonBorderDificil,
      "fontColor": AppColors.levelButtonTextDificil,

    },
    "Perito": {
      "color": AppColors.levelButtonPerito,
      "borderColor": AppColors.levelButtonBorderPerito,
      "fontColor": AppColors.levelButtonTextPerito,
    }
  };

  bool get isLevelSelectd{
    bool result;

    switch (currentLevel){
      case "facil": {result = (label == "Fácil");} break;
      case "medio": {result = (label == "Médio");} break;
      case "dificil": {result = (label == "Difícil");} break;
      case "perito": {result = (label == "Perito");} break;
      default: {result = false;} break;
    }

    return result;
  }

  Color get getColor => config[label]!["color"]!;
  Color get getBorderColor => config[label]!["borderColor"]!;
  Color get getFontColor => config[label]!["fontColor"]!;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: getColor,
          border: Border.fromBorderSide(
            BorderSide(
              color: getBorderColor,
            ),
          ),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: isLevelSelectd ? Colors.purple : Colors.transparent,
              blurRadius: 5,
              spreadRadius: .1
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 6),
          child: Text(
            label,
            style: GoogleFonts.notoSans(
              color: getFontColor,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}
