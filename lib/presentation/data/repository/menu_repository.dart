import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/gr_topping_request.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/gr_topping_response.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/linkfood_request.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/linkfood_response.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/list_menu_food_request.dart';

import '../model/menu/list_menu_food_response.dart';
import '../utils.dart';

mixin AuthUrl {
  static const String optionGroup = "/api/v1/merchant/option-groups";
  static const String productCategories = "/api/v1/merchant/product-categories";
  static const String products = "/api/v1/merchant/products";
}

abstract class MenuRepository {
  Future<GrAddToppingResponse?> addGroupTopping(GrToppingRequest request,
      {int? id});
  Future<LinkfoodResponse?> getListMenu(LinkFoodRequest request);
  Future<GetGrToppingResponse?> getGroupTopping(GetGroupToppingRequest request);
  Future<ListMenuFoodResponse?> detailFoodByMenu(ListMenuFoodRequest request);
  // Future<GrAddToppingResponse?> editGroupTopping(
  //     {required GrToppingRequest request, required int id});
}

class MenuRepositoryImp implements MenuRepository {
  final DioUtil _clientDio;
  MenuRepositoryImp(this._clientDio);

  @override
  Future<GrAddToppingResponse?> addGroupTopping(GrToppingRequest request,
      {int? id}) async {
    try {
      if (id != null) {
        final httpRequest = await _clientDio.patch("${AuthUrl.optionGroup}/$id",
            data: request.removeNullValues());
        return GrAddToppingResponse.fromJson(httpRequest.data ?? {});
      } else {
        final httpRequest = await _clientDio.post(AuthUrl.optionGroup,
            data: request.removeNullValues(), isTranformData: true);
        return GrAddToppingResponse.fromJson(httpRequest.data ?? {});
      }
    } on DioException catch (_) {
      rethrow;
    } catch (e) {
      throw Exception('Unknown error');
    }
  }

  @override
  Future<LinkfoodResponse?> getListMenu(LinkFoodRequest request) async {
    try {
      final httpRequest = await _clientDio.get(AuthUrl.productCategories,
          queryParameters: request.removeNullValues());
      return LinkfoodResponse.fromJson(httpRequest.data ?? {});
    } on DioException catch (_) {
      rethrow;
    } catch (e) {
      log("getListMenu error: $e");
      // throw Exception('Unknown error');
    }
    return null;
  }

  @override
  Future<GetGrToppingResponse?> getGroupTopping(
      GetGroupToppingRequest request) async {
    try {
      final httpRequest = await _clientDio.get(AuthUrl.optionGroup,
          queryParameters: request.removeNullValues());
      return GetGrToppingResponse.fromJson(httpRequest.data ?? {});
    } on DioException catch (_) {
      rethrow;
    } catch (e) {
      log("getListMenu error: $e");
    }
    return null;
  }

  @override
  Future<ListMenuFoodResponse?> detailFoodByMenu(
      ListMenuFoodRequest request) async {
    try {
      final httpRequest = await _clientDio.get(AuthUrl.products,
          queryParameters: request.removeNullValues());
      return ListMenuFoodResponse.fromJson(httpRequest.data ?? {});
    } on DioException catch (_) {
      rethrow;
    } catch (e) {
      log("detailFoodByMenu error: $e");
    }
    return null;
  }

  // @override
  // Future<GrAddToppingResponse?> editGroupTopping(
  //     {required GrToppingRequest request, required int id}) async {
  //   try {
  //     final httpRequest = await _clientDio.patch("${AuthUrl.optionGroup}/$id",
  //         data: request.removeNullValues());
  //     return GrAddToppingResponse.fromJson(httpRequest.data ?? {});
  //   } on DioException catch (_) {
  //     rethrow;
  //   } catch (e) {
  //     log("editGroupTopping error: $e");
  //   }
  //   return null;
  // }
}
