import 'dart:io';
import 'dart:typed_data';

import 'package:DevQuiz/challenge/widgets/next_button/next_button_widget.dart';
import 'package:DevQuiz/core/app_images.dart';
import 'package:DevQuiz/core/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import 'package:path_provider/path_provider.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

class ResultPage extends StatelessWidget {
  final String title;
  final int length;
  final int result;

  static GlobalKey previewContainer = new GlobalKey();
  File? imgFile;
  List<String> listPaths = [];


  ResultPage({
    required this.title,
    required this.length,
    required this.result,
  });

  Future takeScreenShot() async{
    RenderRepaintBoundary? boundary = previewContainer.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    final directory = (await getApplicationDocumentsDirectory()).path;
    ByteData byteData = (await image.toByteData(format: ui.ImageByteFormat.png))!;
    Uint8List pngBytes = byteData.buffer.asUint8List();
    print(pngBytes);
    imgFile = new File('$directory/screenshot.png');
    imgFile!.writeAsBytes(pngBytes);

    listPaths.add(imgFile!.path.toString());
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: previewContainer,
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(top: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(AppImages.trophy),
              Column(
                children: [
                  Text(
                    "Parabéns!",
                    style: AppTextStyles.heading40,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text.rich(
                      TextSpan(
                          text: "Você concluiu\n",
                          style: AppTextStyles.body,
                          children: [
                            TextSpan(
                              text: title,
                              style: AppTextStyles.bodyBold,
                            ),
                            TextSpan(
                              text: '\ncom $result de $length acertos.',
                              style: AppTextStyles.body,
                            ),
                          ]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 100,
                    child: NextButtonWidget.purple(
                        label: "Compartilhar",
                        onTap: () {

                          takeScreenShot().then((value) => Share.shareFiles(listPaths)
                          );


                         /*Share.share("DevQuiz NLW 5 - Flutter: Resultado do quiz $title:\n"
                             "$result acertos de $length (${result / length}% de aproveitamento) ");*/
                        }),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 100,
                    child: NextButtonWidget.white(
                        label: "Voltar ao início",
                        onTap: () {
                          Navigator.pop(context);
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
