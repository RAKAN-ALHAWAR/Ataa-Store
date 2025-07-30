import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as dom;

class HtmlX{
  static String convertToPlainText(String htmlString) {
    // قم بتحليل الـ HTML إلى شجرة DOM
    dom.Document document = html_parser.parse(htmlString);

    // استخراج النص من شجرة الـ DOM
    String plainText = document.body?.text ?? '';

    return plainText;
  }
}