package com.gaogaoqwq.mall.enums;

import java.util.List;
import java.util.Optional;

import com.gaogaoqwq.mall.exception.ProvinceNotFoundException;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum Province {
    NULL(0, "NULL"),
    BEIJING(110000, "北京市"),
    TIANJIN(120000, "天津市"),
    HEBEI(130000, "河北省"),
    SHANXI(140000, "山西省"),
    INNERMONGOLIA(150000, "内蒙古自治区"),
    LIAONING(210000, "辽宁省"),
    JILIN(220000, "吉林省"),
    HEILONGJIANG(230000, "黑龙江省"),
    SHANGHAI(310000, "上海市"),
    JIANGSU(320000, "江苏省"),
    ZHEJIANG(330000, "浙江省"),
    ANHUI(340000, "安徽省"),
    FUJIAN(350000, "福建省"),
    JIANGXI(360000, "江西省"),
    SHANDONG(370000, "山东省"),
    HENAN(410000, "河南省"),
    HUBEI(420000, "湖北省"),
    HUNAN(430000, "湖南省"),
    GUANGDONG(440000, "广东省"),
    GUANGXI(450000, "广西壮族自治区"),
    HAINAN(460000, "海南省"),
    CHONGQING(500000, "重庆市"),
    SICHUAN(510000, "四川省"),
    GUIZHOU(520000, "贵州省"),
    YUNNAN(530000, "云南省"),
    XIZANG(540000, "西藏自治区"),
    SHANNXI(610000, "陕西省"),
    GANSU(620000, "甘肃省"),
    QINGHAI(630000, "青海省"),
    NINGXIA(640000, "宁夏回族自治区"),
    XINJIANG(650000, "新疆维吾尔自治区"),
    HONGKONG(810000, "香港特别行政区"),
    MACAO(820000, "澳门特别行政区"),
    TAIWAN(710000, "台湾省");

    private Integer code;

    private String fullName;

    public static Province fromCode(int code) throws ProvinceNotFoundException {
        Optional<Province> opt = List.of(Province.values()).stream()
                .filter(e -> e.code.equals(code))
                .findFirst();
        if (opt.isEmpty())
            throw new ProvinceNotFoundException(code);
        return opt.get();
    }

}
