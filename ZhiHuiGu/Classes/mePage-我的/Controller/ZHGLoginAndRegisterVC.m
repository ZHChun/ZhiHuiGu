//
//  ZHGLoginAndRegisterVC.m
//  ZhiHuiGu
//
//  Created by 阿木 on 2018/9/27.
//  Copyright © 2018年 阿木. All rights reserved.
//

#import "ZHGLoginAndRegisterVC.h"
#import "ZHGLoginTextField.h"
#import "ZHGLoginBtn.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "ZHGRegisterVC.h"
#import "ZHGForgotPwVC.h"
#import "ZHGSMSOrPsdBtn.h"
#import "Czh_RegularVerification.h"
#import "ZHGTabBarController.h"

@interface ZHGLoginAndRegisterVC ()
{
    NSInteger _count;
    NSInteger _countN;//判断密码还是验证码
}
@property (nonatomic, strong) UILabel *appName;
//滚动视图
@property(nonatomic,strong)TPKeyboardAvoidingScrollView * contentScrollView;
//用户名
@property (nonatomic, strong) ZHGLoginTextField *nametextField;
//密码
@property (nonatomic, strong) ZHGLoginTextField *passwtextField;
//按钮
@property (nonatomic, strong) ZHGLoginBtn *loginBtn;

@property (nonatomic, strong) ZHGSMSOrPsdBtn *button;

@property (nonatomic, strong) ZHGSMSOrPsdBtn *regisBtn;

@end

@implementation ZHGLoginAndRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册 - 登录";
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setupView];
    _countN = 0;
}

-(void)setupView{
    TPKeyboardAvoidingScrollView * contentScrollView = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    [self.view addSubview:contentScrollView];
    _contentScrollView.bounces = NO;
    _contentScrollView.showsVerticalScrollIndicator = NO;
    _contentScrollView = contentScrollView;
    /**
     标题
     */
    UILabel *appName = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, Main_Screen_Width - 40, 40)];
    appName.text = @"智慧谷";
    appName.textColor = [UIColor blackColor];
    appName.textAlignment = NSTextAlignmentCenter;
    appName.font = [UIFont systemFontOfSize:30];
    [self.contentScrollView addSubview:appName];
    _appName = appName;
    //用户名（手机号）
    ZHGLoginTextField *nametextField = [[ZHGLoginTextField alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.appName.frame) + 40, Main_Screen_Width - 40, 44) placeHolder:@"请输入账号/手机号码" boolLeftView:NO rightTitle:nil];
    [self.contentScrollView addSubview:nametextField];
    _nametextField = nametextField;
    //密码
    ZHGLoginTextField *passwtextField = [[ZHGLoginTextField alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.self.nametextField.frame) + 30, Main_Screen_Width - 40, 44) placeHolder:@"请输入密码" boolLeftView:YES rightTitle:@"忘记密码"];
    [self.contentScrollView addSubview:passwtextField];
    _passwtextField = passwtextField;
    
    __weak __typeof(self)weakSelf = self;
    [self.passwtextField.rBtn setClickBlock:^(UIButton *button) {
        CZHLog(@"--------回调成功！");
        ZHGForgotPwVC * vc = [[ZHGForgotPwVC alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:true];
        // 需要执行的操作
    } andEvent:UIControlEventTouchUpInside];
    
    //按钮
    ZHGLoginBtn *loginBtn = [[ZHGLoginBtn alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.passwtextField.frame) + 30, Main_Screen_Width - 40, 44)];
    [loginBtn setTitle:@"登        录" forState:UIControlStateNormal];
    loginBtn.backgroundColor = MAIN_COLOR;
    [self.contentScrollView addSubview:loginBtn];
    _loginBtn = loginBtn;
    [self.loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    ZHGSMSOrPsdBtn *button = [[ZHGSMSOrPsdBtn alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.loginBtn.frame) + 10, Main_Screen_Width/2 - 40, 40) title:@"短信验证码登录"];
    [button addTarget:self action:@selector(buttonBackGroundNormal:) forControlEvents:UIControlEventTouchUpInside];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.contentScrollView addSubview:button];
    _button = button;
    
    ZHGSMSOrPsdBtn *regisBtn = [[ZHGSMSOrPsdBtn alloc] initWithFrame:CGRectMake(Main_Screen_Width/2, CGRectGetMaxY(self.self.loginBtn.frame) + 10, Main_Screen_Width/2 - 20, 40) title:@"新用户注册"];
    [regisBtn addTarget:self action:@selector(regBtnClick) forControlEvents:UIControlEventTouchUpInside];
    regisBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.contentScrollView addSubview:regisBtn];
    _regisBtn = regisBtn;
    
}
#pragma mark -- 点击了登录按钮
- (void)loginBtnClick{
    // 点击登录按钮后，关闭键盘
    [self.view endEditing:YES];
    CZHLog(@"点击了登录按钮----");
    CZHLog(@"_countN = %ld",(long)_countN);
    if (self.nametextField.text.length==0 || self.passwtextField.text.length==0) {
//    if (self.nametextField.text.length==0) {
        //通过第三方创建菊花//提示框
        [Czh_WarnWindow HUD:self.view andWarnText:@"请输入账号信息" andXoffset:0 andYoffset:Main_Screen_Width/5*3];
    }else{
        //正则判断手机号码
        if ([Czh_RegularVerification isMobileNumber:self.nametextField.text]) {
            //验证码请求
            [self performSelector:@selector(LoginBtnClickNetWork) withObject:nil];
        }else{
            [Czh_WarnWindow HUD:self.view andWarnText:@"请输入正确手机号码" andXoffset:0 andYoffset:Main_Screen_Width/5*3];
        }
    }
}

#pragma mark -- 点击了登录按钮后的网络请求
-(void)LoginBtnClickNetWork{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *countNstring = [NSString stringWithFormat:@"%ld",(long)_countN];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *url = [Czh_NetWorkURL returnURL:Interface_For_userLogin];
    if ([countNstring isEqualToString:@"0"]) {
        params[@"tel"] = self.nametextField.text;//手机号码
        params[@"pwd"]  = self.passwtextField.text;//密码
        params[@"type"] = countNstring;//0-密码，1-短信验证码
    }else{
        params[@"tel"] = self.nametextField.text;//手机号码
        params[@"verify_code"]  = self.passwtextField.text;//验证码
        params[@"type"] = countNstring;//0-密码，1-短信验证码
    }
    [Czh_HttpRequest requestWithMethod:POST WithPath:url WithToken:nil WithParams:params WithSuccessBlock:^(id data) {
        
        if ([[NSString stringWithFormat:@"%@",data[@"code"]] isEqualToString:@"200"]) {
            //用户名
            [userDefaults setObject:data[@"data"][@"user"][@"Nick"]  forKey:kUserNameKey];
            //密码
            [userDefaults setObject:data[@"data"][@"user"][@"Pwd"]  forKey:kUserPwdKey];
            //用户ID
            [userDefaults setObject:data[@"data"][@"user"][@"Id"]  forKey:kUserIDKey];
            //注册时间
            [userDefaults setObject:data[@"data"][@"user"][@"Created"]  forKey:kUserCreatedKey];
            //更新时间
            [userDefaults setObject:data[@"data"][@"user"][@"Updated"]  forKey:kUserUpdatedKey];
            //手机号码
            [userDefaults setObject:data[@"data"][@"user"][@"Tel"]  forKey:kUserTelKey];
            [userDefaults synchronize];
            //注册成功--提示框
            [Czh_WarnWindow HUD:self.view andWarnText:@"登录成功" andXoffset:0 andYoffset:Main_Screen_Width/5*3];
            //设置窗口的根控制器
            [self presentViewController:[ZHGTabBarController new] animated:YES completion:nil];
        }else{
            [Czh_WarnWindow HUD:self.view andWarnText:@"登录失败,请重新登录" andXoffset:0 andYoffset:Main_Screen_Width/5*3];
        }
        CZHLog(@"验证码请求时成功返回的数据--------(((%@)))",data);
    } WithFailurBlock:^(NSString *error) {
        CZHLog(@"验证码请求时失败返回的数据--------%@",error);
    } WithShowHudToView:self.view];
}
#pragma mark -- 普通状态下的背景色
- (void)buttonBackGroundNormal:(UIButton *)sender
{
    __weak __typeof(self)weakSelf = self;
    if ([sender.titleLabel.text isEqualToString:@"短信验证码登录"]) {
        
        _countN = 1;
        [self.passwtextField removeFromSuperview];
        [_button setTitle:@"账户密码登录" forState:UIControlStateNormal];
        CZHLog(@"处理什么？");
        self.passwtextField = [[ZHGLoginTextField alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.self.nametextField.frame) + 30, Main_Screen_Width - 40, 44) placeHolder:@"请输入验证码" boolLeftView:YES rightTitle:@"获取验证码"];
        [self.contentScrollView addSubview:self.passwtextField];
        [self.passwtextField.rBtn setClickBlock:^(UIButton *button) {
            // 需要执行的操作
            [weakSelf sendCode];
        } andEvent:UIControlEventTouchUpInside];
    }
    else{
        _countN = 0;
        [_button setTitle:@"短信验证码登录" forState:UIControlStateNormal];
        CZHLog(@"又处理什么？");
        [self.passwtextField removeFromSuperview];
        self.passwtextField = [[ZHGLoginTextField alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.self.nametextField.frame) + 30, Main_Screen_Width - 40, 44) placeHolder:@"请输入密码" boolLeftView:YES rightTitle:@"忘记密码"];
        [self.contentScrollView addSubview:self.passwtextField];
        [self.passwtextField.rBtn setClickBlock:^(UIButton *button) {
            CZHLog(@"--------回调成功！");
            ZHGForgotPwVC * vc = [[ZHGForgotPwVC alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:true];
            // 需要执行的操作
        } andEvent:UIControlEventTouchUpInside];
    }
    CZHLog(@"_countN = %ld",(long)_countN);
}


- (void)regBtnClick{
    CZHLog(@"点击了注册按钮----");
    ZHGRegisterVC *vc = [[ZHGRegisterVC alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    [self presentViewController:vc animated:YES completion:nil];
}

-(UIButton *)addBtnWithFrame:(CGRect)frame title:(NSString *)title action:(SEL)action{
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    [button setTitle:title forState:UIControlStateNormal];
    button.backgroundColor = [UIColor clearColor];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}


-(void)sendCode{
    CZHLog(@"点击了获取验证码按钮----");
    if (self.nametextField.text.length==0) {
        //通过第三方创建菊花//提示框
        [Czh_WarnWindow HUD:self.view andWarnText:@"请输入手机号码" andXoffset:0 andYoffset:Main_Screen_Width/5*2];
    }else{
        //正则判断手机号码
        if ([Czh_RegularVerification isMobileNumber:self.nametextField.text]) {
            //验证码请求
            [self performSelector:@selector(countClick) withObject:nil];
        }else{
            [Czh_WarnWindow HUD:self.view andWarnText:@"请输入正确手机号码" andXoffset:0 andYoffset:Main_Screen_Width/5*2];
        }
    }
}
-(void)countClick
{
    _passwtextField.rBtn.enabled =NO;
    _count = 60;
    [_passwtextField.rBtn setTitle:@"60秒" forState:UIControlStateDisabled];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
}
-(void)timerFired:(NSTimer *)timer
{
    if (_count !=1) {
        _count -=1;
        [_passwtextField.rBtn setTitle:[NSString stringWithFormat:@"等待 %ld 秒",_count] forState:UIControlStateDisabled];
        _nametextField.enabled = false;
    }else{
        [timer invalidate];
        _passwtextField.rBtn.enabled = YES;
        [_passwtextField.rBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _nametextField.enabled = true;
    }
}
@end
