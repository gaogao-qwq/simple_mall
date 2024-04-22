import 'package:consumer/controller/auth_controller.dart';
import 'package:consumer/controller/shopping_cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthPageController extends GetxController {
  final pageController = PageController();
  var currentPage = 0.obs;

  void nextPage() {
    pageController.animateToPage(
      currentPage.value + 1,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
    currentPage++;
  }

  void previousPage() {
    pageController.animateToPage(
      currentPage.value - 1,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
    currentPage--;
  }
}

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ac = Get.put(AuthPageController());
    final lc = Get.put(LoginController());
    final rc = Get.put(RegisterController());
    final apc = Get.put(AuthPageController());
    final scc = Get.put(ShoppingCartController());

    Widget loginForm = Center(
      child: Card(
        margin: const EdgeInsets.all(8),
        child: Form(
          key: lc.formKey,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("登录",
                    style:
                        TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                const SizedBox(height: 48),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "用户名",
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? "请输入用户名" : null,
                  onChanged: (value) {
                    lc.username.value = value;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "密码",
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? "请输入密码" : null,
                  onChanged: (value) {
                    lc.password.value = value;
                  },
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: FilledButton(
                    onPressed: () async {
                      if (!lc.formKey.currentState!.validate()) return;
                      await lc.login();
                    },
                    child: const Text("登录", style: TextStyle(fontSize: 16)),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: FilledButton(
                    onPressed: () {
                      ac.nextPage();
                    },
                    child:
                        const Text("没有账号？去注册", style: TextStyle(fontSize: 16)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );

    Widget registerForm = Center(
      child: Card(
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: rc.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("注册",
                    style:
                        TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                const SizedBox(height: 48),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "用户名",
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? "请输入用户名" : null,
                  onChanged: (value) {
                    rc.username.value = value;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "称谓",
                  ),
                  hint: const Text("希望我们怎么称呼您？"),
                  items: const [
                    DropdownMenuItem(value: 0, child: Text("先生")),
                    DropdownMenuItem(value: 1, child: Text("女士")),
                  ],
                  validator: (value) => value == null ? "请选择您的称谓" : null,
                  onChanged: (value) => rc.gender.value = value!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "密码",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return "请输入密码";
                    if (rc.password != rc.confirmPassword) return "两次输入的密码不一致";
                    return null;
                  },
                  onChanged: (value) {
                    rc.password.value = value;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "确认密码",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return "请输入密码";
                    if (rc.password != rc.confirmPassword) return "两次输入的密码不一致";
                    return null;
                  },
                  onChanged: (value) => rc.confirmPassword.value = value,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: FilledButton(
                    onPressed: () async {
                      if (!rc.formKey.currentState!.validate()) return;
                      await rc.register();
                      await scc.fetchCartItems();
                    },
                    child: const Text("注册", style: TextStyle(fontSize: 16)),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: FilledButton(
                    onPressed: () {
                      apc.previousPage();
                    },
                    child:
                        const Text("已有账号？去登录", style: TextStyle(fontSize: 16)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Obx(() =>
            ac.currentPage.value == 0 ? const Text("登录") : const Text("注册")),
      ),
      body: PageView(
        controller: ac.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          loginForm,
          registerForm,
        ],
      ),
    );
  }
}
