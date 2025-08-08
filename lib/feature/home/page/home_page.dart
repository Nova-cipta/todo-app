import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todo_app/core/domain/entity/todo.dart';
import 'package:todo_app/core/util/injection.dart';
import 'package:todo_app/feature/home/provider/home_provider.dart';
import 'package:todo_app/feature/home/widget/add_todo_dialog.dart';
import 'package:todo_app/feature/home/widget/todo_card.dart';
import 'package:todo_app/feature/login/page/login_page.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/home";
  final String name;
  const HomePage({super.key, required this.name});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => locator<HomeProvider>()..getList(name: widget.name),
      builder: (_, __) => Consumer<HomeProvider>(
        builder: (_, provider, __) => Scaffold(
          resizeToAvoidBottomInset: true,
          body: provider.isLoading ? Center(
            child: CircularProgressIndicator(),
          ) : Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 10.h
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => provider.logout().then((_) {
                    if (context.mounted) {
                      Navigator.popAndPushNamed(
                        context,
                        LoginPage.routeName
                      );
                    }
                  }),
                  child: Text(
                    "Hi, ${widget.name}",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold
                    )
                  )
                ),
                Expanded(
                  child: provider.list.isNotEmpty ? ListView.separated(
                    separatorBuilder: (_, __) => SizedBox(height: 5),
                    itemCount: provider.list.length,
                    itemBuilder: (_, index) => TodoCard(
                      data: provider.list[index],
                      onMarkDone: (id) async {
                        final result = await provider.mark(id: id);
                        if (result) provider.getList(name: widget.name);
                      },
                      onRemove: (id) async {
                        final result = await provider.remove(id: id);
                        if (result) provider.getList(name: widget.name);
                      }
                    )
                  ) : Center(
                    child: Text("You don't have any Todos"),
                  )
                )
              ]
            )
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => showDialog<Todo>(
              context: context,
              builder: (_) => AddTodoDialog(name: widget.name)
            ).then((value) {
              if (value != null) {
                provider.add(data: value);
              }
            }),
            child: const Icon(Icons.add)
          )
        )
      )
    );
  }
}