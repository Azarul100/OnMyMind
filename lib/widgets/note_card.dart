import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../style/app_style.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

Widget noteCard(Function()? onTop, QueryDocumentSnapshot doc) {
	DateTime dt = (doc['timestamp'] as Timestamp).toDate();
	String date = DateFormat('MM/dd/yyyy, hh:mm a').format(dt);

	return InkWell(
		onTap: onTop,
		child: Container(
			padding: EdgeInsets.all(8.0),
			margin: EdgeInsets.all(8.0),
			decoration: BoxDecoration(
				color: AppStyle.cardsColor[doc['color']],
				borderRadius: BorderRadius.circular(8.0),
			),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					Text(
						doc["title"],
						style: AppStyle.mainTitle,
					),
					SizedBox(
						height: 4.0,
					),
					Text(
						date,
						style: AppStyle.dateTitle,
					),
					SizedBox(
						height: 8.0,
					),
					Text(
						doc["note"],
						style: AppStyle.mainContent,
						overflow: TextOverflow.ellipsis,
					),
				],
			),
		),
	);
}