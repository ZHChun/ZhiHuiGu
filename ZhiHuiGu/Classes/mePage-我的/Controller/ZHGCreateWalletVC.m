//  文件名: ZHGCreateWalletVC.m
//  创建者: CYJ 时间: 2018/10/5.
//  Copyright © 2018年 CYJ. All rights reserved..
//  用途：创建钱包

#import "ZHGCreateWalletVC.h"
#import "CreateWalletPdView.h"
#import "ZHGLoginBtn.h"
#import "RTNavigationBar.h"
#import "ZHGTabBarController.h"

@interface ZHGCreateWalletVC ()
@property(nonatomic,strong) TPKeyboardAvoidingScrollView * contentScrollView;
@property(nonatomic,strong) CreateWalletPdView *cwPdView0;
@property(nonatomic,strong) CreateWalletPdView *cwPdView2;
@property(nonatomic,strong) ZHGLoginBtn *nextBtn;

@end

@implementation ZHGCreateWalletVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self setNav];
}
#pragma mark -- 添加导航栏
-(void)setNav{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController setNavigationBarHidden:YES];
    UINavigationBar *nav = [RTNavigationBar defaultBar];
    nav.barTintColor = [UIColor whiteColor];
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:@"创建钱包"];
    UIButton* left = [UIButton buttonWithType:UIButtonTypeCustom];
    [left setFrame:CGRectMake(0, 0, 40, 40)];
    [left setImage:[[UIImage imageNamed:@"common_btn_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [left setImageEdgeInsets:UIEdgeInsetsMake(0, /*0*/-23, 0, 0)];
    [left addTarget:self action:@selector(onBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithCustomView:left];
    [navigationItem setLeftBarButtonItem:leftBtn animated:NO];
    [nav pushNavigationItem:navigationItem animated:NO];
    [self.view addSubview:nav];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"跳过" style:UIBarButtonItemStylePlain target:self action:@selector(onClickedrightBarbtn)];
    [navigationItem setRightBarButtonItem:rightBarItem animated:NO];
}
-(void)onBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)onClickedrightBarbtn{
    [self presentViewController:[ZHGTabBarController new] animated:YES completion:nil];
}


-(void)setupView{
    /**
     控制前添加ScrollView（非必备）
     */
    self.edgesForExtendedLayout = UIRectEdgeNone;
    TPKeyboardAvoidingScrollView * contentScrollView = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    contentScrollView.bounces = NO;
    contentScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:contentScrollView];
    _contentScrollView = contentScrollView;
    /**
     ios 11判断
     */
    CGFloat kheight;
    if (@available(iOS 11.0, *)) {
        kheight = 98.f;
    }else{
        kheight = 10.f;
    }
    
    
    /**
     提示密码位数和类型
     */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10,kheight, Main_Screen_Width - 20, 30)];
    label.text = @"交易密码由字母和数字组成，至少八位";
    label.font = [UIFont systemFontOfSize:14.0f];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor grayColor];
    [self.contentScrollView addSubview:label];
    
    /**
     首次输入密码
     */
    CreateWalletPdView *cwPdView0 = [[CreateWalletPdView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(label.frame) + 40, self.view.frame.size.width - 20, 44) labelText:@"交易密码 :  " placeHolder:@"请输入交易密码"];
    [self.contentScrollView addSubview:cwPdView0];
    _cwPdView0 = cwPdView0;
    
    
    /**
     重复输入密码
     */
    CreateWalletPdView *cwPdView2 = [[CreateWalletPdView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.cwPdView0.frame) + 40, self.view.frame.size.width - 20, 44) labelText:@"确认密码 :  " placeHolder:@"请再次输入交易密码"];
    [self.contentScrollView addSubview:cwPdView2];
    _cwPdView2 = cwPdView2;
    
    /**
     下一步按钮
     */
    ZHGLoginBtn *nextBtn = [[ZHGLoginBtn alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.cwPdView2.frame) + 50, Main_Screen_Width - 20, 44)];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    nextBtn.backgroundColor = MAIN_COLOR;
    [self.contentScrollView addSubview:nextBtn];
    _nextBtn = nextBtn;
    [self.nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)nextBtnClick{
    CZHLog(@"点击下一步按钮---%s",__func__);
    /*pay_pwd（string） user_id（string）*/
    
}





























- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
