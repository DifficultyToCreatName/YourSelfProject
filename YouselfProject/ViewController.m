//
//  ViewController.m
//  YouselfProject
//
//  Created by MAC on 17/3/29.
//  Copyright © 2017年 Lee. All rights reserved.
//

#import "ViewController.h"
#import "LLPayRoute.h"
#import "MBProgressHUD.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *priceTextFileld;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self)weakSelf = self;
    [[LLPayRoute llPayRoute]monitorRouteWithNameSpace:@"payShopID777" routeType:@"status" handler:^(NSDictionary<NSString *,NSString *> *params) {
        if ([params[@"status"] isEqualToString:@"500"]) {
            MBProgressHUD *HUDInView = [MBProgressHUD showHUDAddedTo:weakSelf.view animated:NO];
            HUDInView.removeFromSuperViewOnHide = YES;
            HUDInView.mode = MBProgressHUDModeText;
            HUDInView.detailsLabelText = @"用户取消";
            [HUDInView hide:YES afterDelay:2];
        }else if ([params[@"status"] isEqualToString:@"200"]) {
            MBProgressHUD *HUDInView = [MBProgressHUD showHUDAddedTo:weakSelf.view animated:NO];
            HUDInView.removeFromSuperViewOnHide = YES;
            HUDInView.mode = MBProgressHUDModeText;
            HUDInView.detailsLabelText = @"支付成功";
            [HUDInView hide:YES afterDelay:2];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
- (IBAction)paymentClickAction:(id)sender {
    if ([[self.priceTextFileld.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]) {
        MBProgressHUD *HUDInView = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
        HUDInView.removeFromSuperViewOnHide = YES;
        HUDInView.mode = MBProgressHUDModeText;
        HUDInView.detailsLabelText = @"金额不能为空";
        [HUDInView hide:YES afterDelay:2];        return;
    }
    NSString *url = [NSString stringWithFormat:@"payDemo://PaymentViewController&%@&payShopID777",self.priceTextFileld.text];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url]];
}

@end
