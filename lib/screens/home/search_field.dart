import 'package:das_app/constants.dart';
import 'package:das_app/size_config.dart';
import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 50,
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        onChanged: (value) {
          //
          // Search Value
          //
        },
        decoration: InputDecoration(
            fillColor: kPrimaryColor.withOpacity(0.1),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: "Search Group",
            prefixIcon: const Icon(
              Icons.search,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 9)),
      ),
    );
  }
}
