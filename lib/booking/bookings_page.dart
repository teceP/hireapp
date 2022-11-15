import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class BookingsPage extends StatelessWidget {
  const BookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, bookingId) => TextButton(
          onPressed: () {
           // context.router.push(SingleBookingRoute(bookingId: bookingId));
          },
          child: Text('Booking ID - $bookingId'),
        ),
      ));
  }
}
