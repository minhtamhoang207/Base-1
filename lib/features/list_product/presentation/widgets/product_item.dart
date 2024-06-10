import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:base_1/core/config/app_colors.dart';
import 'package:base_1/features/list_product/domain/entites/product.dart';
import 'package:base_1/features/list_product/presentation/bloc/list_product_bloc.dart';
import 'package:base_1/features/list_product/presentation/widgets/image_placeholder.dart';

class ProductItem extends StatelessWidget {
  final Product? product;
  final void Function()? onPressEdit;
  final bool isEdit;
  const ProductItem({
    Key? key,
    this.product,
    this.onPressEdit,
    this.isEdit = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListProductBloc, ListProductState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(bottom: 24),
          decoration: BoxDecoration(
            color: product?.id != state.productHasError
                ? AppColors.white
                : AppColors.red.withOpacity(0.03),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: product?.id != state.productHasError
                  ? Colors.transparent
                  : AppColors.red,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: product?.image ?? '',
                    imageBuilder: (context, imageProvider) => Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => const ImagePlaceHolder(),
                    errorWidget: (context, url, error) =>
                        const ImagePlaceHolder(),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product?.name ?? '',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'SKU: ${product?.sku ?? ''}',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: isEdit ? 18 : 0),
                  Visibility(
                    visible: isEdit,
                    child: InkWell(
                      onTap: onPressEdit,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.orange.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: AppColors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: AppColors.red,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    product?.errorDescription ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.red,
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: product?.color != null,
                child: Divider(
                  color: AppColors.black.withOpacity(0.1),
                ),
              ),
              Visibility(
                visible: product?.color != null,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text(
                          product?.productColor?.name ?? '',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Visibility(
                        visible: product?.hexColor != null,
                        child: Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                            color: product?.hexColor,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.black.withOpacity(0.6),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
