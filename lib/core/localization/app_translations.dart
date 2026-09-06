import 'package:triosuite_invoice_erp/generated/intl/messages_ar.dart'
    as arabic_messages;
import 'package:triosuite_invoice_erp/generated/intl/messages_en.dart'
    as english_messages;

/// Provides locale-specific ARB messages to code that has no [BuildContext].
///
/// Widgets should continue to use `S.of(context)`. Exporters, repositories,
/// and background services can use this adapter without duplicating translated
/// text in Dart or changing the process-wide `Intl.defaultLocale`.
final class AppTranslations {
  const AppTranslations({required this.isArabic});

  final bool isArabic;

  String call(String key, [List<Object?> arguments = const []]) {
    final messages = isArabic
        ? arabic_messages.messages.messages
        : english_messages.messages.messages;
    final message = messages[key];
    if (message == null) {
      throw ArgumentError.value(key, 'key', 'Missing ARB translation');
    }
    return Function.apply(message, arguments) as String;
  }
}
