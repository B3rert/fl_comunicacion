import 'package:flutter/material.dart';

class NotFoundWidget extends StatelessWidget {
  const NotFoundWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.image_not_supported_outlined,
            size: 130,
          ),
          SizedBox(height: 20),
          Text(
            "No se encontraron elementos.",
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
