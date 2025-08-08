import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todo_app/core/util/color.dart';
import 'package:todo_app/core/util/injection.dart';
import 'package:todo_app/feature/home/page/home_page.dart';
import 'package:todo_app/feature/login/provider/login_provider.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = "/";
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _provider = locator<LoginProvider>();
  final formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _provider.check().then((value) {
        if (value != null && value.isNotEmpty) {
          if (mounted) {
            Navigator.popAndPushNamed(
              context, HomePage.routeName, arguments: value
            );
          } else {
            _provider.setLoading = false;
          }
        } else {
          _provider.setLoading = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _provider,
      builder: (_, __) => Scaffold(
        body: Selector<LoginProvider, bool>(
          selector: (_, provider) => provider.isLoading,
          builder: (_, loading, __) => loading ? Center(
            child: CircularProgressIndicator()
          ) : Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10.px,
                children: [
                  Text(
                    "Name",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  TextFormField(
                    controller: nameCtrl,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Field must be filled!";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: "Your name",
                      border: InputBorder.none,
                      fillColor: surfaceColor,
                      filled: true
                    )
                  ),
                  FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: primaryColor,
                      minimumSize: Size(112.px, 40.px),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.px)
                      )
                    ),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await _provider.login(name: nameCtrl.text);
                        if (context.mounted) {
                          Navigator.popAndPushNamed(
                            context, HomePage.routeName,
                            arguments: nameCtrl.text
                          );
                        }
                      }
                    },
                    label: const Text("Next"),
                    iconAlignment:IconAlignment.end,
                    icon: const Icon(Icons.arrow_forward_rounded),
                  )
                ]
              )
            )
          ),
        )
      )
    );
  }
}