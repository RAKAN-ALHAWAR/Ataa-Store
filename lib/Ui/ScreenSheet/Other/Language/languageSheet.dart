import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import '../../../../Config/Translation/translation.dart';
import '../../../../Data/data.dart';
import '../../../Widget/widget.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this bottom sheet }}~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// Choose one of the languages available for the application
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

languageSheetX(Function(String val) changeLanguage) {
  return bottomSheetX(
    title: 'Language',
    child: Column(
      /// Fetch available languages
      children: TranslationX.languages.map(
        (Map<String, String> language) {
          return InkWell(
            /// Run the language change function
            onTap: () async {
              await changeLanguage(language[NameX.code]!);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.maxFinite,

                /// Display language name
                child: TextX(
                  language[NameX.name]!,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ).fadeAnimation200;
        },
      ).toList(),
    ),
  );
}
