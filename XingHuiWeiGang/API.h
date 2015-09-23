
//
//  API.h
//  XingHuiWeiGang
//
//  Created by zx on 15/7/17.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

//ZmAppAley20131108
#ifndef XingHuiWeiGang_API_h
#define XingHuiWeiGang_API_h
//  http://120.24.178.53/hotelCashier/    http://120.24.178.53/hotelPlatForm/
//115.28.161.246  192.168.100.152:8080  192.168.123.152  http://192.168.100.152:8080/hotelCashier/front/ http://192.168.100.222:8080/hotelPlatForm/
#define kCommon      @"http://192.168.100.152:8080/hotelCashier/front/"
//图片绝对路径
#define PicPath @"http://192.168.100.222:8080/hotelPlatForm/"

#define kCommomAction(args) [kCommon stringByAppendingString: args]

//上传头像
#define kImageUpload kCommomAction(@"fileUpload.htm")
//登录
#define Klogin       kCommomAction(@"userAct.htm?&operate=login")
//找回密码
#define KfindPwd     kCommomAction(@"userAct.htm?&operate=findPwd")
//验证手机号是否可用
#define KshowUser    kCommomAction(@"userAct.htm?&operate=showUser")
//短信验证
#define KgetCode     kCommomAction(@"sendTemplateSmsAct.htm")
//注册
#define Kreg         kCommomAction(@"userAct.htm?&operate=reg")
//完善用户
#define KperfectUser kCommomAction(@"userAct.htm?&operate=perfectUser")
//微信登录
#define KloginWx     kCommomAction(@"userAct.htm?&operate=loginWx")
//修改登录密码
#define Kupdatepwd   kCommomAction(@"userAct.htm?&operate=updatePwd")
//修改支付密码
#define KupdatePayPwd   kCommomAction(@"userAct.htm?&operate=updatePayPwd")

//搜索选择通知
#define SearchOptionNotification @"SearchOptionNotification"
#define SearchOptionName @"SearchOptionName"

//2.1类型
#define showSysType  kCommomAction(@"helpAction.htm?&operate=showSysType")
//2.2意见反馈
#define addFeedBack  kCommomAction(@"helpAction.htm?&operate=addFeedBack")
//2.3显示公告
#define showBulletin  kCommomAction(@"helpAction.htm?&operate=showBulletin")
//3.1菜系
#define showCuisine  kCommomAction(@"cuisineAction.htm?&operate=showCuisine")
//3.2菜品类型
#define showDishesType   kCommomAction(@"cuisineAction.htm?&operate=showDishesType")
//4.1显示菜式（模糊查询，条件查询）
#define showAllDishesInfo   kCommomAction(@"dishesInfoAction.htm?&operate=showAllDishesInfo")
//4.2显示菜品详情
#define showDishesInfo      kCommomAction(@"dishesInfoAction.htm?&operate=showDishesInfo")
//4.3摇一摇 摇到优惠券的接口，couponType返回24、25、26分别表示现金券、抵金券、折扣券
#define    yaoDishesInfo   kCommomAction(@"dishesInfoAction.htm?&operate=yaoDishesInfo")
//dishesInfoId=1
//5.1商户（模糊搜索）
#define showShop         kCommomAction(@"shopAct.htm?&operate=showShop")
//5.2显示店铺详情
#define findShop         kCommomAction(@"shopAct.htm?&operate=findShop")
//shopId=1
//6.1加入点菜车
#define addUserCart      kCommomAction(@"userCartsAction.htm?&operate=addUserCart")
//6.2删除点菜车
#define deleteUserCart   kCommomAction(@"userCartsAction.htm?&operate=deleteUserCart")
//6.3显示点菜车
#define showUserCart     kCommomAction(@"userCartsAction.htm?&operate=showUserCart")
//7.1评论
#define addComment       kCommomAction(@"commentAct.htm?&operate=addComment")
//7.2显示评论
#define showComment      kCommomAction(@"commentAct.htm?&operate=showComment")
//8.1添加关注
#define addUserAttention kCommomAction(@"userAttentionAction.htm?&operate=addUserAttention")
//8.2取消关注
#define updateUserAttention kCommomAction(@"userAttentionAction.htm?&operate=updateUserAttention")
//8.3显示我关注的菜品
#define showDishesAttention kCommomAction(@"userAttentionAction.htm?&operate=showDishes")
//8.4查看我关注的商铺
#define showShopAttention kCommomAction(@"userAttentionAction.htm?&operate=showShop")
//9.1排号
#define addWaitingNumber  kCommomAction(@"waitingNumberAction.htm?&operate=addWaitingNumber")
//9.2查看排号信息
#define showWaitingNumber  kCommomAction(@"waitingNumberAction.htm?&operate=showWaitingNumber")
//10.1下单预订（点菜车预订）
#define addOrder           kCommomAction(@"orderInfoAction.htm?&operate=addOrder")
//下单
#define addPtOrder         kCommomAction(@"orderInfoAction.htm?&operate=addPtOrder")
//10.2查看单个订单详情
#define showOrder          kCommomAction(@"orderInfoAction.htm?&operate=showOrder")
//10.3查看我的订单
#define showMyOrder        kCommomAction(@"orderInfoAction.htm?&operate=showMyOrder")
//10.4删除订单菜品
#define deleteDishes       kCommomAction(@"orderInfoAction.htm?&operate=deleteDishes")
//10.5取消已付款（申请退款）
#define deleteOrder       kCommomAction(@"orderInfoAction.htm?&operate=deleteOrder")
//10.6取消已待付款
#define updateOrder       kCommomAction(@"orderInfoAction.htm?&operate=updateOrder")
//10.7付款
#define payMoney       kCommomAction(@"orderInfoAction.htm?&operate=payMoney")
//10.8普通订单下单
#define addOrder         kCommomAction(@"orderInfoAction.htm?&operate=addOrder")
//10.9打包订单下单
#define addWmOrder         kCommomAction(@"orderInfoAction.htm?&operate=addWmOrder")
//10.10显示预订须知
#define showBookMsg kCommomAction(@"orderInfoAction.htm?&operate=showMsg")
//11.1点赞
#define addUserPraise      kCommomAction(@"userPraiseAct.htm?&operate=addUserPraise")
//13.1所有优惠券
#define   showAllCoupon      kCommomAction(@"couponInfoAction.htm?&operate=showAllCoupon")
//13.2我的优惠券
#define   showMyCoupon      kCommomAction(@"couponInfoAction.htm?&operate=showMyCoupon")
//13.3领取优惠券
#define   addMyCoupon      kCommomAction(@"couponInfoAction.htm?&operate=addMyCoupon")
//12.1查看我的消费记录
#define   showConsume      kCommomAction(@"consumeAct.htm?operate=showConsume")

#endif
