
import '../../../../core/domin/model/discount_model/discount_model.dart';

class DiscountState  {
  const DiscountState();


}

final class DiscountInitial extends DiscountState {}

class GetAllDiscountSuccessState extends DiscountState {
  final List<DiscountModel> discount;

  GetAllDiscountSuccessState({required this.discount});
}

class GetAllDiscountLoadingState extends DiscountState {}

class GetAllDiscountFeildState extends DiscountState {}
