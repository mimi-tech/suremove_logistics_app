import 'package:flutter/material.dart';
class HistoryHeaderTitle extends StatefulWidget implements PreferredSizeWidget {
  const HistoryHeaderTitle({Key? key, this.title1, this.title2, this.title3}) : super(key: key);
  final String? title1;
  final String? title2;
  final String? title3;


  @override
  State<HistoryHeaderTitle> createState() => _HistoryHeaderTitleState();
  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(56.0);
}

class _HistoryHeaderTitleState extends State<HistoryHeaderTitle> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title:IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.title1??"Date",style:Theme.of(context).textTheme.headline4,),
            const VerticalDivider(),
            Text(widget.title2??"Details",style:Theme.of(context).textTheme.headline4,),
           const  VerticalDivider(),
            Text(widget.title3??"Amount",style:Theme.of(context).textTheme.headline4,),

          ],
        ),
      )
      );
  }
}
