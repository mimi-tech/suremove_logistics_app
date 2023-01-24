import 'package:flutter/material.dart';
import 'package:sure_move/Logic/BookingLogic/bookingBloc.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/scaffoldMsg.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/Views/Authentication/validation.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';
import 'package:sure_move/Presentation/utils/logo.dart';
class ReasonToCancelBooking extends StatefulWidget {
  const ReasonToCancelBooking({Key? key}) : super(key: key);

  @override
  State<ReasonToCancelBooking> createState() => _ReasonToCancelBookingState();
}

class _ReasonToCancelBookingState extends State<ReasonToCancelBooking> {
  Color btnColor = kTextFieldBorderColor;
  final TextEditingController _message = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? message;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: kMargin),
          child: Column(
              children: [
                space(),
                const  LogoDesign(),
                space(),
                const Text(kCancelHeading),

                Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      spacing(),

                      TextFormField(
                        controller: _message,
                        autocorrect: true,
                        autofocus: true,
                        cursorColor: (kOrangeColor),
                        keyboardType: TextInputType.text,
                        maxLines: null,
                        maxLength: 30,
                        textCapitalization: TextCapitalization.sentences,
                        style: Theme.of(context).textTheme.bodyText1,
                        validator: Validator.validateMessage,
                        decoration: const InputDecoration(
                          hintText: kEmail,

                        ),
                        onSaved: (String? value) {
                          message = value!;
                        },
                      ),

                      spacing(),

                    ],
                  ),
                ),
                spacing(),

                spacing(),

                GeneralButton(tapStudiesButton: () async {
                  final form = _formKey.currentState;

                  if (form!.validate()) {
                    form.save();
                    FocusScopeNode currentFocus = FocusScope.of(context);

                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                    setState(() {
                      loading != loading;
                    });
                    var result =  await BookingBloc().onCancelBookingRequested(_message.text.trim());
                    if(result == true){
                      Navigator.pushNamed(context, homePage);
                    }else{
                      ScaffoldMsg().errorMsg(context, result.toString());
                      Navigator.pop(context);
                    }
                  }
                },title: loading?"Wait...":kCancel,),
                spacing(),
              ]
          )
      ),
    );
  }
}
