enum Province {
  nil(code: 0, fullname: "null"),
  beijing(code: 110000, fullname: "北京市"),
  tianjin(code: 120000, fullname: "天津市"),
  hebei(code: 130000, fullname: "河北省"),
  shanxi(code: 140000, fullname: "山西省"),
  innermongolia(code: 150000, fullname: "内蒙古自治区"),
  liaoning(code: 210000, fullname: "辽宁省"),
  jilin(code: 220000, fullname: "吉林省"),
  heilongjiang(code: 230000, fullname: "黑龙江省"),
  shanghai(code: 310000, fullname: "上海市"),
  jiangsu(code: 320000, fullname: "江苏省"),
  zhejiang(code: 330000, fullname: "浙江省"),
  anhui(code: 340000, fullname: "安徽省"),
  fujian(code: 350000, fullname: "福建省"),
  jiangxi(code: 360000, fullname: "江西省"),
  shandong(code: 370000, fullname: "山东省"),
  henan(code: 410000, fullname: "河南省"),
  hubei(code: 420000, fullname: "湖北省"),
  hunan(code: 430000, fullname: "湖南省"),
  guangdong(code: 440000, fullname: "广东省"),
  guangxi(code: 450000, fullname: "广西壮族自治区"),
  hainan(code: 460000, fullname: "海南省"),
  chongqing(code: 500000, fullname: "重庆市"),
  sichuan(code: 510000, fullname: "四川省"),
  guizhou(code: 520000, fullname: "贵州省"),
  yunnan(code: 530000, fullname: "云南省"),
  xizang(code: 540000, fullname: "西藏自治区"),
  shannxi(code: 610000, fullname: "陕西省"),
  gansu(code: 620000, fullname: "甘肃省"),
  qinghai(code: 630000, fullname: "青海省"),
  ningxia(code: 640000, fullname: "宁夏回族自治区"),
  xinjiang(code: 650000, fullname: "新疆维吾尔自治区"),
  hongkong(code: 810000, fullname: "香港特别行政区"),
  macao(code: 820000, fullname: "澳门特别行政区"),
  taiwan(code: 710000, fullname: "台湾省");

  final int code;
  final String fullname;

  const Province({required this.code, required this.fullname});

  factory Province.fromCode(int code) =>
      Province.values.where((e) => e.code == code).first;
}
