//
//  UQFactory.m
//  UQPlatformSDK
//
//  Created by Dyfei on 14/10/23.
//  Copyright (c) 2014年 UQ Interactive. All rights reserved.
//

#import "UQFactory.h"

#if __has_feature(objc_arc)
#define AUTORELEASE(xx) xx
#else
#define AUTORELEASE(xx) [xx autorelease]
#endif

#define kDefaultSize 14

#define OS_Version [[[UIDevice currentDevice] systemVersion] floatValue]

@implementation UQFactory

+ (UIView *)viewWithFrame:(CGRect)frame backgroundColor:(UIColor *)bgColor
{
    UIView *view = AUTORELEASE([[UIView alloc] init]);
    [view setFrame:frame];
    [view setBackgroundColor:bgColor];
    return view;
}

+ (UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text
{
    return [self labelWithFrame:frame text:text textColor:[UIColor whiteColor]  fontSize:kDefaultSize center:YES];
}

+ (UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)color fontSize:(CGFloat)size center:(BOOL)center
{
    UILabel *label = AUTORELEASE([[UILabel alloc] init]);
    label.frame = frame;
    label.text = text;
    label.textColor = color;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:size];
    if (center) {
        label.textAlignment = NSTextAlignmentCenter;
    } else {
        label.textAlignment = NSTextAlignmentLeft;
    }
    return label;
}

+ (UIButton *)buttonWithFrame:(CGRect)frame image:(UIImage *)image  title:(NSString *)title titleColor:(UIColor *)color fontSize:(CGFloat)size
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    if (image) {
        [button setBackgroundImage:image forState:UIControlStateNormal];
    }
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:size];
    return button;
}

+ (UIButton *)buttonWithFrame:(CGRect)frame backgroundImage:(UIImage *)bgImage
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    if (bgImage) {
        [button setBackgroundImage:bgImage forState:UIControlStateNormal];
    }
     return button;
}

+ (UIImageView *)imageViewWithFrame:(CGRect)frame image:(UIImage *)image
{
    return [self imageViewWithFrame:frame image:image contentMode:UIViewContentModeScaleToFill userInteractionEnabled:YES];
}

+ (UIImageView *)imageViewWithFrame:(CGRect)frame image:(UIImage *)image contentMode:(NSInteger)contentMode userInteractionEnabled:(BOOL)enabled
{
    UIImageView *imageView = AUTORELEASE([[UIImageView alloc] init]);
    imageView.frame = frame;
    if (image) {
        imageView.image = image;
    }
    imageView.contentMode = contentMode;
    if (enabled) {
        imageView.userInteractionEnabled = YES;
    }
    return imageView;
}

+ (UITextField *)textFieldWithFrame:(CGRect)frame placeholder:(NSString *)placeholder text:(NSString *)text borderStyle:(NSInteger)borderStyle backgroundColor:(UIColor *)bgColor center:(BOOL )center delegate:(id) delegate
{
    return [self textFieldWithFrame:frame placeholder:placeholder text:text borderStyle:borderStyle backgroundColor:bgColor center:center  delegate:delegate returnKeyType:UIReturnKeyDefault keyboardType:UIKeyboardTypeDefault  fontSize:kDefaultSize secure:NO];
}

+ (UITextField *)textFieldWithFrame:(CGRect)frame placeholder:(NSString *)placeholder text:(NSString *)text borderStyle:(NSInteger)borderStyle backgroundColor:(UIColor *)bgColor center:(BOOL )center delegate:(id)delegate returnKeyType:(NSInteger)returnKeyType keyboardType:(NSInteger)keyboardType fontSize:(CGFloat)fontSize secure:(BOOL)secure
{
    UITextField *textField = AUTORELEASE([[UITextField alloc] init]);
    textField.frame = frame;
    textField.placeholder = placeholder;
    textField.textColor = [UIColor darkGrayColor];
    textField.font = [UIFont systemFontOfSize:12];
    textField.text = text;
    textField.delegate = delegate;
    textField.borderStyle = borderStyle;
    textField.backgroundColor = bgColor;
    textField.returnKeyType = returnKeyType;
    textField.keyboardType = keyboardType;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    if (center) {
        textField.textAlignment = NSTextAlignmentCenter;
    }else{
        textField.textAlignment = NSTextAlignmentLeft;
    }
    if (secure) {
        textField.secureTextEntry = YES;
    }
        textField.font = [UIFont systemFontOfSize:fontSize];
    return textField;
}

+ (UITextView *)textViewWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font isEditable:(BOOL)isEditable
{
    UITextView *textView = AUTORELEASE([[UITextView alloc] init]);
    textView.frame = frame;
    textView.font = font;
    textView.text = text;
    textView.editable = isEditable;
    return textView;
}

+ (UISegmentedControl *)segmentWithFrame:(CGRect)frame items:(NSArray *)items
{
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:items];
    segment.tintColor = [UIColor clearColor];
    [segment setBackgroundImage:KImage(@"login_regist_button") forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    segment.frame = frame;
    segment.selectedSegmentIndex = 0;
    NSDictionary *dicSelect = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:nil size:16.f],NSFontAttributeName, nil];
    [segment setTitleTextAttributes:dicSelect forState:UIControlStateSelected];
    [segment setBackgroundImage:KImage(@"login_button") forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    NSDictionary *dicunSelect = [NSDictionary dictionaryWithObjectsAndKeys:YXRGB(210, 105, 30),NSForegroundColorAttributeName,[UIFont fontWithName:nil size:16.f],NSFontAttributeName, nil];
    [segment setTitleTextAttributes:dicunSelect forState:UIControlStateNormal];
    
    [segment setTitle:items[0] forSegmentAtIndex:0];
    [segment setTitle:items[1] forSegmentAtIndex:1];

    return segment;
}
@end
