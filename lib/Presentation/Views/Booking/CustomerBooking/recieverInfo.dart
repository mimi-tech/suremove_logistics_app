import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:sure_move/Logic/BookingLogic/bookingCollectionData.dart';
import 'package:sure_move/Logic/BookingLogic/bookingBloc.dart';
import 'package:sure_move/Logic/BookingLogic/bookingEvent.dart';
import 'package:sure_move/Logic/BookingLogic/bookingState.dart';
import 'package:sure_move/Models/userModel.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/scaffoldMsg.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/Views/Authentication/validation.dart';
import 'package:sure_move/Presentation/utils/enums.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';
import 'package:sure_move/Providers/userProvider.dart';

class ReceiversInfo extends StatefulWidget {
  const ReceiversInfo({Key? key}) : super(key: key);

  @override
  State<ReceiversInfo> createState() => _ReceiversInfoState();
}

class _ReceiversInfoState extends State<ReceiversInfo> {
  Color btnColor = kTextFieldBorderColor;
  final TextEditingController _senderName = TextEditingController();
  final TextEditingController _senderPhoneNumber = TextEditingController();
 final TextEditingController _receiverName = TextEditingController();
  final TextEditingController _receiverPhoneNumber = TextEditingController();
  Gender _gender = Gender.male;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? senderName;
  String? senderPhoneNumber;
  String? receiverName;
  String? receiverPhoneNumber;
  var result;
  @override
  Widget build(BuildContext context) {
    NewUser user = Provider.of<UserProvider>(context).user;
    _senderName.text = user.firstName!.toString();
    _senderPhoneNumber.text = user.phoneNumber!.toString();
    return Scaffold(
        appBar: AppBar(title: Text(kItemDeliveryLocation.toUpperCase())),
        body:BlocConsumer<BookingBloc, BookingState>(
        listener: (context, state) {

          if(state is BookingSuccess){
            Navigator.pushNamed(context, displayAmount);
          }
          if(state is BookingDenied){
            ScaffoldMsg().errorMsg(context, state.errors[0]);
          }
        },
            builder: (context, state) {

              return ModalProgressHUD(
                inAsyncCall: state is UserLoading ?true:false,
                child: SingleChildScrollView(
          child:  Container(
            margin: EdgeInsets.symmetric(horizontal: kMargin),
            child: Column(
                children: [
                  spacing(),
                  Center(child: Text(kItemInfo.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1,)),
                  spacing(),

                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: [
                        spacing(),
                        const Text(kSendersName),
                        TextFormField(
                          controller: _senderName,
                          autocorrect: true,
                          readOnly: true,
                          autofocus: true,
                          cursorColor: (kOrangeColor),
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.sentences,
                          style: Theme.of(context).textTheme.bodyText1,
                          validator: Validator.validateField,
                          decoration: const InputDecoration(
                            hintText: "Full name",

                          ),
                          onSaved: (String? value) {
                            senderName = value!;
                          },
                        ),

                        spacing(),
                        const Text(kSendersPhoneNumber),
                        TextFormField(
                          controller: _senderPhoneNumber,
                          autocorrect: true,
                          autofocus: true,
                          readOnly: true,
                          cursorColor: (kOrangeColor),
                          keyboardType: TextInputType.phone,
                          style: Theme.of(context).textTheme.bodyText1,
                          validator: Validator.validatePhoneNumber,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                            hintText: "Mobile number",

                          ),
                          onSaved: (String? value) {
                            senderPhoneNumber = value!;
                          },
                        ),

                        spacing(),
                        Center(child: Text("Receiver's Details".toUpperCase(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle1,)),
                        spacing(),

                        const Text(kReceiverName),
                        TextFormField(
                          controller: _receiverName,
                          autocorrect: true,
                          autofocus: true,
                          cursorColor: (kOrangeColor),
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.sentences,
                          style: Theme.of(context).textTheme.bodyText1,
                          validator: Validator.validateField,
                          decoration: const InputDecoration(
                            hintText: "Full name",

                          ),
                          onSaved: (String? value) {
                            receiverName = value!;
                          },
                        ),
                        spacing(),
                        const Text(kReceiverPhoneNumber),
                        TextFormField(
                          controller: _senderPhoneNumber,
                          autocorrect: true,
                          autofocus: true,
                          cursorColor: (kOrangeColor),
                          keyboardType: TextInputType.phone,
                          style: Theme.of(context).textTheme.bodyText1,
                          validator: Validator.validatePhoneNumber,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                            hintText: "Mobile number",

                          ),
                          onSaved: (String? value) {
                            receiverPhoneNumber = value!;
                          },
                        ),
                      ],
                    ),
                  ),
                  spacing(),

                  Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(kReceiverGender),
                      ListTile(
                        title: const Text('Male'),
                        leading: Radio<Gender>(
                          value: Gender.male,
                          groupValue: _gender,
                          onChanged: (Gender? value) {
                            setState(() {
                              _gender = value!;
                              RegConstants().gender = _gender;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Female'),
                        leading: Radio<Gender>(
                          value: Gender.female,
                          groupValue: _gender,
                          onChanged: (Gender? value) {
                            setState(() {
                              _gender = value!;
                              RegConstants().gender = _gender;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  spacing(),
                  space(),
                  GeneralButton(title: kNextBtn, tapStudiesButton: (){
                      final form = _formKey.currentState;
                      if (form!.validate()) {
                      form.save();
                      FocusScopeNode currentFocus = FocusScope.of(context);

                      if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();

                    dynamic destinationAddress;
                   result =  BookingCollections.bookingDetails[0].item;
                    for(var values in BookingCollections.bookingDetails){
                      destinationAddress = values.destinationAddress;
                    }
                    var sender = {
                      "id":user.userId,
                      "name" : user.firstName! + user.lastName.toString(),
                      "profilePicture":user.profileImageUrl,
                      "phoneNumber":user.phoneNumber,
                      "address":BookingConstants().customerSourceAddress,
                      "gender":user.gender
                    };
                    var receiver = {
                      "name" : _receiverName.text,
                      "profilePicture":"",
                      "phoneNumber":_receiverPhoneNumber.text,
                      "address":destinationAddress,
                      "gender":_gender
                    };
                    BookingCollections().customerBookingDetailsJson(
                      receiver: receiver,
                      sender: sender
                    );
                      BlocProvider.of<BookingBloc>(context).add(CalculateCostRequested(result["itemCount"], result["itemSize"]));


                  }}}),
                  space(),
                ],
            ),
          )),
              );
        })
          );
  }
}
