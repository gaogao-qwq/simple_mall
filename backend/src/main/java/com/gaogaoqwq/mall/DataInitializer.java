package com.gaogaoqwq.mall;

import com.gaogaoqwq.mall.entity.*;
import com.gaogaoqwq.mall.enums.Gender;
import com.gaogaoqwq.mall.enums.OrderState;
import com.gaogaoqwq.mall.enums.RoleName;
import com.gaogaoqwq.mall.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Component
@RequiredArgsConstructor
public class DataInitializer implements CommandLineRunner {

    private final RoleRepository roleRepo;
    private final UserRepository userRepo;
    private final CartRepository userCartRepo;
    private final GoodRepository goodRepo;
    private final GoodCategoryRepository goodCategoryRepo;
    private final GoodSubCategoryRepository goodSubCategoryRepo;
    private final GoodSwiperRepository goodSwiperRepo;
    private final GoodImageRepository goodImageRepo;
    private final GoodOrderRepository goodOrderRepo;
    private final PasswordEncoder passwordEncoder;

    @Override
    public void run(String... args) {
        initRole();
        initUser();
        initUserCart();
        initGoodCategory();
        initGoodSubCategory();
        initGood();
        initGoodSwiper();
        initGoodImage();
        initGoodOrder();
    }

    private void initRole() {
        if (roleRepo.count() > 0)
            return;

        var roles = List.of(
                Role.builder().name("ROLE_" + RoleName.ADMIN).description("管理员").editable(false).build(),
                Role.builder().name("ROLE_" + RoleName.CUSTOMER).description("普通用户").editable(false).build());
        roleRepo.saveAll(roles);
    }

    private void initUser() {
        if (userRepo.count() > 0)
            return;
        var adminRole = roleRepo.findByName("ROLE_" + RoleName.ADMIN).get();
        var customerRole = roleRepo.findByName("ROLE_" + RoleName.CUSTOMER).get();
        var users = List.of(
                User.builder()
                        .username("root")
                        .password(passwordEncoder.encode("root"))
                        .gender(Gender.MALE)
                        .createDate(Date.from(Instant.parse("2023-12-31T00:00:00.00Z")))
                        .role(adminRole)
                        .enable(true).build(),
                User.builder()
                        .username("user1")
                        .password(passwordEncoder.encode("user1"))
                        .gender(Gender.MALE)
                        .createDate(Date.from(Instant.parse("2024-02-21T00:00:00.00Z")))
                        .role(customerRole)
                        .enable(true).build(),
                User.builder()
                        .username("user2")
                        .password(passwordEncoder.encode("user2"))
                        .gender(Gender.FEMALE)
                        .createDate(Date.from(Instant.parse("2023-01-14T00:00:00.00Z")))
                        .role(customerRole)
                        .enable(true)
                        .build());
        userRepo.saveAll(users);
    }

    private void initUserCart() {
        if (userCartRepo.count() > 0)
            return;
        List<User> users = userRepo.findAll();
        List<Cart> userCarts = new ArrayList<Cart>();
        users.forEach(u -> {
            userCarts.add(Cart.builder().user(u).cartItems(List.of()).build());
        });
        userCartRepo.saveAll(userCarts);
    }

    private void initGoodCategory() {
        if (goodCategoryRepo.count() > 0)
            return;
        var goodCategories = List.of(
                GoodCategory.builder().name("家电").build(),
                GoodCategory.builder().name("3C数码").build(),
                GoodCategory.builder().name("图书").build(),
                GoodCategory.builder().name("服装").build(),
                GoodCategory.builder().name("食品").build());
        goodCategoryRepo.saveAll(goodCategories);
    }

    private void initGoodSubCategory() {
        if (goodSubCategoryRepo.count() > 0)
            return;
        var homeAppliances = goodCategoryRepo.getReferenceById(1L);
        var digitalProducts = goodCategoryRepo.getReferenceById(2L);
        var books = goodCategoryRepo.getReferenceById(3L);
        var clothes = goodCategoryRepo.getReferenceById(4L);
        var foods = goodCategoryRepo.getReferenceById(5L);

        var goodSubCategories = List.of(
                GoodSubCategory.builder().name("空调").category(homeAppliances).build(),
                GoodSubCategory.builder().name("冰箱").category(homeAppliances).build(),
                GoodSubCategory.builder().name("电视").category(homeAppliances).build(),
                GoodSubCategory.builder().name("手机").category(digitalProducts).build(),
                GoodSubCategory.builder().name("电脑").category(digitalProducts).build(),
                GoodSubCategory.builder().name("平板").category(digitalProducts).build(),
                GoodSubCategory.builder().name("文学").category(books).build(),
                GoodSubCategory.builder().name("人文社科").category(books).build(),
                GoodSubCategory.builder().name("科学技术").category(books).build(),
                GoodSubCategory.builder().name("男装").category(clothes).build(),
                GoodSubCategory.builder().name("女装").category(clothes).build(),
                GoodSubCategory.builder().name("新鲜水果").category(clothes).build(),
                GoodSubCategory.builder().name("蔬菜鲜品").category(foods).build(),
                GoodSubCategory.builder().name("肉禽蛋品").category(foods).build(),
                GoodSubCategory.builder().name("酒水副食").category(foods).build());
        goodSubCategoryRepo.saveAll(goodSubCategories);
    }

    private void initGood() {
        if (goodRepo.existsById(1L))
            return;
        var airConditioner = goodSubCategoryRepo.getReferenceById(1L);
        var refrigerator = goodSubCategoryRepo.getReferenceById(2L);
        var tv = goodSubCategoryRepo.getReferenceById(3L);
        var phone = goodSubCategoryRepo.getReferenceById(4L);
        var computer = goodSubCategoryRepo.getReferenceById(5L);
        var tablet = goodSubCategoryRepo.getReferenceById(6L);
        var literature = goodSubCategoryRepo.getReferenceById(7L);
        var humanities = goodSubCategoryRepo.getReferenceById(8L);
        var science = goodSubCategoryRepo.getReferenceById(9L);
        var menClothes = goodSubCategoryRepo.getReferenceById(10L);
        var womenClothes = goodSubCategoryRepo.getReferenceById(11L);
        var fruit = goodSubCategoryRepo.getReferenceById(12L);
        var vegetables = goodSubCategoryRepo.getReferenceById(13L);
        var meat = goodSubCategoryRepo.getReferenceById(14L);
        var drink = goodSubCategoryRepo.getReferenceById(15L);

        var goods = List.of(
                Good.builder()
                        .name("小米空调")
                        .description("小米（MI）空调 KFR-35GW/WDAA3@ 1.5匹 变频冷暖 壁挂式 家用空调挂机")
                        .price(BigDecimal.valueOf(1999.99))
                        .subCategory(airConditioner)
                        .previewImgUrl("goods/ac1.jpg")
                        .stock(1000)
                        .purchaseLimit(5)
                        .build(),
                Good.builder()
                        .name("美的空调")
                        .description("美的（Midea）正1.5匹 变频冷暖 壁挂式 家用空调挂机 KFR-35GW/WDAA3@")
                        .price(BigDecimal.valueOf(1799.00))
                        .subCategory(airConditioner)
                        .previewImgUrl("goods/ac2.jpg")
                        .purchaseLimit(5)
                        .stock(2000).build(),
                Good.builder()
                        .name("小米冰箱")
                        .description("小米（MI）冰箱 BCD-215TMV 215升 三门冰箱 风冷无霜 低温净味 保鲜保鲜")
                        .price(BigDecimal.valueOf(1249.00))
                        .subCategory(refrigerator)
                        .previewImgUrl("goods/fridge1.jpg")
                        .stock(1500).build(),
                Good.builder()
                        .name("美的华凌冰箱")
                        .description("美的（Midea）华凌冰箱 BCD-215TMV 215升 三门冰箱 风冷无霜 低温净味 保鲜保鲜")
                        .price(BigDecimal.valueOf(1599.00))
                        .subCategory(refrigerator)
                        .previewImgUrl("goods/fridge2.jpg")
                        .stock(800).build(),
                Good.builder()
                        .name("东芝双开门大冰箱")
                        .description("东芝（TOSHIBA）双开门大冰箱 GR-H46TDZ-W 460L 三门冰箱 风冷无霜 低温净味 保鲜保鲜")
                        .price(BigDecimal.valueOf(17999.00))
                        .subCategory(refrigerator)
                        .previewImgUrl("goods/fridge3.jpg")
                        .stock(100).build(),
                Good.builder()
                        .name("微星游戏本")
                        .description(
                                "微星（MSI）游戏本 GF65 Thin 10UE-014CN 15.6英寸 144Hz高刷新率 11代酷睿i7 RTX3060 6G独显 16G 512G固态笔记本电脑")
                        .price(BigDecimal.valueOf(6999.00))
                        .subCategory(computer)
                        .previewImgUrl("goods/laptop1.jpg")
                        .purchaseLimit(2)
                        .stock(500).build(),
                Good.builder()
                        .name("雷神游戏本")
                        .description("雷神（ThundeRobot）游戏本 911-E2 15.6英寸 144Hz高刷新率 11代酷睿i7 RTX3060 6G独显 16G 512G固态笔记本电脑")
                        .price(BigDecimal.valueOf(5999.00))
                        .subCategory(computer)
                        .previewImgUrl("goods/laptop2.jpeg")
                        .purchaseLimit(2)
                        .stock(300).build(),
                Good.builder()
                        .name("小米14Pro")
                        .description(
                                "小米（MI）14Pro 5G手机 8GB+256GB 钛银黑 骁龙888 120Hz高刷新率 5000万像素超广角三摄 120W有线闪充 67W无线闪充 10W反向充电")
                        .price(BigDecimal.valueOf(5499.00))
                        .subCategory(phone)
                        .previewImgUrl("goods/phone1.jpg")
                        .purchaseLimit(2)
                        .stock(1100).build(),
                Good.builder()
                        .name("平板电视1")
                        .description("小米（MI）平板电视 4S 55英寸 4K超高清 HDR 2GB+8GB 人工智能语音网络液晶平板电视机")
                        .price(BigDecimal.valueOf(1999.00))
                        .subCategory(tv)
                        .previewImgUrl("goods/tv1.png")
                        .purchaseLimit(4)
                        .stock(700).build(),
                Good.builder()
                        .name("男装1")
                        .description("男装1")
                        .price(BigDecimal.valueOf(899.00))
                        .subCategory(menClothes)
                        .previewImgUrl("goods/men_cloth1.jpg")
                        .purchaseLimit(10)
                        .stock(900).build(),
                Good.builder()
                        .name("男装2")
                        .description("男装2")
                        .price(BigDecimal.valueOf(799.00))
                        .subCategory(menClothes)
                        .previewImgUrl("goods/men_cloth2.jpg")
                        .purchaseLimit(10)
                        .stock(600).build(),
                Good.builder()
                        .name("女装1")
                        .description("女装1")
                        .price(BigDecimal.valueOf(699.00))
                        .subCategory(womenClothes)
                        .previewImgUrl("goods/women_cloth1.jpg")
                        .purchaseLimit(10)
                        .stock(1000).build(),
                Good.builder()
                        .name("女装2")
                        .description("女装2")
                        .price(BigDecimal.valueOf(599.00))
                        .subCategory(womenClothes)
                        .previewImgUrl("goods/women_cloth1.jpg")
                        .purchaseLimit(10)
                        .stock(2300).build(),
                Good.builder()
                        .name("百利甜酒原味利口酒")
                        .description("百利甜酒原味利口酒 750ml/瓶 甜酒")
                        .price(BigDecimal.valueOf(99.00))
                        .subCategory(drink)
                        .previewImgUrl("goods/liqueur1.jpg")
                        .purchaseLimit(100)
                        .stock(2130).build());
        goodRepo.saveAll(goods);
    }

    private void initGoodSwiper() {
        if (goodSwiperRepo.count() > 0)
            return;

        var goodSwiper = List.of(
                GoodSwiper.builder()
                        .swiperImgUrl("swiper/laptop2_swiper.jpg")
                        .good(goodRepo.getReferenceById(7L))
                        .build(),
                GoodSwiper.builder()
                        .swiperImgUrl("swiper/liqueur1_swiper.jpg")
                        .good(goodRepo.getReferenceById(8L))
                        .build(),
                GoodSwiper.builder()
                        .swiperImgUrl("swiper/phone1_swiper.jpeg")
                        .good(goodRepo.getReferenceById(14L))
                        .build());
        goodSwiperRepo.saveAll(goodSwiper);
    }

    private void initGoodImage() {
        if (goodImageRepo.count() > 0)
            return;

        var goodImages = List.of(
                GoodImage.builder()
                        .imageUrl("goods/ac1_detail1.jpg")
                        .good(goodRepo.getReferenceById(1L))
                        .build(),
                GoodImage.builder()
                        .imageUrl("goods/ac1_detail2.jpeg")
                        .good(goodRepo.getReferenceById(1L))
                        .build(),
                GoodImage.builder()
                        .imageUrl("goods/ac2_detail1.jpeg")
                        .good(goodRepo.getReferenceById(2L))
                        .build(),
                GoodImage.builder()
                        .imageUrl("goods/ac2_detail2.jpeg")
                        .good(goodRepo.getReferenceById(2L))
                        .build(),
                GoodImage.builder()
                        .imageUrl("goods/laptop_detail1.jpg")
                        .good(goodRepo.getReferenceById(6L))
                        .build(),
                GoodImage.builder()
                        .imageUrl("goods/laptop_detail2.jpg")
                        .good(goodRepo.getReferenceById(6L))
                        .build());
        goodImageRepo.saveAll(goodImages);
    }

    void initGoodOrder() {
        if (goodOrderRepo.count() > 0)
            return;

        var goodOrders = List.of(
                GoodOrder.builder()
                        .good(goodRepo.getReferenceById(1L))
                        .state(OrderState.ORDER_COMPLETE)
                        .user(userRepo.getReferenceById(2L))
                        .address("广东省广州市越秀区环市东路")
                        .phoneNumber("1234567890")
                        .recipient("张三")
                        .createDate(Date.from(Instant.parse("2023-09-01T00:00:00.00Z")))
                        .build(),
                GoodOrder.builder()
                        .good(goodRepo.getReferenceById(2L))
                        .state(OrderState.ORDER_COMPLETE)
                        .user(userRepo.getReferenceById(2L))
                        .address("广东省广州市越秀区环市东路")
                        .phoneNumber("1234567890")
                        .recipient("张三")
                        .createDate(Date.from(Instant.parse("2023-09-01T00:00:00.00Z")))
                        .build(),
                GoodOrder.builder()
                        .good(goodRepo.getReferenceById(3L))
                        .state(OrderState.ORDER_COMPLETE)
                        .user(userRepo.getReferenceById(2L))
                        .address("广东省广州市越秀区环市东路")
                        .phoneNumber("1234567890")
                        .recipient("张三")
                        .createDate(Date.from(Instant.parse("2023-09-01T00:00:00.00Z")))
                        .build(),
                GoodOrder.builder()
                        .good(goodRepo.getReferenceById(4L))
                        .state(OrderState.ORDER_COMPLETE)
                        .user(userRepo.getReferenceById(2L))
                        .address("广东省广州市越秀区环市东路")
                        .phoneNumber("1234567890")
                        .recipient("张三")
                        .createDate(Date.from(Instant.parse("2023-10-23T00:00:00.00Z")))
                        .build(),
                GoodOrder.builder()
                        .good(goodRepo.getReferenceById(5L))
                        .state(OrderState.ORDER_COMPLETE)
                        .user(userRepo.getReferenceById(3L))
                        .address("北京市朝阳区翻斗乐园")
                        .phoneNumber("0987654321")
                        .recipient("胡图图")
                        .createDate(Date.from(Instant.parse("2023-11-11T00:00:00.00Z")))
                        .build(),
                GoodOrder.builder()
                        .good(goodRepo.getReferenceById(6L))
                        .state(OrderState.ORDER_COMPLETE)
                        .user(userRepo.getReferenceById(3L))
                        .address("北京市朝阳区翻斗乐园")
                        .phoneNumber("0987654321")
                        .recipient("胡图图")
                        .createDate(Date.from(Instant.parse("2023-11-11T00:00:00.00Z")))
                        .build(),
                GoodOrder.builder()
                        .good(goodRepo.getReferenceById(7L))
                        .state(OrderState.AWAIT_DELIVERY)
                        .user(userRepo.getReferenceById(3L))
                        .address("北京市朝阳区翻斗乐园")
                        .phoneNumber("0987654321")
                        .recipient("胡图图")
                        .createDate(Date.from(Instant.parse("2023-11-11T00:00:00.00Z")))
                        .build());

        goodOrderRepo.saveAll(goodOrders);
    }

}
