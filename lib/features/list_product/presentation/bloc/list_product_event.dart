part of 'list_product_bloc.dart';

abstract class ProductEvent extends Equatable {}

class GetProductEvent extends ProductEvent {
  final int page;

  GetProductEvent({required this.page});

  @override
  List<Object?> get props => [page];
}

class LoadMoreProductEvent extends ProductEvent {
  @override
  List<Object?> get props => [];
}

class GetColorEvent extends ProductEvent {
  @override
  List<Object?> get props => [];
}

class EditProductEvent extends ProductEvent {
  final Product product;

  EditProductEvent({required this.product});
  @override
  List<Object?> get props => [product];
}

class OnTapSubmitEvent extends ProductEvent {
  OnTapSubmitEvent();
  @override
  List<Object?> get props => [];
}
