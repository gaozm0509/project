//
//  CreatOrderViewController.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/11/4.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "CreatOrderViewController.h"
#import "CreatOrderTableView.h"
#import "PayModel.h"
#import "WXApiObject.h"
#import "WXApi.h"

@interface CreatOrderViewController ()

@property (nonatomic, strong) CreatOrderTableView *tableView;
@property (nonatomic, strong) PayModel *orderModel;
@property (nonatomic, copy) NSString *name;

@property (nonatomic ,strong) UIButton *buttomButton;

@end

@implementation CreatOrderViewController

#pragma mark - Cycle life
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *title = self.receiveParams[@"title"];
    self.orderModel = self.receiveParams[@"orderModel"];
    self.name = self.receiveParams[@"name"];
    if (title.length == 0) {
        title = @"支付" ;
    }
    self.title = title;
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.buttomButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Getter and setter

- (CreatOrderTableView *)tableView{
    if (!_tableView) {
        _tableView = [[CreatOrderTableView alloc] initWithFrame:kViewFrame];
        _tableView.height = _tableView.height - 45;
        _tableView.name = _name;
        _tableView.amount = _orderModel.amount;
    }
    return _tableView;
}

//提交按钮
- (UIButton *)buttomButton{
    if (!_buttomButton) {
        _buttomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _buttomButton.frame = CGRectMake(0, kScreen_Height - 45 - kNavHeight, kScreen_Width, 45);
        [_buttomButton setTitle:@"确认支付" forState:UIControlStateNormal];
        [_buttomButton setTitleColor:KMajorColor forState:UIControlStateNormal];
        _buttomButton.titleLabel.font = kFont16;
        _buttomButton.backgroundColor = [UIColor whiteColor];
        [_buttomButton addTarget:self action:@selector(buttomButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _buttomButton.tag = 1002;
    }
    return _buttomButton;
}

#pragma mark - Delegate

- (void)buttomButtonClick{
    [self netRequest];
}

#pragma mark - Net request

//点击支付按钮网络请求
- (void)netRequest{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.orderModel.id forKey:@"order_id"];
    [params setValue:@"0.01" forKey:@"amount"];
    
    //支付方式
    switch (_tableView.paymentMethod) {
        case PaymentMethodWechat:{
            [params setValue:@"wechat" forKey:@"vendor"];
            break;
        }
        case PaymentMethodAirpay:{
            [params setValue:@"alipay" forKey:@"vendor"];
            break;
        }
            
        default:{
            [params setValue:@"balance" forKey:@"vendor"];
            break;
        }
    }
    
    [kApi_payment_create httpRequestWithParams:params networkMethod:Post andBlock:^(id data, NSError *error) {
        if (error) {
            [self showError:error];
            return ;
        }
        if ([data[@"code"] integerValue] == 1) {
            if (_tableView.pagingEnabled == PaymentMethodAirpay) {
                //支付宝
            }
            else{
                [self creatWxPayReq:data];
            }
        }
    }];
    
}

#pragma mark - Event method



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
