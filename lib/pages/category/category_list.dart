import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mtoybox/components/category/category_label.dart';
import 'package:mtoybox/components/common/button/delete_icon_button.dart';
import 'package:mtoybox/components/common/button/edit_icon_button.dart';
import 'package:mtoybox/components/common/button/floating_add_button.dart';
import 'package:mtoybox/components/common/button/sort_button.dart';
import 'package:mtoybox/modules/domain/model/article/article.dart';
import 'package:mtoybox/modules/domain/model/category/categories.dart';
import 'package:mtoybox/modules/domain/model/category/catetory.dart';
import 'package:mtoybox/modules/interface/provider_factory.dart';
import 'package:mtoybox/pages/category/cateogory_create.dart';

class CategoryList extends ConsumerStatefulWidget {
  const CategoryList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _CategoryListState();
  }
}

class _CategoryListState extends ConsumerState {
  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoryRepositoryProvider);
    final articles = ref.watch(articleRepositoryProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('できごと・なかま'),
      ),
      body: createListView(categories, articles),
      floatingActionButton: FloatingAddButton(onPressed: () => add(context)),
    );
  }

  createListView(Categories categories, List<Article> articles) {
    return ListView(
        children: categories.asList().map((category) {
      final usageCount =
          articles.where((element) => element.categoryId == category.id).length;
      return Row(
        children: [
          CategoryLabel(category, usageCount: usageCount),
          const Spacer(),
          EditIconButton(() {
            edit(context, category);
          }),
          DeleteIconButton(
            () {
              delete(context, category);
            },
            disabled: usageCount >= 1,
          )
        ],
      );
    }).toList());
  }

  add(BuildContext context) async {
    Navigator.of(context).push(
        MaterialPageRoute(builder: ((context) => const CategoryCreate())));
  }

  edit(BuildContext context, Category category) async {
    Navigator.of(context).push(
        MaterialPageRoute(builder: ((context) => const CategoryCreate())));
  }

  delete(BuildContext context, Category category) async {
    Navigator.of(context).push(
        MaterialPageRoute(builder: ((context) => const CategoryCreate())));
  }
}
