//
//  Czh_LoginTextField.m
//  ZhiHuiGu
//
//  Created by 阿木 on 2018/9/27.
//  Copyright © 2018年 阿木. All rights reserved.
//

#import "Czh_LoginTextField.h"

@implementation Czh_LoginTextField
- (instancetype)initWithFrame:(CGRect)frame placeHolder:(NSString *)placeHolder boolLeftView:(BOOL)flag rightTitle:(NSString *)title{
    if (self = [super initWithFrame:frame]) {
        self.placeholder = placeHolder;
        self.borderStyle = UITextBorderStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        self.textAlignment = NSTextAlignmentLeft;
        //键盘外观
        self.keyboardAppearance=UIKeyboardAppearanceDefault;
        //输入框中是否有个叉号，在什么时候显示，用于一次性删除输入框中的内容
        self.clearButtonMode = UITextFieldViewModeAlways;
        //设置字体颜色
        self.textColor = [UIColor blackColor];
        self.layer.borderColor= [UIColor grayColor].CGColor;
        self.layer.borderWidth= 0.5f;
        //设置边框样式，只有设置了才会显示边框样式
        self.borderStyle = UITextBorderStyleRoundedRect;
        self.layer.cornerRadius = 8;
        self.clearButtonMode = UITextFieldViewModeAlways;
        self.font = [UIFont systemFontOfSize:16];
        //CGRectMake(0, 0,15, 0)离上下左右的距离
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 0)];
        self.leftView = paddingView;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        if (flag) {
            UIButton *rBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width/2-self.frame.size.width/5, self.frame.size.height)];
            [rBtn setTitle:title forState:UIControlStateNormal];
            [rBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            rBtn.titleLabel.font = [UIFont systemFontOfSize: 16.0f];
            rBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
            _rBtn = rBtn;
            self.rightView = _rBtn;
            self.rightViewMode = UITextFieldViewModeAlways;
        }
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame PlaceHolder:(NSString *)placeHolder LeftViewImage:(NSString *)leftViewImageName{
    if (self = [super initWithFrame:frame]) {
        self.placeholder = placeHolder;
        self.keyboardType = UIKeyboardTypeDecimalPad;
        self.borderStyle = UITextBorderStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        self.textAlignment = NSTextAlignmentLeft;
        //键盘外观
        self.keyboardAppearance=UIKeyboardAppearanceDefault;
        //输入框中是否有个叉号，在什么时候显示，用于一次性删除输入框中的内容
        self.clearButtonMode = UITextFieldViewModeAlways;
        //设置字体颜色
        self.textColor = [UIColor blackColor];
        self.layer.borderColor= [UIColor grayColor].CGColor;
        self.layer.borderWidth= 0.5f;
        //设置边框样式，只有设置了才会显示边框样式
        self.borderStyle = UITextBorderStyleRoundedRect;
        self.layer.cornerRadius = 8;
        self.clearButtonMode = UITextFieldViewModeAlways;
        self.font = [UIFont systemFontOfSize:16];
        
        //
        UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        leftView.backgroundColor = [UIColor lightGrayColor];
        leftView.contentMode = UIViewContentModeCenter;
        leftView.image = [UIImage imageNamed:leftViewImageName];
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}


@end
