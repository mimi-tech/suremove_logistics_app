import 'package:flutter/material.dart';
import 'package:sure_move/Presentation/Views/Admin/DrawerComponents/Bookings/transit.dart';
import 'package:sure_move/Presentation/Views/Admin/DrawerComponents/Bookings/cancelledBooking.dart';

class AdminBookingTab extends StatefulWidget {
  const AdminBookingTab({Key? key}) : super(key: key);

  @override
  State<AdminBookingTab> createState() => _AdminBookingTabState();
}

class _AdminBookingTabState extends State<AdminBookingTab>with TickerProviderStateMixin  {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  static const List<Tab> _tabs = [
    Tab(child:Text("In transit")),
    Tab(child:Text("Awaiting booking")),
    Tab(child:Text("Cancelled booking")),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
            isScrollable: true,
            controller: _tabController,
            tabs:_tabs
        ),
        title: Row(
          children: [
            Flexible(child:  Text("Booking".toUpperCase())),

          ],
        ),

      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          BookingInTransit(),
          BookingInTransit(),
          CancelledBooking(),
        ],
      ),


    );
  }
}
