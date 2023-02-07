import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sure_move/Logic/BookingLogic/bookingBloc.dart';
import 'package:sure_move/Logic/BookingLogic/bookingCollectionData.dart';
import 'package:sure_move/Logic/BookingLogic/bookingEvent.dart';
import 'package:sure_move/Logic/BookingLogic/bookingState.dart';
import 'package:sure_move/Logic/sharedPreference.dart';
import 'package:sure_move/Models/userModel.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/scaffoldMsg.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/Views/Booking/CustomerBooking/Widgets/curvePainter.dart';
import 'package:sure_move/Presentation/Views/Booking/CustomerBooking/Widgets/curveWave.dart';
import 'package:sure_move/Providers/userProvider.dart';

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
  var result;
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
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    //getDriver();
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
            child: SvgPicture.asset('assets/pick_up.svg'),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    NewUser user = Provider.of<UserProvider>(context).user;
    return Scaffold(

      body: BlocConsumer<BookingBloc, BookingState>(
      listener: (context, state) {

    if(state is BookingSuccess){
   Navigator.pushNamedAndRemoveUntil(context, connectedVendorPage, (route) => false);
    }
     if(state is PaymentSuccessful){
       BlocProvider.of<BookingBloc>(context).add(MatchADriverRequested(
       "${user.firstName} ${user.lastName}",
       user.phoneNumber,
       context,
       user.email!,
       user.firstName!,
       user.lastName!,
       BookingCollections.bookingDetails[0].amount,
       ));
     }
    if(state is BookingDenied){
       Navigator.pushReplacementNamed(context, displayAmount);
      ScaffoldMsg().errorMsg(context, state.errors[0]);

    }
    if(state is NotFound){
      Navigator.pushNamedAndRemoveUntil(context, customerAwaitingScreen, (route) => false);

    }
    },
    builder: (context, state) {

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          GestureDetector(
            onTap: (){Navigator.pushReplacementNamed(context, displayAmount);},
            child: Container(
                alignment: Alignment.center,
                child: Icon(Icons.speaker_phone, size: 44,color: kOrangeColor,)),
          ),

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
      }));
  }
}
