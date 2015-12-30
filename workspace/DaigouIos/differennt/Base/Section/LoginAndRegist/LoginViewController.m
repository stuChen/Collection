//
//  LoginViewController.m
//  differennt
//
//  Created by apple on 15/12/11.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"

@interface LoginViewController () {
    
    __weak IBOutlet LocalizedTextfield *_phoneTextfield;
    __weak IBOutlet LocalizedTextfield *passwordTextfield;
}

@end


@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addLeftBtn:NO BackBtn:NO shopBag:nil Search:nil ALL:nil];
    [self addRightItems:[self creatItemWithAction:@selector(dismissVc:) imageName:@"关闭"], nil];
}
- (void)dismissVc:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 点击事件
- (IBAction)loginBtn:(id)sender {
    if (![_phoneTextfield.text isPhoneNumber]) {
        [SVProgressHUD showErrorWithStatus:@"手机号码不正确"];
        return;
    }
    if (passwordTextfield.text.length < 6 || passwordTextfield.text.length > 14) {
        [SVProgressHUD showErrorWithStatus:@"密码格式不正确"];
        return;
    }
    [RequestManager PostUrl:URI_LOGIN loding:nil dic:@{@"userName":_phoneTextfield.text,@"clientVersion":@"1.0.1",@"loginDevice":@"iOS",@"password":passwordTextfield.text} response:^(id response) {
        if (response) {
            if ([response[@"ReturnCode"] integerValue] == 1) {
                
            }
        }
    }];
}
- (IBAction)registerBtn:(id)sender {
    RegisterViewController *vc = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
