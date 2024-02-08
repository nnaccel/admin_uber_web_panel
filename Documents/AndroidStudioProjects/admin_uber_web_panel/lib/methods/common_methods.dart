import 'package:flutter/material.dart';

class CommonMethods{
  Widget header(int headerFlexValue, String headerTitle){
    return Expanded(
      flex: headerFlexValue,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          color: const Color(0xffffdd00),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            headerTitle,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget data(int dataFlexValue, Widget widget){
    return Expanded(
      flex: dataFlexValue,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xff030126)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: widget,
        ),
      ),
    );
  }
}
