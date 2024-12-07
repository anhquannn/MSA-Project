import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Widget_Feedback extends StatelessWidget {
  final int? rating;
  final String? name;
  final String? comments;

  Widget_Feedback({
    required this.rating,
    required this.name,
    required this.comments,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Color.fromRGBO(49, 200 , 248 , 1)),
        color: Color.fromRGBO(244, 244, 244, 1),
        borderRadius: BorderRadius.circular(7)
      ),
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name!,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: List.generate(5, (index) {
              return Icon(
                index < rating! ? Icons.star : Icons.star_border,
                color: Colors.yellow,
              );
            }),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Text(
              comments!,
              style: TextStyle(fontSize: 14, color: Colors.black),
              softWrap: true,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

