import 'package:flutter/material.dart';
import 'package:palliative_chat/config/constants.dart';
import 'package:palliative_chat/config/settings.dart';
import 'package:palliative_chat/repository/api.dart';
import 'package:palliative_chat/repository/models/article.dart';

import 'common/buttons.dart';
import 'common/shimmer.dart';
import 'common/texts.dart';

class DirectoryScreen extends StatefulWidget {
  @override
  _DirectoryScreenState createState() => _DirectoryScreenState();
}

class _DirectoryScreenState extends State<DirectoryScreen> {
  bool _surveyComplete;
  bool _surveyResultSubmitting;
  bool _surveyResultSubmitted;
  List<Article> _articles;

/*
  bool eat,
      bool dysphagia,
  bool washTeeth,
      bool wash,
  bool dress,
      bool restroom,
  */
  bool _eat;
  bool _dysphagia;
  bool _washTeeth;
  bool _wash;
  bool _dress;
  bool _restRoom;

  @override
  void initState() {
    Settings().getSurveyComplete().then((value) {
      setState(() => _surveyComplete = value);
    });

    // todo take
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Texts.appBarTitle('Справка'),
      ),
      body: _content(),
    );
  }

  Widget _content() {
    if (_surveyComplete == null) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: AppPadding.allNormal,
                  child: Shimmer(),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: AppPadding.allNormal,
                  child: Shimmer(),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: AppPadding.allNormal,
                  child: Shimmer(),
                ),
              ),
            ],
          ),
        ],
      );
    }

    if (!_surveyComplete) {
      return _surveyContent();
    }

    return _dataContent();
  }

  Widget _surveyContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: AppPadding.allNormal,
            child: Texts(
              'Пройдите короткий опрос о состоянии больного.',
              textSize: AppSize.fontNormalBig,
              fontWeight: FontWeight.w600,
            ),
          ),
          _question(
            title: '1. Mожет ли сам есть?',
            selectedPositive: _eat == true,
            selectedNegative: _eat == false,
            onNegativeSelected: () => setState(() => _eat = false),
            onPositiveSelected: () => setState(() => _eat = true),
          ),
          _question(
            title:
                '2. Есть ли проблемы с глотанием? Поперхивается ли он, может ли пить воду?',
            selectedPositive: _dysphagia == true,
            selectedNegative: _dysphagia == false,
            onNegativeSelected: () => setState(() => _dysphagia = false),
            onPositiveSelected: () => setState(() => _dysphagia = true),
          ),
          _question(
            title: '3. Может ли умыться сам, почистить зубы, протереть лицо?',
            selectedPositive: _washTeeth == true,
            selectedNegative: _washTeeth == false,
            onNegativeSelected: () => setState(() => _washTeeth = false),
            onPositiveSelected: () => setState(() => _washTeeth = true),
          ),
          _question(
            title: '4. Может ли одеться сам?',
            selectedPositive: _dress == true,
            selectedNegative: _dress == false,
            onNegativeSelected: () => setState(() => _dress = false),
            onPositiveSelected: () => setState(() => _dress = true),
          ),
          _question(
            title: '5. Может ли помыться сам?',
            selectedPositive: _wash == true,
            selectedNegative: _wash == false,
            onNegativeSelected: () => setState(() => _wash = false),
            onPositiveSelected: () => setState(() => _wash = true),
          ),
          Padding(
            padding: AppPadding.horizontalNormal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Texts.normalSemiBold(
                  '6. Может ли сам ходить в туалет',
                ),
                Padding(
                  padding: AppPadding.topSmall,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Buttons(
                        text: 'Сам ходит до туалета и помощь не нужна',
                        onPressed: () => setState(() => _restRoom = false),
                        buttonColor: _restRoom == false
                            ? Colors.green[200]
                            : AppColors.greyLight,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Buttons(
                        text: 'Нужна помощь в личной гигиене',
                        onPressed: () => setState(() => _restRoom = true),
                        buttonColor: _restRoom == true
                            ? Colors.red[200]
                            : AppColors.greyLight,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Buttons(
                        text: 'Использует подгузник',
                        onPressed: () => setState(() => _restRoom = true),
                        buttonColor: _restRoom == true
                            ? Colors.red[200]
                            : AppColors.greyLight,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: AppPadding.topHuge,
          ),
          if (_allQuestionsAnswered())
            Padding(
              padding: AppPadding.horizontalNormal,
              child: Buttons(
                buttonColor: AppColors.greyLight,
                text: 'Готово',
                onPressed: () async {
                  setState(() {
                    _surveyResultSubmitting = true;
                  });

                  await Future.delayed(Duration(seconds: 2));

                  /* await Api().sendSurveyResult(
                    eat: _eat,
                    dress: _dress,
                    wash: _wash,
                    washTeeth: _washTeeth,
                    restroom: _restRoom,
                    dysphagia: _dysphagia,
                  );*/

                  setState(() {
                    _surveyResultSubmitting = false;
                    _surveyResultSubmitted = true;
                  });

                  _articles = await api.getArticlesForUser(1);
                },
              ),
            ),
          Padding(
            padding: AppPadding.topBig,
          ),
        ],
      ),
    );
  }

  Widget _dataContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text('Статьи, подходящие именно вам'),
        ],
      ),
    );
  }

  Widget _question({
    String title,
    bool selectedPositive,
    bool selectedNegative,
    VoidCallback onPositiveSelected,
    VoidCallback onNegativeSelected,
  }) {
    return Padding(
      padding: AppPadding.horizontalNormal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Texts.normalSemiBold(title),
          Padding(
            padding: AppPadding.topSmall,
          ),
          Row(
            children: [
              Expanded(
                child: Buttons(
                  text: 'Да',
                  onPressed: onPositiveSelected,
                  buttonColor: selectedPositive
                      ? Colors.green[200]
                      : AppColors.greyLight,
                ),
              ),
              Padding(
                padding: AppPadding.horizontalSmall,
              ),
              Expanded(
                child: Buttons(
                  text: 'Нет',
                  onPressed: onNegativeSelected,
                  buttonColor:
                      selectedNegative ? Colors.red[200] : AppColors.greyLight,
                ),
              ),
            ],
          ),
          Padding(
            padding: AppPadding.topBig,
          )
        ],
      ),
    );
  }

  bool _allQuestionsAnswered() {
    return _eat != null &&
        _dysphagia != null &&
        _washTeeth != null &&
        _wash != null &&
        _dress != null &&
        _restRoom != null;
  }
}
