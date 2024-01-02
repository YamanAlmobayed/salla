import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salla/repository/models/home_model.dart';
import 'package:salla/repository/shop_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.shopRepository}) : super(HomeInitial());
  final ShopRepository shopRepository;

  void getHomeData() async {
    emit(GetHomeLoading());
    try {
      final homeData = await shopRepository.getHomeData();
      emit(GetHomeSuccess(homeData));
    } catch (e) {
      emit(GetHomeError(e.toString()));
    }
  }
}
