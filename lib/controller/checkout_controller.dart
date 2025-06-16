import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  RxSet<int> selectedSegment = <int>{0}.obs;
  Rx<TimeOfDay?> selectedTime = Rx<TimeOfDay?>(null);
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  //this refer from this year
  final Rx<DateTime> _firstDate = Rx<DateTime>(DateTime(DateTime.now().year));
  // this refer to next one year enable
  final Rx<DateTime> _lastDate =
      Rx<DateTime>(DateTime(DateTime.now().year + 1));

  void onSegmentSelected(Set<int> segmentIdex) {
    selectedSegment
      ..clear()
      ..addAll(segmentIdex);
  }

  void selectTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.input,
      initialTime: selectedTime.value ?? TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!);
      },
    );
    if (picked != null && picked != selectedTime.value) {
      selectedTime.value = picked;
    }
  }

  void selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: _firstDate.value,
      lastDate: _lastDate.value,
      initialDate: selectedDate.value ?? DateTime.now(),
    );
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
    }
  }
}
