import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/presentation/data/model/store/store_model.dart';
import 'package:oneship_merchant_app/presentation/page/store/store_page.dart';
import 'package:oneship_merchant_app/presentation/widget/images/network_image_loader.dart';
import 'package:oneship_merchant_app/presentation/widget/widget.dart';

class StoreItem extends StatelessWidget {
  final StoreModel data;
  const StoreItem({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor2, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: data.storeAvatarId != null
                    ? SizedBox(
                        width: data.getSizeImage(),
                        height: data.getSizeImage(),
                        child: NetworkImageWithLoader(
                          "${EnvManager.shared.api}/api/v1/uploads/${data.storeAvatarId}",
                          fit: BoxFit.cover,
                          widgetErrorImage: ImageAssetWidget(
                            image: AppAssets.imagesStoreImageEmpty,
                            width: data.getSizeImage(),
                            height: data.getSizeImage(),
                          ),
                        ),
                      )
                    : ImageAssetWidget(
                        image: AppAssets.imagesStoreImageEmpty,
                        width: data.getSizeImage(),
                        height: data.getSizeImage(),
                      ),
              ),
              const SizedBox(
                width: 12,
              ),
              Flexible(
                child: SizedBox(
                  height: data.getSizeImage(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        data.name ?? '',
                        maxLines: 2,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      data.approvalStatus == EStoreApprovalStatus.draft
                          ? Column(
                              children: [
                                LinearProgressIndicator(
                                  borderRadius: BorderRadius.circular(100),
                                  minHeight: 8,
                                  value: 0.3,
                                  backgroundColor: AppColors.borderColor2,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                          AppColors.primary),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                StoreStatusWidget(
                                  status: data.status ?? '',
                                  approvalStatus: data.approvalStatus ?? '',
                                  reason: data.rejectReason,
                                ),
                              ],
                            )
                          : StoreStatusWidget(
                              status: data.status ?? '',
                              approvalStatus: data.approvalStatus ?? '',
                              reason: data.rejectReason,
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height:
                data.getButtonType() != EStoreButtonType.none ? 14.sp : 8.sp,
          ),
          const DottedLine(
            dashColor: AppColors.borderColor2,
            dashGapLength: 4,
            dashLength: 4,
            lineThickness: 1,
          ),
          SizedBox(
            height: 8.sp,
          ),
          Visibility(
            visible: data.getButtonType() == EStoreButtonType.none,
            replacement: SizedBox(
              width: Get.width,
              child: Row(
                children: [
                  if (data.getButtonType() == EStoreButtonType.continueButton)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //show dropdown delete
                        GestureDetector(
                          child: const ImageAssetWidget(
                              image: AppAssets.imagesIconsDotsHorizontal,
                              width: 24,
                              height: 24),
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  padding: const EdgeInsets.only(
                                    top: 12,
                                    bottom: 24,
                                  ),
                                  color: Colors.white,
                                  child: Wrap(
                                    children: <Widget>[
                                      ListTile(
                                        leading: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        title: const Text('Xóa cửa hàng'),
                                        onTap: () {
                                          Get.back();
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    'Xác nhận xóa cửa hàng'),
                                                content: const Text(
                                                    'Bạn có chắc chắn muốn xóa cửa hàng này không?'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                    child: const Text('No',
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .primary)),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                    child: const Text('Yes',
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .primary)),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Container(
                          width: 1,
                          height: 24,
                          color: AppColors.borderColor2,
                        ),
                      ],
                    ),
                  Spacer(),
                  Text(
                    data.getButtonText(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 12.sp,
                          color: AppColors.primary,
                        ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            child: Text(
              data.getAddress(),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 12.sp,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}