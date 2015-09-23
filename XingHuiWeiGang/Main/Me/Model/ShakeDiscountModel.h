//
//  ShakeDiscountModel.h
//  XingHuiWeiGang
//
//  Created by zx on 15/8/24.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "BaseModel.h"
// {"code":0,"list":[{"couponId":1,"couponType":"25","denomination":100,"discount":1,"endTime":"2015-08-31","imgUrl":"upload/images/couponImg/1439434053001_20150813102218.png","isValid":false,"serialNumber":"155166","shopId":0,"startTime":"2015-08-01","useCondition":100},{"couponId":17,"couponType":"24","denomination":20,"discount":1,"endTime":"2015-09-03","imgUrl":"upload/images/couponImg/1439432576618_20150813101857.png","isValid":false,"serialNumber":"1","shopId":0,"startTime":"2015-08-13","useCondition":1},{"couponId":18,"couponType":"26","denomination":0,"discount":0.75,"endTime":"2015-09-04","imgUrl":"upload/images/couponImg/1439434141391_20150813102112.png","isValid":false,"serialNumber":"asdasd","shopId":0,"startTime":"2015-08-14","useCondition":1},{"couponId":20,"couponType":"24","denomination":100,"discount":1,"endTime":"2015-08-29","imgUrl":"upload/images/couponImg/largerimg/1440165427274_s.jpg","isValid":false,"shopId":0,"startTime":"2015-08-21","useCondition":1},{"couponId":21,"couponType":"24","denomination":1000,"discount":1,"endTime":"2015-09-05","imgUrl":"upload/images/couponImg/largerimg/1440165681222_s.jpg","isValid":false,"shopId":0,"startTime":"2015-08-21","useCondition":1},{"couponId":22,"couponType":"25","denomination":500,"discount":1,"endTime":"2015-09-04","imgUrl":"upload/images/couponImg/largerimg/1440165830009_s.jpg","isValid":false,"shopId":0,"startTime":"2015-08-21","useCondition":100}],"msg":"查看成功"}
@interface ShakeDiscountModel : BaseModel

@property (nonatomic ,strong) NSNumber *couponId;//优惠券编号
@property (nonatomic ,strong) NSNumber *shopId;//商铺编号
@property (nonatomic ,strong) NSNumber *denomination;//面额
@property (nonatomic ,strong) NSNumber *serialNumber;//优惠券串号
@property (nonatomic ,strong) NSNumber *useCondition;//已经使用的数量
@property (nonatomic ,strong) NSString *endTime;//结束时间
@property (nonatomic ,strong) NSString *imgUrl;//图片地址
@property (nonatomic ,assign) BOOL isValid;//是否有效
@property (nonatomic ,strong) NSString *startTime;//开始时间

@end
