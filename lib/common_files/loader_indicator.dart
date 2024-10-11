import 'package:bitetime/common_files/styles.dart';
import 'package:flutter/material.dart';


class LoaderIndicator extends StatelessWidget {
  final bool loading;
  LoaderIndicator(this.loading);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: loading == true
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(greenColor),
              ),
            )
          : Container(),
    );
  }
}

class LoaderIndicatorList extends StatelessWidget {
  final bool loading;
  LoaderIndicatorList(this.loading);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 40,
      child: loading == true
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(greenColor),
              ),
            )
          : Container(),
    );
  }
}
