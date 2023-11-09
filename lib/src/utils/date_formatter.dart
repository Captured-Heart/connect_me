// import 'package:intl/intl.dart';
import 'package:connect_me/app.dart';
import 'package:timeago/timeago.dart' as timeago;

String dateFormatted() {
  var now = DateTime.now();

  var formatter = DateFormat("EEE, d MMMM, yyyy");
  return formatter.format(now);
}

String dateSubtractFormat(DateTime date) {
  var now = DateTime.now();
  var daysDifference = now.difference(date).inDays;
  if (daysDifference > 31) {
    return dateFormatted2(date);
  } else {
    return timeago.format(date);
  }
}

String dateFormatted2(DateTime? dateTime) {
  var now = dateTime;

  var formatter = DateFormat("d MMMM, yyyy");

  return formatter.format(now ?? DateTime.now());
}

String dateFormatted3(DateTime? dateTime) {
  var now = dateTime;

  var formatter = DateFormat("d MMM, yy");

  return formatter.format(now ?? DateTime.now());
}

String dateFormattedWithSlash(DateTime dateTime) {
  final now = dateTime;

  final formatter = DateFormat('dd/MM/yyyy');
  final formatted = formatter.format(now);

  return formatted;
}

String timeFormatted(TimeOfDay time) {
  var now = DateTime.now();

  var formatter = DateTime(now.year, now.month, now.day, time.hour, time.minute);
  return DateFormat().add_jm().format(formatter);
}

String timeAgoFormatted(DateTime date, {required String? locale}) {
  return timeago.format(
    date,
    locale: locale ?? 'en',
  );
}
