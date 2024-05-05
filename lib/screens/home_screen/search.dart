import "package:flutter/material.dart";
import "package:get/get_state_manager/src/simple/get_view.dart";


class SearchTab extends GetView<SearchController> {
  SearchTab({required this.text, super.key});
  String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow:  const <BoxShadow>[
          BoxShadow(
            blurRadius: 3,
            color: Color(0x33000000),
            offset: Offset(
              0,
              1,
            ),
          ),
        ],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white,
        ),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 8, 0),
        child: Row(
          children: <Widget>[
            const Icon(
              Icons.search_rounded,
              color: Colors.black,
              size: 24,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                child: SizedBox(
                  width: 200,
                  child: TextFormField(
                    autofocus: false,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: text,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    style: const TextStyle(
                      fontFamily: "Inter",
                      letterSpacing: 0,
                    ),
                    minLines: null,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
