# 基于 Spring 和 Flutter 的前后端分离电商平台

![cover](./screenshot/cover.png)

## 项目架构

### 总体架构

```mermaid
flowchart LR
    %% 定义节点
    subgraph customer_frontend[客户前端]
    end
    subgraph admin_frontend[管理后台前端]
    end
    subgraph backend[后端]
    end
    db[(MySQL 数据库)]
    redis[(Redis 缓存)]
    oos[(MinIO/AWS/COS 对象存储)]
    %% 连接节点
    customer_frontend -- Http --- backend
    admin_frontend -- Http --- backend
    backend -- JPA/Hibernate --- db
    backend -- Jedis --- redis
    backend -- http --- oos
```

### 后端架构

```mermaid
flowchart LR
    %% 定义节点
    subgraph backend[后端]
        direction LR
        entity([实体])
        view([视图])
        subgraph controller["Controllers 接口"]
            direction TB
            auth_c(["验证、鉴权、授权相关接口"])
            good_c(["商品相关接口"])
            customer_c(["客户操作相关接口"])
            admin_c(["管理员操作相关接口"])
        end
        subgraph service["Services 业务"]
            direction TB
            auth_s(["验证、鉴权、授权相关业务"])
            good_s(["商品相关业务"])
            customer_s(["客户相关业务"])
            admin_s(["管理员相关业务"])
        end
        subgraph repository["Repository 仓储"]
            direction TB
            good_r(["商品仓储"])
            good_image_r(["商品图片仓储"])
            good_order_r(["商品订单仓储"])
            good_category_r(["商品分类仓储"])
            user_r(["用户仓储"])
            role_r(["角色仓储"])
        end
    end
    %% 连接节点
    auth_c & good_c & customer_c & admin_c --- view
    view --- auth_s & good_s & customer_s & admin_s
    auth_s & good_s & customer_s & admin_s --- entity
    entity --- user_r & role_r & good_r & good_image_r & good_category_r & good_order_r
```

### 前端架构

```mermaid
flowchart LR
    %% 定义节点
    subgraph frontend["前端"]
        type["提供实体"]
        dependency_injection["状态管理、依赖注入"]
        subgraph page["Pages 页面"]
            direction TB
            auth_pg(["登录注册页"])
            home_pg(["主页"])
            good_detail_pg(["商品详情页"])
            cart_pg(["购物车页"])
            search_pg(["搜索页"])
            my_pg(["'我的"'页])
        end
        subgraph controller["Controllers 控制器"]
            direction TB
            auth_c(["登录注册控制器"])
            shopping_cart_c(["购物车控制器"])
            user_detail_c(["用户信息控制器"])
            navigation_c(["底部导航栏控制器"])
        end
        subgraph provider["Providers 提供者"]
            direction TB
            auth_p(["验证、鉴权信息提供者"])
            cart_p(["购物车内容提供者"])
            good_p(["商品信息提供者"])
            order_p(["订单信息提供者"])
        end
    end
    %% 连接节点
    dependency_injection ---> auth_pg & home_pg & good_detail_pg & cart_pg & search_pg & my_pg
    auth_c & shopping_cart_c & user_detail_c & navigation_c ---> dependency_injection
    type ---> auth_c & shopping_cart_c & user_detail_c & navigation_c
    auth_p & cart_p & good_p & order_p ---> type
```

## 如何运行

> [!NOTE]
> 在编译前请确保当前环境中已经有如下工具链：OpenJDK 17, FVM, MySQL, Chrome/Chromium, MinIO(可选)

所有调试，构建，部署脚本均置于项目根目录 `justfile` 中，若想使用 `just` 改善生活质量，
请先将 `.env-template` 重命名为 `.env` 后自行根据目前环境更改脚本。

### [Just](https://github.com/casey/just/tree/master)（推荐）

```bash
mv .env-template .env             # 配置环境变量
just run-backend                  # Debug 模式运行后端
just run-customer-frontend        # Debug 模式运行商城前端
just run-management-frontend      # Debug 模式运行管理系统前端
```

## 如何构建并部署

```bash
just build deploy
```
