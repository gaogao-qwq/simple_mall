class Count {
  int count = 0;

  Count(this.count);

  Count.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }
}
