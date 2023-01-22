import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class BookingsPage extends StatelessWidget {
  const BookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, bookingId) => ListTile(
          title: TextButton(
            onPressed: () {
              // context.router.push(SingleBookingRoute(bookingId: bookingId));
            },
            child: Text('Booking ID - $bookingId'),
          ),
        ),
      ),
    );
  }
}

/**
 
const _paymentItems = [
  PaymentItem(
    label: 'Total',
    amount: '99.99',
    status: PaymentItemStatus.final_price,
  )
];
 */

/**
  ApplePayButton(
            paymentConfigurationAsset:
                'payment/default_payment_profile_apple_pay.json',
            onPaymentResult: print,
            paymentItems: _paymentItems,
            childOnError: const Text('Payment button could not be loaded'),
          ),
          GooglePayButton(
            paymentConfigurationAsset:
                'payment/default_payment_profile_google_pay.json',
            onPaymentResult: print,
            paymentItems: _paymentItems,
            childOnError: const Text('Payment button could not be loaded'),
          ),
 */