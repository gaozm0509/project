//
//  RechargeViewController.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/31.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "RechargeViewController.h"
#import "RechargeTableView.h"
#import "WXApiObject.h"
#import "WXApi.h"

@interface RechargeViewController ()<RechargeTableViewDelegate>

@property (nonatomic ,strong)RechargeTableView *tableView;
@property (nonatomic, strong) UIButton *bottomButton;

@property (nonatomic, strong) NSString *money;//充值金额

@end

@implementation RechargeViewController

#pragma mark - Cycle life
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充值";
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Getter and setter

- (RechargeTableView *)tableView{
    if (!_tableView) {
        _tableView = [[RechargeTableView alloc] initWithFrame:kViewFrame];
        _tableView.height = kScreen_Height - kNavHeight - 45;
        _tableView.clickDelegate = self;
    }
    return _tableView;
}

- (UIButton *)bottomButton{
    if (!_bottomButton) {
        _bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _bottomButton.frame = CGRectMake(0, kScreen_Height - kNavHeight - 45, kScreen_Width, 45);
        [_bottomButton setTitle:@"下单" forState:UIControlStateNormal];
        [_bottomButton setTitleColor:KMajorColor forState:UIControlStateNormal];
        _bottomButton.backgroundColor = [UIColor whiteColor];
        _bottomButton.layer.borderColor = kBorderColor.CGColor;
        _bottomButton.layer.borderWidth = 0.5;
        _bottomButton.tag = 1001;
        [_bottomButton addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomButton;
}

#pragma mark - Delegate

#pragma mark RechargeTableViewDelegate

- (void)textFieldEdit:(UITextField *)textFiled{
    _money = textFiled.text;
}


#pragma mark - Net request

- (void)netRequest{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"wechat" forKey:@"vendor"];
    [params setValue:_money forKey:@"amount"];
    
    [kApi_member_balance httpRequestWithParams:params hudView:self.hudView networkMethod:Post andBlock:^(id data, NSError *error) {
        if (error) {
            [self showError:error];
            return ;
        }
        if ([data[@"code"] integerValue] == 1) {
            [self creatWxPayReq:data];
        }
    }];
}

#pragma mark - Event method

- (void)bottomButtonClick:(UIButton *)button{
    //充值按钮
    if (_money.floatValue > 0) {
        [self netRequest];
    }
    else{
        [self showHudTipStr:@"输入金额有误"];
    }
}

#pragma mark - Pravit method

//微信支付创建PayReq对象

- (void)creatWxPayReq:(NSDictionary *)data{
    
    NSDictionary *result = data[@"data"][@"result"];
    
    // 调起微信支付
    PayReq *payReq = [[PayReq alloc] init];
    payReq.prepayId = result[@"prepay_id"];
    payReq.openID = result[@"appid"];
    payReq.partnerId = result[@"mch_id"];
    //商家根据财付通文档填写的数据和签名 <暂填写固定值Sign=WXPay>
    payReq.package = @"Sign=WXPay";
    // 随机串，防重发
    payReq.nonceStr = result[@"nonce_str"];
    //时间戳，防重发
    payReq.timeStamp = (int32_t)[data[@"data"][@"timestamp"] doubleValue];
    // 商家根据微信开放平台文档对数据做的签名
    
    payReq.sign = result[@"sign"];
    
    payReq.sign = [self createMD5SingWithPayReq:payReq];
    //发送支付请求
    BOOL  isScusess = [WXApi sendReq:payReq];
    if (isScusess) {
        NSLog(@"[WXApi sendReq:payReq] 成功");
    }
    else{
        NSLog(@"[WXApi sendReq:payReq] 出错");
    }
    
}
//创建发起支付时的sige签名

-(NSString *)createMD5SingWithPayReq:(PayReq *)payReq{
    
    NSMutableDictionary *signParams = [NSMutableDictionary dictionary];
    [signParams setObject:payReq.openID forKey:@"appid"];
    [signParams setObject:payReq.nonceStr forKey:@"noncestr"];
    [signParams setObject:payReq.package forKey:@"package"];
    [signParams setObject:payReq.partnerId forKey:@"partnerid"];
    [signParams setObject:payReq.prepayId forKey:@"prepayid"];
    [signParams setObject:[NSString stringWithFormat:@"%u",(unsigned int)payReq.timeStamp] forKey:@"timestamp"];
    
    NSMutableString *contentString  =[NSMutableString string];
    NSArray *keys = [signParams allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    for (NSString *categoryId in sortedArray) {
        if (   ![[signParams objectForKey:categoryId] isEqualToString:@""]
            && ![[signParams objectForKey:categoryId] isEqualToString:@"sign"]
            && ![[signParams objectForKey:categoryId] isEqualToString:@"key"]
            )
        {
            [contentString appendFormat:@"%@=%@&", categoryId, [signParams objectForKey:categoryId]];
        }
    }
    //添加商户密钥key字段 kWXBusinessSecretKey是宏定义的商户秘钥
    [contentString appendFormat:@"key=%@", kWXBusinessSecretKey];
    NSString *result = [contentString md5Str];
    
    NSLog(@"result = %@",result);
    return result;
}



@end
