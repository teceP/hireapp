import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class ShopPage extends StatelessWidget {
  final String shopId;

  const ShopPage({@PathParam() required this.shopId, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const AutoLeadingButton()),
      body: Center(
        child: Text('Shop ID: $shopId'),
      ),
    );
  }
}
