import 'package:flutter/material.dart';

class OpenCollectiveUser {
  int MemberId;
  var createdAt;
  String type;
  String role;
  bool isActive;
  var totalAmountDonated;
  String currency;
  var lastTransactionAt;
  var lastTransactionAmount;
  String profile;
  String name;
  String company;
  String description;
  String image;
  String email;
  String twitter;
  String github;
  String website;

  OpenCollectiveUser({
    Key key,
    this.name, this.image, this.email, this.description, this.github, this.createdAt,
    this.type, this.company, this.currency, this.isActive, this.lastTransactionAmount,
    this.lastTransactionAt, this.MemberId, this.profile, this.role, this.totalAmountDonated,
    this.twitter, this.website,
  });

  OpenCollectiveUser.fromJson(Map<String, dynamic> data) {
    MemberId = data['MemberId'];
    createdAt = data['createdAt'];
    type = data['type'];
    role = data['role'];
    isActive = data['isActive'];
    totalAmountDonated = data['totalAmountDonated'];
    currency = data['currency'];
    lastTransactionAt = data['lastTransactionAt'];
    lastTransactionAmount = data['lastTransactionAmount'];
    profile = data['profile'];
    name = data['name'];
    company = data['company'];
    description = data['description'];
    image = data['image'];
    email = data['email'];
    twitter = data['twitter'];
    github = data['github'];
    website = data['website'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MemberId'] = this.MemberId;
    data['createdAt'] = this.createdAt;
    data['type'] = this.type;
    data['role'] = this.role;
    data['isActive'] = this.isActive;
    data['totalAmountDonated'] = this.totalAmountDonated;
    data['currency'] = this.currency;
    data['lastTransactionAt'] = this.lastTransactionAt;
    data['lastTransactionAmount'] = this.lastTransactionAmount;
    data['profile'] = this.profile;
    data['name'] = this.name;
    data['company'] = this.company;
    data['description'] = this.description;
    data['image'] = this.image;
    data['email'] = this.email;
    data['twitter'] = this.twitter;
    data['github'] = this.github;
    data['website'] = this.website;

    return data;
  }
}