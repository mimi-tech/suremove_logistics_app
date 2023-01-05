import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/Views/Authentication/validation.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';

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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? senderName;
  String? senderPhoneNumber;
  String? receiverName;
  String? receiverPhoneNumber;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(kItemDeliveryLocation.toUpperCase())),
        body: Container(
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
              space(),
              GeneralButton(title: kNextBtn, tapStudiesButton: (){
                Navigator.pushNamed(context, displayAmount);
              }),
            ],
          ),
        ));
  }
}
