import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart' show Orders;
import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  // for stateful state.......... this can be done but the below code is alternative to this
  // so we dont have to convert to stateful
  // var _isLoading = false;
  // @override
  // void initState() {
  //   // Future.delayed(Duration.zero).then((_) async {
  //   //   setState(() {
  //   //     _isLoading = true;
  //   //   });
  //   //   await Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  //   //   setState(() {
  //   //     _isLoading = false;
  //   //   });
  //   // });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      drawer: AppDrawer(),
      // body: _isLoading
      //     ? Center(
      //         child: CircularProgressIndicator(),
      //       )
      //     : ListView.builder(
      //         itemCount: orderData.orders.length,
      //         itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
      //       ),

      //alternative way using FutureBuilder
      // remove the orderData listner cause it causes infinite loop
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.error != null) {
              // .. handle error
              return Center(
                child: Text('An error occured!'),
              );
            }
            return Consumer<Orders>(
              builder: (ctx, orderData, child) => ListView.builder(
                itemCount: orderData.orders.length,
                itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
              ),
            );
          }
        },
      ),
      // ........
    );
  }
}
