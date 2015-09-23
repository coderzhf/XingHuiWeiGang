//
//  SearchListView.m
//  XingHuiWeiGang
//
//  Created by 张锋 on 15/7/23.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import "SearchListView.h"
@interface SearchListView ()

@end
@implementation SearchListView

+ (instancetype)listView {
    return [[[NSBundle mainBundle]loadNibNamed:@"SearchListView" owner:self options:nil]firstObject];
}
- (IBAction)dishButtonClick {
    [[NSNotificationCenter defaultCenter] postNotificationName:SearchOptionNotification object:nil userInfo:@{SearchOptionName:@"菜品"}];

}
- (IBAction)businessButtonClick {
    [[NSNotificationCenter defaultCenter] postNotificationName:SearchOptionNotification object:nil userInfo:@{SearchOptionName:@"店铺"}];
}


@end
