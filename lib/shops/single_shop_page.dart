import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SingleShopPage extends StatelessWidget {
  final String shopId;

  const SingleShopPage({@PathParam() required this.shopId, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(
      child: Text('Shop ID: $shopId'),
    ));
  }
}
