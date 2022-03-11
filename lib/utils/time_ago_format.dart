import 'package:timeago/timeago.dart' as timeago;

class ZhCustomMessages implements timeago.LookupMessages {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => '刚刚';
  @override
  String aboutAMinute(int minutes) => '$minutes分钟前';
  @override
  String minutes(int minutes) => '$minutes分钟前';
  @override
  String aboutAnHour(int minutes) => '1小时';
  @override
  String hours(int hours) => '$hours小时前';
  @override
  String aDay(int hours) => '1天';
  @override
  String days(int days) => '$days天前';
  @override
  String aboutAMonth(int days) => '1个月';
  @override
  String months(int months) => '$months个月前';
  @override
  String aboutAYear(int year) => '$year年前';
  @override
  String years(int years) => '$years年前';
  @override
  String wordSeparator() => ' ';
}
