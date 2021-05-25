import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/providers/user_provider/checkin_state_provider.dart';
import 'package:shoppingapp/screens/offline_page/product_scanner.dart';
import 'package:shoppingapp/screens/offline_page/qr_code_checkin.dart';


class CheckInWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return ProviderListener(onChange: (context, checkIn) {
      if (checkIn != null &&
          checkIn.error != null &&
          checkIn.error.isNotEmpty) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                  title: Text('Error'), content: Text(checkIn.error));
            });
      }
    }, provider: checkInStateProvider,
        child: body(context, watch(checkInStateProvider))
    );

  }
  Widget body(context, checkInState){
    return checkInState.isCheck ? ProductScanner() :QRCodeCheckIn();
  }
}

//알림 없을때는 - Icons.notification_none_outlined 있을때는 Icons.Notification_on_outlined