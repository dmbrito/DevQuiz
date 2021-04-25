import 'package:flutter/foundation.dart';

class ChallengController{
  final currentPageNotifier = ValueNotifier<int>(1);
  int get currentPage => currentPageNotifier.value;
  set currentPage(int value) => currentPageNotifier.value = value;

  int qtdAwnserRight = 0;
}