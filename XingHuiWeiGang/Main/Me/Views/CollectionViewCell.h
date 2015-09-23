//
//  CollectionViewCell.h
//  XingHuiWeiGang
//
//  Created by zx on 15/8/6.
//  Copyright (c) 2015年 zxl－mac1. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CollectionModel;
typedef void (^updateAttentionBolck)(BOOL isDish,BOOL isSuceess);
@interface CollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *cacelButton;
@property(nonatomic,copy) updateAttentionBolck block;
@property (nonatomic,strong) CollectionModel *collectionModel;
@end