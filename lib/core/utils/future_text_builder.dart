import 'package:flutter/material.dart';

Widget FutureTextBuilderModule<T>({
  required Future<T> future,
  required Widget Function(BuildContext, T) onData,
  TextStyle? textStyle,
  Widget? errorWidget,
  Widget? noDataWidget,
}) {
  return FutureBuilder<T>(
    future: future,
    builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator.adaptive();
      } else if (snapshot.hasError) {
        return errorWidget ?? Text("Error: ${snapshot.error}");
      } else if (snapshot.hasData) {
        if (snapshot.data != null) {
          return onData(context, snapshot.data as T);
        }
      }
      // Returning `noDataWidget` as a fallback if none of the above conditions are met
      return noDataWidget ??
          const Center(
            child: Text("No Data Available"),
          );
    },
  );
}
