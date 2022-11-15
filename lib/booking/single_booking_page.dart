import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

class SingleBookingPage extends StatelessWidget {
  final bookingId;
  const SingleBookingPage({@PathParam() required this.bookingId, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text('Single Booking'),
    ));
  }
}