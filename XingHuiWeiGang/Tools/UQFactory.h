//
//  UQFactory.h
//  UQPlatformSDK
//
//  Created by Dyfei on 14/10/23.
//  Copyright (c) 2014年 UQ Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface UQFactory : NSObject

/**
 *  @brief  创建View
 *  @param  frame    坐标大小
 *  @param  bgColor  背影颜色
 *  @return view
 */
+ (UIView *)viewWithFrame:(CGRect)frame backgroundColor:(UIColor *)bgColor;

/**
 *  @brief  创建Label
 *  @param  frame    坐标大小
 *  @param  text     输入文本
 *  @return label
 */
+ (UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text;

/**
 *  @brief  创建Label
 *  @param  frame    坐标和大小
 *  @param  text     输入文本
 *  @param  color    文本颜色
 *  @param  name     字体名称
 *  @param  size     字体大小
 *  @param  center   文字是否居中
 *  @return label
 */
+ (UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)color fontSize:(CGFloat)size center:(BOOL)center;


/**
 *  @brief  产生Button
 *  @param  frame            坐标和大小
 *  @param  image            图片
 *  @param  title            标题
 *  @param  color            标题颜色
 *  @param  name             字体名称
 *  @param  size             字体大小
 *  @return button
 */
+ (UIButton *)buttonWithFrame:(CGRect)frame image:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)color fontSize:(CGFloat)size;

/**
 *  @brief  创建Button
 *  @param  frame              坐标和大小
 *  @param  bgImage            背景图片
 *  @return button
 */
+ (UIButton *)buttonWithFrame:(CGRect)frame backgroundImage:(UIImage *)bgImage;

/**
 *  @brief  创建ImageView
 *  @param  frame        坐标大小
 *  @param  image        图片
 *  @return imageView
 */
+ (UIImageView *)imageViewWithFrame:(CGRect)frame image:(UIImage *)image;

/**
 *  @brief  创建ImageView
 *  @param  frame         坐标大小
 *  @param  image         图片
 *  @param  contentMode   填充模式
 *  @param  enabled       用户交互是否打开
 *  @return imageView
 */
+ (UIImageView *)imageViewWithFrame:(CGRect)frame image:(UIImage *)image contentMode:(NSInteger)contentMode userInteractionEnabled:(BOOL)enabled;

/**
 *  @brief  创建TextField
 *  @param  frame         坐标大小
 *  @param  placeholder   默认文本
 *  @param  text          输入文本
 *  @param  borderStyle   样式
 *  @param  bgColor       背景颜色
 *  @param  delegate      代理对象
 *  @return textField
 */
+ (UITextField *)textFieldWithFrame:(CGRect)frame placeholder:(NSString *)placeholder text:(NSString *)text borderStyle:(NSInteger)borderStyle backgroundColor:(UIColor *)bgColor center:(BOOL )center  delegate:(id)delegate;

/**
 *  @brief  创建TextField
 *  @param  frame         坐标大小
 *  @param  placeholder   默认文本
 *  @param  text          输入文本
 *  @param  borderStyle   样式
 *  @param  bgColor       背景颜色
 *  @param  delegate      代理对象
 *  @param  returnKeyType 键盘上返回键的样式
 *  @param  keyboardType  键盘样式
 *  @param  fontName      字体名称
 *  @param  fontSize      字体大小
 *  @param  secure        设置安全输入
 *  @return textField
 */
+ (UITextField *)textFieldWithFrame:(CGRect)frame placeholder:(NSString *)placeholder text:(NSString *)text borderStyle:(NSInteger)borderStyle backgroundColor:(UIColor *)bgColor center:(BOOL )center  delegate:(id)delegate returnKeyType:(NSInteger)returnKeyType keyboardType:(NSInteger)keyboardType fontSize:(CGFloat)fontSize secure:(BOOL)secure;

/**
 *	@brief	创建textView
 *	@param 	frame       坐标大小
 *	@param 	text        文本
 *	@param 	isEditable 	是否可编辑
 *	@return	textView
 */
+ (UITextView *)textViewWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font isEditable:(BOOL)isEditable;

+ (UISegmentedControl *)segmentWithFrame:(CGRect)frame items:(NSArray *)items;

@end
