import 'package:flutter/cupertino.dart';

class Node{
  final double cpu;
  final double memory;
   bool isLeader=false;
Node({@required this.cpu,@required this.memory,this.isLeader});
}