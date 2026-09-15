import 'dart:convert';

import 'package:ataa/Data/Model/Gift/Subclass/giftCategory.dart';
import 'package:flutter_test/flutter_test.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this test }}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// Pins the admin-defined `default_amounts` contract on a gift category: the
/// API returns a list of numeric strings when set, or null when the admin left
/// it empty. The model must parse them to ints and yield an empty list for
/// null, so the gift screen can fall back to its default amounts.
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

GiftCategoryX _parse(String json) =>
    GiftCategoryX.fromJson(jsonDecode(json) as Map<String, dynamic>);

void main() {
  group('GiftCategoryX.defaultAmounts', () {
    test('parses a list of numeric strings into ints', () {
      final GiftCategoryX category = _parse('''
      {"id":"a215575d","name":"ترقية وظيفية","status":true,"order":1,
       "default_amounts":["50","100","150"],
       "image":{"url":"https://cdn.example/x.png"}}
      ''');
      expect(category.defaultAmounts, [50, 100, 150]);
    });

    test('yields an empty list when default_amounts is null', () {
      final GiftCategoryX category = _parse('''
      {"id":"b","name":"نجاح","status":true,
       "default_amounts":null,
       "image":{"url":"https://cdn.example/y.png"}}
      ''');
      expect(category.defaultAmounts, isEmpty);
    });

    test('yields an empty list when default_amounts is absent', () {
      final GiftCategoryX category = _parse('''
      {"id":"c","name":"عام","status":true,
       "image":{"url":"https://cdn.example/z.png"}}
      ''');
      expect(category.defaultAmounts, isEmpty);
    });
  });
}
