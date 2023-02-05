class UserMoney {
  final String uid;
  final String money;
  const UserMoney({required this.money, required this.uid});

  Map<String, dynamic> toJson() => {"uid": uid, "money": money};
}
