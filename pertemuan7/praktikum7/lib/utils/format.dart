import 'package:intl/intl.dart';

String tanggalKey(DateTime tanggal) {
  return DateFormat('yyyy-MM-dd').format(tanggal);
}

String formatTanggal(DateTime tanggal) {
  return DateFormat('EEEE, d MMM yyyy', 'id_ID').format(tanggal);
}

String rupiah(int nominal) {
  return NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  ).format(nominal);
}
