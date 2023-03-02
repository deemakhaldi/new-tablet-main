import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF790000);

const String serverUrl = 'https://gwtest.bisan.com/api/v2';
const String apiID = 'BISANTABLET';
const String apiSecret = "V1M6AID5HKTNxbtHFan3mhWXFit5wZWok01iw6Ri";

Map<String, String> loginHeaders = {
  "Content-Type": "application/json",
  "BSN-apiID": apiID,
  "BSN-apiSecret": apiSecret,
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Credentials": "true",
  "Access-Control-Allow-Headers":
      "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
  "Access-Control-Allow-Methods": "POST, OPTIONS, GET, HEAD",
};

Map<String, String> headers = {
  "Content-Type": "application/json",
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Credentials": "true",
  "Access-Control-Allow-Headers":
      "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
  "Access-Control-Allow-Methods": "POST, OPTIONS, GET, HEAD",
};
