//
//  RegisterViewController.m
//  differennt
//
//  Created by apple on 15/12/11.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController () {
    
    __weak IBOutlet LocalizedTextfield *phoneTextfield;
    __weak IBOutlet LocalizedTextfield *codeTextfield;
    __weak IBOutlet LocalizedTextfield *NameTextfield;
    __weak IBOutlet LocalizedTextfield *passwordTextfield;
}

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addLeftBtn:NO BackBtn:NO shopBag:nil Search:nil ALL:nil];
    [self addRightItems:[self creatItemWithAction:@selector(dismissVc:) imageName:@"关闭"], nil];
}
- (void)dismissVc:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 点击事件
- (IBAction)GetCode:(id)sender {
    if ([phoneTextfield.text isPhoneNumber]) {
        [RequestManager PostUrl:URI_GetSmsCode loding:nil dic:@{@"phoneNo":phoneTextfield.text,@"codeType":@"1"} response:^(id response) {
            if (response) {
                if ([response[@"ReturnCode"] integerValue] == 1) {
                    codeTextfield.text = [NSString stringWithFormat:@"%@",response[@"ReturnData"]];
                }
            }
        }];
    }
    else {
        [SVProgressHUD showErrorWithStatus:@"手机号码不正确"];
    }
}
//
- (IBAction)Next:(id)sender {
    if (![phoneTextfield.text isPhoneNumber]) {
        [SVProgressHUD showErrorWithStatus:@"手机号码不正确"];
        return;
    }
    if (codeTextfield.text.length <= 0) {
        [SVProgressHUD showErrorWithStatus:@"验证码不正确"];
        return;
    }
    if (NameTextfield.text.length <= 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入名称"];
        return;
    }
    if (passwordTextfield.text.length < 6 || passwordTextfield.text.length > 14) {
        [SVProgressHUD showErrorWithStatus:@"密码格式不正确"];
        return;
    }
    [RequestManager PostUrl:URI_ValidateRegister loding:nil dic:@{@"UserName":NameTextfield.text,@"RegistKey":@"",@"Password":passwordTextfield.text,@"validateCode":codeTextfield.text} response:^(id response) {
        if (response) {
            if ([response[@"ReturnCode"] integerValue] == 1) {
                
            }
        }
    }];

}


@end
