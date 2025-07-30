part of '../data.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this section }}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// API Config
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

class ApiConfigX {
  static String contentType = 'application/json';
  static String accept = 'application/json';
  static String authorizationType = 'Bearer';
  static String authorizationTypeKey = 'Authorization';
  static int timeout = 10;
  static int maxRetries = 1;
  static String localeKey = 'locale';
  static String errorMessageKey = 'message';
  static String checkInternetAddress = 'one.one.one.one';
}