import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sure_move/Logic/BookingLogic/bookingBloc.dart';
import 'package:sure_move/Logic/BookingLogic/bookingState.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/scaffoldMsg.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/Views/Booking/CustomerBooking/Widgets/curvePainter.dart';
import 'package:sure_move/Presentation/Views/Booking/CustomerBooking/Widgets/curveWave.dart';

class RipplesAnimation extends StatefulWidget {
  const RipplesAnimation({Key? key, this.size = 80.0, this.color = kSeaGreen,
    this.onPressed,  this.child,}) : super(key: key);
  final double size;
  final Color color;
  final Widget? child;
  final VoidCallback? onPressed;
  @override
  _RipplesAnimationState createState() => _RipplesAnimationState();
}

class _RipplesAnimationState extends State<RipplesAnimation> with TickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync:this,
      value: 0.1,
      duration: const Duration(milliseconds: 500),

    )..repeat();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  Widget _button() {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.size),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(

              colors: <Color>[
                widget.color,
                Color.lerp(widget.color, Colors.black, .05) as Color
              ],
            ),
          ),
          child: ScaleTransition(
            scale: Tween(begin: 0.95, end: 1.0).animate(
              CurvedAnimation(
                parent: _controller,
                curve: const CurveWave(),
              ),
            ),
            child: SvgPicture.asset('assets/assets/pick_up.svg'),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: WillPopScope(
        onWillPop: () => Future.value(false),
        child: BlocConsumer<BookingBloc, BookingState>(
        listener: (context, state) {

    if(state is BookingSuccess){
    Navigator.pushNamed(context, connectedVendorPage);
    }
    if(state is BookingDenied){
      Navigator.pushNamed(context, displayAmount);

      ScaffoldMsg().errorMsg(context, state.errors[0]);
    }
    if(state is NotFound){
    Navigator.pushNamed(context, customerAwaitingScreen);
    }
    },
    builder: (context, state) {

    return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Container(
                alignment: Alignment.center,
                child: Icon(Icons.speaker_phone, size: 44,color: kOrangeColor,)),

            Center(
              child: CustomPaint(
                painter: CirclePainter(
                  _controller,
                  color: widget.color,
                ),
                child: SizedBox(
                  width: widget.size * 4.125,
                  height: widget.size * 4.125,
                  child: _button(),
                ),
              ),
            ),
          ],
        );
      }),
    ));
  }
}
