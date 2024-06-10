import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:base_1/core/config/app_colors.dart';
import 'package:base_1/core/injection/injection.dart';
import 'package:base_1/features/list_product/domain/entites/product.dart';
import 'package:base_1/features/list_product/domain/repositories/product_repository.dart';
import 'package:base_1/features/list_product/presentation/bloc/list_product_bloc.dart';
import 'package:base_1/features/list_product/presentation/widgets/edit_product_bottom_sheet.dart';
import 'package:base_1/features/list_product/presentation/widgets/product_item.dart';
import 'package:base_1/features/list_product/presentation/widgets/submit_changes_dialog.dart';

class ListProductRoute extends StatelessWidget {
  const ListProductRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ListProductBloc(getIt<ProductRepository>()),
      child: const ListProductScreen(),
    );
  }
}

class ListProductScreen extends StatefulWidget {
  const ListProductScreen({Key? key}) : super(key: key);

  @override
  State<ListProductScreen> createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> {
  late final ListProductBloc _productBloc;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final AutoScrollController _scrollController = AutoScrollController();

  @override
  void initState() {
    _productBloc = context.read<ListProductBloc>()
      ..add(
        GetProductEvent(page: 1),
      );
    super.initState();
  }

  void _onRefresh() async {
    if (_productBloc.isClosed) return;

    _productBloc.add(GetProductEvent(page: 1));
  }

  void _onLoading() async {
    _productBloc.add(LoadMoreProductEvent());
  }

  void _moveToTop() {
    _refreshController.position!.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      floatingActionButton: _buttonMoveToTop(),
      body: BlocConsumer<ListProductBloc, ListProductState>(
        listener: (context, state) {
          if (state.status == GetProductStatus.success ||
              state.status == GetProductStatus.error) {
            _refreshController.refreshCompleted();
            _refreshController.loadComplete();
          }
        },
        builder: (context, state) {
          if (state.status == GetProductStatus.initial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status == GetProductStatus.error) {
            return const Center(child: Icon(Icons.error, color: AppColors.red));
          }
          return SmartRefresher(
            controller: _refreshController,
            enablePullDown: true,
            enablePullUp: state.canLoadMore ?? false,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: state.listProduct.isEmpty
                ? Center(
                    child: Text(
                      'No data available',
                      style: TextStyle(
                        color: AppColors.black.withOpacity(0.8),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: state.listProduct.length,
                    controller: _scrollController,
                    padding: const EdgeInsets.all(20),
                    itemBuilder: (BuildContext context, int index) {
                      final product = state.listProduct[index];
                      return AutoScrollTag(
                        key: ValueKey(index),
                        controller: _scrollController,
                        index: index,
                        child: ProductItem(
                          product: product,
                          onPressEdit: () => _onPressEdit(context, product),
                        ),
                      );
                    },
                  ),
          );
        },
      ),
      bottomNavigationBar: _submitButton(),
    );
  }

  PreferredSizeWidget _appbar() {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      centerTitle: true,
      title: BlocBuilder<ListProductBloc, ListProductState>(
        builder: (context, state) {
          return Text(
            'Product list | page: ${state.page} | total: ${state.listProduct.length}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          );
        },
      ),
    );
  }

  void _showSubmitDialog() {
    final itemErrorIndex = _productBloc.findIndexEmptyNameOrSku();
    _productBloc.add(OnTapSubmitEvent());
    if (itemErrorIndex != -1) {
      _scrollController.scrollToIndex(
        itemErrorIndex,
        preferPosition: AutoScrollPosition.begin,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in the product name and sku'),
        ),
      );
      return;
    } else {
      showGeneralDialog(
        context: context,
        barrierLabel: "Barrier",
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
        transitionDuration: const Duration(milliseconds: 250),
        pageBuilder: (_, __, ___) {
          return BlocProvider.value(
            value: _productBloc,
            child: const SubmitChangesDialog(),
          );
        },
        transitionBuilder: (_, anim, __, child) {
          Tween<Offset> tween;
          if (anim.status == AnimationStatus.reverse) {
            tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
          } else {
            tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
          }

          return SlideTransition(
            position: tween.animate(anim),
            child: FadeTransition(
              opacity: anim,
              child: child,
            ),
          );
        },
      );
    }
  }

  void _onPressEdit(BuildContext context, Product product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) {
        return BlocProvider.value(
          value: _productBloc,
          child: EditProductBottomSheet(product: product),
        );
      },
    );
  }

  Widget _buttonMoveToTop() {
    return BlocBuilder<ListProductBloc, ListProductState>(
      builder: (context, state) {
        return Visibility(
          visible: _productBloc.state.listProduct.isNotEmpty,
          child: FloatingActionButton(
            tooltip: 'Move to top',
            onPressed: () => _moveToTop(),
            backgroundColor: AppColors.black.withOpacity(0.9),
            child:
                const Icon(Icons.arrow_upward_outlined, color: AppColors.white),
          ),
        );
      },
    );
  }

  Widget _submitButton() {
    return BlocBuilder<ListProductBloc, ListProductState>(
      builder: (context, state) {
        return Visibility(
          visible: _productBloc.state.listProduct.isNotEmpty,
          child: Container(
            height: 75,
            color: AppColors.white,
            margin: const EdgeInsets.only(top: 8, bottom: 16),
            child: GestureDetector(
              onTap: _showSubmitDialog,
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.orange,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    'SUBMIT',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
