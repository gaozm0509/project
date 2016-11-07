//
//  HomeViewController.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/16.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "HomeViewController.h"
#import "SDCycleScrollView.h"
#import "NSString+WPAttributedMarkup.h"
#import <QuartzCore/QuartzCore.h>
#import "HKPieChartView.h"

@interface HomeViewController ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic,strong)SDCycleScrollView *cycleScrollView;
@property (nonatomic,strong)UIView *bgView,*assetView,*assetLine,*sectionBgView,*line,*vertical;
@property (nonatomic,strong)NSDictionary *style;
@property (nonatomic,strong)UIImageView *scoreView,*icon1,*icon2;
@property (nonatomic,strong)UILabel *scoreLabel,*assetLabel1,*assetLabel2,*assetLabel3,*sectionLabel1,*sectionLabel2,*percentLabel;
@property (nonatomic,strong)UIScrollView *scrollView,*scrollView1;
@property (nonatomic,strong)NSMutableArray *roomArry;
@property (nonatomic,strong) HKPieChartView *pieChartView;
@property (nonatomic,strong)NSString *points,*Number,*percentage;
//@property (nonatomic,strong)NSMutableArray *roomList;
@property (nonatomic,strong)NSMutableDictionary *roomDetail;

@property int state;
@property CGFloat angle;
@property int tagNum;
@property int percentNum;

@end

@implementation HomeViewController

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"管家女士";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightButton];
    
    
    
    
    _state =0;
    _style = @{
               @"asset":@[[UIFont systemFontOfSize:14],
                          KMajorColor],
               @"scord":@[[UIFont boldSystemFontOfSize:16],
                           KMajorColor],
               @"scord1":@[[UIFont boldSystemFontOfSize:25],
                          [UIColor colorWithHexString:@"E68E51"]],
               @"scord2":@[[UIFont systemFontOfSize:10],
                          [UIColor colorWithHexString:@"E68E51"]],
               @"label":@[[UIFont systemFontOfSize:14],
                           KMajorColor],
               @"label1":@[[UIFont systemFontOfSize:12],
                          [UIColor colorWithHexString:@"F46A0C"]],
               @"room":@[[UIFont systemFontOfSize:14],
                          [UIColor colorWithHexString:@"616161"]],
               @"number":@[[UIFont boldSystemFontOfSize:18],
                         [UIColor colorWithHexString:@"ffffff"]],
               @"common":@[[UIFont systemFontOfSize:16],
                           [UIColor colorWithHexString:@"000000"]]
               };
    
//    _roomArry = @[@"客厅1",@"客厅2",@"客厅3",@"客厅4",@"客厅5",@"客厅6",@"客厅7",@"客厅8",@"客厅9"];
    _roomArry = [[NSMutableArray alloc]init];
    WS(weakSelf);
    
    [self.view addSubview:self.bgView];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).offset(0);
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.height.offset(kScreen_Height/9+10);
    }];
    
    [self.view addSubview:self.cycleScrollView];
    
    [self.view addSubview:self.scoreView];
    [_scoreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_cycleScrollView.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.view.mas_left).offset(25);
        make.height.offset(kScreen_Height/5);
        make.width.offset(kScreen_Height/5);
    }];
    
    [self.view addSubview:self.scoreLabel];
    [_scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_scoreView.mas_centerX);
        make.centerY.equalTo(_scoreView.mas_centerY);
        make.height.offset(kScreen_Height/10);
        make.width.offset(kScreen_Height/10);
    }];
    
    [self.view addSubview:self.assetLabel1];
    [_assetLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_cycleScrollView.mas_bottom).offset(10);
        make.left.equalTo(_scoreView.mas_right).offset(20);
        make.right.equalTo(weakSelf.view.mas_right).offset(-10);
        make.height.offset(kScreen_Height/24);
    }];
    
    [self.view addSubview:self.assetLabel2];
    [_assetLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_assetLabel1.mas_bottom).offset(10);
        make.left.equalTo(_scoreView.mas_right).offset(20);
        make.right.equalTo(weakSelf.view.mas_right).offset(-10);
        make.height.offset(kScreen_Height/24);
    }];

    
    [self.view addSubview:self.assetView];
    [_assetView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_assetLabel1.mas_bottom).offset(10);
        make.left.equalTo(_scoreView.mas_right).offset(20);
        make.right.equalTo(weakSelf.view.mas_right).offset(-10);
        make.bottom.equalTo(_scoreView.mas_bottom).offset(-10);
    }];

    [self.assetLabel2 addSubview:self.icon1];
    [_icon1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_assetLabel2.mas_centerX);
        make.width.offset(10);
        make.height.offset(10);
        make.bottom.equalTo(_assetLabel2.mas_bottom).offset(0);
    }];
    
    [self.assetView addSubview:self.icon2];
    [_icon2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_assetView.mas_centerX);
        make.width.offset(10);
        make.height.offset(10);
        make.bottom.equalTo(_assetView.mas_bottom).offset(0);
    }];

    [self.assetView addSubview:self.assetLabel3];
    [_assetLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_assetView.mas_top).offset(0);
        make.left.equalTo(_assetView.mas_left).offset(0);
        make.right.equalTo(_assetView.mas_right).offset(0);
        make.height.offset(kScreen_Height/24);
    }];

    [self.assetView addSubview:self.assetLine];
    [_assetLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_assetLabel3.mas_bottom).offset(0);
        make.left.equalTo(_assetView.mas_left).offset(10);
        make.right.equalTo(_assetView.mas_right).offset(-10);
        make.height.offset(2);
    }];
    
    for (int i=0; i<5; i++) {
        UILabel *labelFor = [[UILabel alloc]init];
        labelFor.layer.cornerRadius = 2;
        labelFor.layer.masksToBounds = YES;
        labelFor.tag = 200+i;
        labelFor.backgroundColor  = [UIColor colorWithHexString:@"343434"];
        [self.assetView addSubview:labelFor];
        
        [labelFor mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_assetLine.mas_bottom).offset(10);
            make.left.equalTo(_assetView.mas_left).offset(10*(i+1)+(kScreen_Width-25-kScreen_Height/5-20-10-60)/5*i);
            make.bottom.equalTo(_assetView.mas_bottom).offset(-10);
//            make.width.offset((_assetView.frame.size.width-60)/5);
            make.width.offset((kScreen_Width-25-kScreen_Height/5-20-10-60)/5);
        }];
    }

    
    [self.view addSubview:self.sectionBgView];
    [_sectionBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_scoreView.mas_bottom).offset(0);
        make.left.equalTo(weakSelf.view.mas_left).offset(10);
        make.right.equalTo(weakSelf.view.mas_right).offset(-10);
        make.bottom.equalTo(weakSelf.view.mas_bottom).offset(-60);
    }];
    
    [self.sectionBgView addSubview:self.sectionLabel1];
    [_sectionLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_sectionBgView.mas_top).offset(0);
        make.left.equalTo(_sectionBgView.mas_left).offset(0);
        make.width.offset((kScreen_Width-20)/5*2);
        make.height.offset(40);
    }];
    
    [self.sectionBgView addSubview:self.sectionLabel2];
    [_sectionLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_sectionBgView.mas_top).offset(0);
        make.left.equalTo(_sectionLabel1.mas_right).offset(0);
        make.right.equalTo(weakSelf.view.mas_right).offset(-10);
        make.height.offset(40);
    }];
    
    [self.sectionBgView addSubview:self.line];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_sectionLabel1.mas_bottom).offset(0);
        make.left.equalTo(_sectionBgView.mas_left).offset(0);
        make.right.equalTo(_sectionBgView.mas_right).offset(0);
        make.height.offset(1);
    }];
    
    [self.sectionBgView addSubview:self.vertical];
    [_vertical mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_sectionBgView.mas_top).offset(0);
        make.left.equalTo(_sectionBgView.mas_left).offset((kScreen_Width-20)/5*2);
        make.width.offset(1);
        make.bottom.equalTo(weakSelf.view.mas_bottom).offset(-60);
    }];
    
    [self.sectionBgView addSubview:self.scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line.mas_bottom).offset(0);
        make.left.equalTo(_sectionBgView.mas_left).offset(0);
        make.right.equalTo(_vertical.mas_left);
        make.bottom.equalTo(_sectionBgView.mas_bottom);
    }];
    
    
    [self.sectionBgView addSubview:self.pieChartView];
    
    [self.sectionBgView addSubview:self.percentLabel];
    [_percentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_pieChartView.mas_bottom).offset(0);
        make.left.equalTo(_scrollView.mas_right).offset(0);
        make.right.equalTo(_sectionBgView.mas_right).offset(0);
        make.height.offset(20);
    }];
    
    [self.sectionBgView addSubview:self.scrollView1];
    [_scrollView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line.mas_bottom).offset(0);
        make.left.equalTo(_scrollView.mas_right).offset(0);
        make.right.equalTo(_sectionBgView.mas_right);
        make.bottom.equalTo(_sectionBgView.mas_bottom);
    }];

    
    
    
}




- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.hidesBottomBarWhenPushed = YES;
    
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    NSDictionary *textAttributes = nil;
    textAttributes = @{
                       NSFontAttributeName: [UIFont boldSystemFontOfSize:kNavTitleFontSize],
                       NSForegroundColorAttributeName: [UIColor whiteColor],
                       };
    
    [navigationBarAppearance setBackgroundImage:[UIImage imageWithColor:KMajorColor] forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
    [navigationBarAppearance setShadowImage:[UIImage imageWithColor:KMajorColor]];
    
    [self netRequest];
    [self netRequest_GetNumber];
    [self netRequest_GetRooms];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    NSDictionary *textAttributes = nil;
    textAttributes = @{
                       NSFontAttributeName: [UIFont boldSystemFontOfSize:kNavTitleFontSize],
                       NSForegroundColorAttributeName: KMajorColor,
                       };

    [navigationBarAppearance setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
    [navigationBarAppearance setShadowImage:[UIImage imageWithColor:KMajorColor]];
    
    
    for (int i=0; i<_roomArry.count;i++) {
        int tagOther = 300+i;
        UILabel *roomLaber = (UILabel*)[self.view viewWithTag:tagOther];
        [roomLaber removeFromSuperview];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Getter and setter

- (UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.frame = CGRectMake(0, 0, 30, 30);
        [_rightButton setTitle:@"服务" forState:UIControlStateNormal];
        [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _rightButton.titleLabel.font = kFont14;
        [_rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

-(UIView*)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = KMajorColor;
    }
    return _bgView;
}

-(SDCycleScrollView*)cycleScrollView{
    if (!_cycleScrollView) {;
        CGRect frame = CGRectMake(10, 10,kScreen_Width-20, kScreen_Height/4.5);
        NSArray *arry = @[[UIImage imageNamed:@"banner01@3x"],[UIImage imageNamed:@"banner02@3x"],[UIImage imageNamed:@"banner03@3x"],[UIImage imageNamed:@"banner04@3x"]];
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:frame imageNamesGroup:arry];
        _cycleScrollView.layer.cornerRadius = 10;
        _cycleScrollView.layer.masksToBounds = YES;
        _cycleScrollView.autoScrollTimeInterval = 3;
        _cycleScrollView.delegate = self;
    }
    return _cycleScrollView;
}

-(UIImageView*)scoreView{
    if (!_scoreView) {
        _scoreView = [[UIImageView alloc]init];
        _scoreView.image = [UIImage imageNamed:@"home_secor01@3x"];
        
        _scoreView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onclick:)];
        tapGesture.delegate = self;
        _scoreView.tag = 1001;
        [_scoreView addGestureRecognizer:tapGesture];
    }
    return _scoreView;
}

-(UILabel*)scoreLabel{
    if (!_scoreLabel) {
        _scoreLabel = [[UILabel alloc]init];
//        _scoreLabel.backgroundColor = [UIColor redColor];
        _scoreLabel.textAlignment = NSTextAlignmentCenter;
        _scoreLabel.numberOfLines = 0;
        _scoreLabel.attributedText = [[NSString stringWithFormat:@"<scord>房屋\n检测</scord>"] attributedStringWithStyleBook:_style];
    }
    return _scoreLabel;
}

-(UILabel*)assetLabel1{
    if (!_assetLabel1) {
        _assetLabel1 = [[UILabel alloc]init];
        _assetLabel1.textAlignment = NSTextAlignmentCenter;
        _assetLabel1.layer.cornerRadius = 8;
        _assetLabel1.layer.masksToBounds = YES;
        _assetLabel1.layer.borderColor = [UIColor colorWithHexString:@"F3F3F3"].CGColor;
        _assetLabel1.layer.borderWidth = 1;
        _assetLabel1.attributedText = [[NSString stringWithFormat:@"<asset>已录入资产%@件</asset>",@"1"] attributedStringWithStyleBook:_style];
        
        _assetLabel1.layer.shadowColor = KMajorColor.CGColor;//shadowColor阴影颜色
        _assetLabel1.layer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        _assetLabel1.layer.shadowOpacity = 0.8;//阴影透明度，默认0
        _assetLabel1.layer.shadowRadius = 2;//阴影半径，默认3
    }
    return _assetLabel1;
}

-(UILabel*)assetLabel2{
    if (!_assetLabel2) {
        _assetLabel2 = [[UILabel alloc]init];
        _assetLabel2.textAlignment = NSTextAlignmentCenter;
        _assetLabel2.layer.cornerRadius = 8;
        _assetLabel2.layer.masksToBounds = YES;
        _assetLabel2.layer.borderColor = [UIColor colorWithHexString:@"F3F3F3"].CGColor;
        _assetLabel2.layer.borderWidth = 1;
        _assetLabel2.hidden = YES;
        _assetLabel2.attributedText = [[NSString stringWithFormat:@"<asset>管家用量</asset>"] attributedStringWithStyleBook:_style];
        
        _assetLabel2.layer.shadowColor = KMajorColor.CGColor;//shadowColor阴影颜色
        _assetLabel2.layer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        _assetLabel2.layer.shadowOpacity = 0.8;//阴影透明度，默认0
        _assetLabel2.layer.shadowRadius = 2;//阴影半径，默认3
        
        _assetLabel2.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onclick:)];
        tapGesture.delegate = self;
        _assetLabel2.tag = 1002;
        [_assetLabel2 addGestureRecognizer:tapGesture];
    }
    return _assetLabel2;
}

-(UIView*)assetView{
    if (!_assetView) {
        _assetView = [[UIView alloc]init];
//        _assetView.backgroundColor = [UIColor whiteColor];
        _assetView.layer.cornerRadius = 8;
        _assetView.layer.masksToBounds = YES;
        _assetView.layer.borderColor = [UIColor colorWithHexString:@"F3F3F3"].CGColor;
        _assetView.layer.borderWidth = 1;
       

        _assetView.layer.shadowColor = KMajorColor.CGColor;//shadowColor阴影颜色
        _assetView.layer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        _assetView.layer.shadowOpacity = 0.8;//阴影透明度，默认0
        _assetView.layer.shadowRadius = 2;//阴影半径，默认3
        
        _assetView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onclick:)];
        tapGesture.delegate = self;
        _assetView.tag = 1003;
        [_assetView addGestureRecognizer:tapGesture];
    }
    return _assetView;
}

-(UIImageView*)icon1{
    if (!_icon1) {
        _icon1 = [[UIImageView alloc]init];
        _icon1.image = [UIImage imageNamed:@"down"];
    }
    return _icon1;
}

-(UIImageView*)icon2{
    if (!_icon2) {
        _icon2 = [[UIImageView alloc]init];
        _icon2.image = [UIImage imageNamed:@"up"];
    }
    return _icon2;
}

-(UILabel*)assetLabel3{
    if (!_assetLabel3) {
        _assetLabel3 = [[UILabel alloc]init];
        _assetLabel3.textAlignment = NSTextAlignmentCenter;
        _assetLabel3.attributedText = [[NSString stringWithFormat:@"<asset>管家用量</asset>"] attributedStringWithStyleBook:_style];
    }
    return _assetLabel3;
}


-(UIView*)assetLine{
    if (!_assetLine) {
        _assetLine = [[UIView alloc]init];
        _assetLine.backgroundColor = KMajorColor;
    }
    return _assetLine;
}

-(UIView*)sectionBgView{
    if (!_sectionBgView) {
        _sectionBgView = [[UIView alloc]init];
//        _sectionBgView.backgroundColor = [UIColor redColor];
        _sectionBgView.layer.borderColor = [UIColor colorWithHexString:@"F2F2F2"].CGColor;
        _sectionBgView.layer.borderWidth = 1;
        _sectionBgView.layer.cornerRadius = 10;
        _sectionBgView.layer.masksToBounds = YES;
        
    }
    return _sectionBgView;
}

-(UILabel*)sectionLabel1{
    if (!_sectionLabel1) {
        _sectionLabel1 = [[UILabel alloc]init];
        _sectionLabel1.textAlignment = NSTextAlignmentCenter;
//        _sectionLabel1.backgroundColor = [UIColor redColor];
        _sectionLabel1.attributedText = [[NSString stringWithFormat:@"<common>家庭区块</common>"] attributedStringWithStyleBook:_style];
    }
    return _sectionLabel1;
}

-(UILabel*)sectionLabel2{
    if (!_sectionLabel2) {
        _sectionLabel2 = [[UILabel alloc]init];
        _sectionLabel2.textAlignment = NSTextAlignmentCenter;
        _sectionLabel2.attributedText = [[NSString stringWithFormat:@"<common>资产维护</common>"] attributedStringWithStyleBook:_style];
    }
    return _sectionLabel2;
}

-(UIView*)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = [UIColor colorWithHexString:@"F2F2F2"];
    }
    return _line;
}

-(UIView*)vertical{
    if (!_vertical) {
        _vertical = [[UIView alloc]init];
        _vertical.backgroundColor = [UIColor colorWithHexString:@"F2F2F2"];
    }
    return _vertical;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        //   _scrollView.backgroundColor = [UIColor redColor];
        _scrollView.contentSize = CGSizeMake((kScreen_Width-20)/5*2, 40*_roomArry.count);
    }
    return _scrollView;
}


- (HKPieChartView *)pieChartView {
    if (!_pieChartView) {
        if (iPhone5) {
            CGFloat width = kScreen_Width-((kScreen_Width-20)/5*2+10+30+40);
            _pieChartView = [[HKPieChartView alloc]initWithFrame:CGRectMake((kScreen_Width-20)/5*2+30, 45, width, width)];
        }else{
            CGFloat width = kScreen_Width-((kScreen_Width-20)/5*2+10+20+30);
            _pieChartView = [[HKPieChartView alloc]initWithFrame:CGRectMake((kScreen_Width-20)/5*2+20, 45, width, width)];
        }
        
       
     }
    return _pieChartView;
}

-(UILabel *)percentLabel{
    if (!_percentLabel) {
        _percentLabel = [[UILabel alloc]init];
        _percentLabel.textAlignment = NSTextAlignmentCenter;
        _percentLabel.attributedText = [[NSString stringWithFormat:@"<label>资产维护占总维护的%@%%</label>",@"30"] attributedStringWithStyleBook:_style];
        
    }
    return _percentLabel;
}

-(UIScrollView *)scrollView1{
    if (!_scrollView1) {
        _scrollView1 = [[UIScrollView alloc]init];
//        _scrollView1.backgroundColor = [UIColor redColor];
        _scrollView1.contentSize = CGSizeMake((kScreen_Width-20)/5*3, 40*_roomArry.count);
        _scrollView1.hidden = YES;
    }
    return _scrollView1;
}



#pragma mark - Delegate

#pragma mark SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    switch (index) {
        case 0:{
            //
            
            break;
        }
        case 1:{
            //资产录入
            [self pushNewViewController:@"DoorEntryViewController" params:@{@"priceId":@"1"}];
            break;
        }
        case 2:{
            //空气治理
            [self pushNewViewController:@"AirTreatmentViewController"];
            break;
        }
        case 3:{
            //绿植水陪
            
            break;
        }
        default:
            break;
    }
}

#pragma mark - Net request

- (void)netRequest{
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:@"3" forKey:@"state_id"];
    [kApi_state_points httpRequestWithParams:params networkMethod:Post isShowHud:NO andBlock:^(id data, NSError *error) {
        if (error) {
            [self showError:error];
        }
        if ([data[@"code"] integerValue] == 1) {
            _points = data[@"data"][@"points"];
        }
    }];
}

- (void)netRequest_GetNumber{
    NSMutableDictionary *params = [NSMutableDictionary new];
    [kApi_member_getNumber httpRequestWithParams:params networkMethod:Post isShowHud:NO andBlock:^(id data, NSError *error) {
        if (error) {
            [self showError:error];
            return ;
        }
        if ([data[@"code"] integerValue] == 1) {
            _Number = [NSString stringWithFormat:@"%@",data[@"data"][@"members"]];
            for (int i=4; i>=0; i--) {
                if (i>=5-_Number.length) {
                    UILabel *lable = (UILabel*)[self.view viewWithTag:200+i];
                    lable.textAlignment = NSTextAlignmentCenter;
                    NSString *num =[_Number substringWithRange:NSMakeRange(_Number.length-(4-i)-1,1)];
                    lable.attributedText = [[NSString stringWithFormat:@"<number>%@</number>",num] attributedStringWithStyleBook:_style];
                }else{
                    UILabel *lable = (UILabel*)[self.view viewWithTag:200+i];
                    lable.textAlignment = NSTextAlignmentCenter;
                   
                    lable.attributedText = [[NSString stringWithFormat:@"<number>%d</number>",0] attributedStringWithStyleBook:_style];
                }
                
            }
            
        }
    }];
}

- (void)netRequest_GetRooms{
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:@"3" forKey:@"state_id"];
    [kApi_furniture httpRequestWithParams:params networkMethod:Post isShowHud:NO andBlock:^(id data, NSError *error) {
        if (error) {
            [self showError:error];
            return ;
        }
        if ([data[@"code"] integerValue] == 1) {
            
            _roomArry = [[NSMutableArray alloc]init];
            NSDictionary *dataDic = data[@"data"];
            
            NSMutableArray *dataList = [NSMutableArray new];
            NSArray *allKeys = [dataDic allKeys];
            for (NSString *key in allKeys) {
                [dataList addObject:[dataDic objectForKey:key]];
            }
//            NSLog(@"%@",dataList);
            
            for (int i=0; i<dataList.count; i++) {
                NSArray * rooms = dataList[i][@"rooms"];
                for (int j=0; j<rooms.count; j++) {
                    [_roomArry addObject:rooms[j]];
                }
            }
             NSLog(@"%@",_roomArry);
            [self addRoomMessage];
            if (_state ==0 ) {
                [self netRequest_GetPercentage:_roomArry[0][@"id"] name:_roomArry[0][@"name"]];
            }else{
                for (int i=0; i<_percentNum;i++) {
                    int tagOther = 400+i;
                    UILabel *roomLaber = (UILabel*)[self.view viewWithTag:tagOther];
                    [roomLaber removeFromSuperview];
                }
                [self addAssetHealth:0];
            }
            
        }
    }];
}

- (void)netRequest_GetPercentage:(NSString*)roomId name:(NSString *)roomName {
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:@"3" forKey:@"state_id"];
    [params setValue:roomId forKey:@"room_id"];
    [kApi_room_points httpRequestWithParams:params networkMethod:Post isShowHud:NO andBlock:^(id data, NSError *error) {
        if (error) {
            [self showError:error];
            return ;
        }
        if ([data[@"code"] integerValue] == 1) {
             _percentage = data[@"data"][@"percentage"];
             [_pieChartView updatePercent:[_percentage floatValue] animation:YES];
            _percentLabel.attributedText = [[NSString stringWithFormat:@"<label>%@维护占总维护的%@%%</label>",roomName,_percentage] attributedStringWithStyleBook:_style];
//            int x = arc4random() % 100;
//            [_pieChartView updatePercent:x animation:YES];
        }
    }];
}





#pragma mark - Pravit method

- (void)rightButtonClick:(UIButton *)button{
    [self pushNewViewController:@"LifeServiceViewController"];
}

-(void)onclick:(UITapGestureRecognizer*)recognizer{
    int tag = (int)recognizer.view.tag;
    switch (tag) {
        case 1001:{
            _angle = 0.0;
            if (_state == 0) {

                _scoreLabel.attributedText = [[NSString stringWithFormat:@"<scord>检测\n中...</scord>"] attributedStringWithStyleBook:_style];
                [self startAnimation];
            }else{
                _state = 0;
                _scoreView.image = [UIImage imageNamed:@"home_secor01@3x"];
                _scoreLabel.attributedText = [[NSString stringWithFormat:@"<scord>房屋\n检测</scord>"] attributedStringWithStyleBook:_style];
                _sectionLabel2.attributedText = [[NSString stringWithFormat:@"<common>资产维护</common>"] attributedStringWithStyleBook:_style];
                
                _pieChartView.hidden = NO;
                _percentLabel.hidden = NO;
                _scrollView1.hidden = YES;
                _tagNum = 300;
                for (int i=0; i<_roomArry.count;i++) {
                    int tagOther = 300+i;
                    UILabel *roomLaber = (UILabel*)[self.view viewWithTag:tagOther];
                    if (_tagNum == tagOther) {
                        roomLaber.backgroundColor = [UIColor colorWithHexString:@"ECECEC"];
                        roomLaber.textColor = KMajorColor;
                        [self netRequest_GetPercentage:_roomArry[i][@"id"] name:_roomArry[i][@"name"]];
                    }else{
                        roomLaber.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
                        roomLaber.textColor = [UIColor colorWithHexString:@"616161"];
                    }
                }

//                [_pieChartView updatePercent:100 animation:YES];
                [self removePercent];
//                for (int i=0; i<_percentNum;i++) {
//                    int tagOther = 400+i;
//                    UILabel *roomLaber = (UILabel*)[self.view viewWithTag:tagOther];
//                    [roomLaber removeFromSuperview];
//                }
//                [self addAssetHealth:0];
            }
            
        }
            
            break;
        case 1002:
            _assetLabel2.hidden = YES;
            _assetView.hidden = NO;
            
            break;
        case 1003:
            _assetLabel2.hidden = NO;
             _assetView.hidden = YES;
            break;
        default:
            break;
    }
}

- (void)startAnimation

{
    
   
    CGAffineTransform endAngle = CGAffineTransformMakeRotation(_angle);
    
    [UIView animateWithDuration:0.05 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        self.scoreView.transform = endAngle;
        
    } completion:^(BOOL finished) {
        
        _angle += 360;
        
        if (_angle == 7200) {
            _scoreView.image = [UIImage imageNamed:@"home_score02@3x"];
            _scoreLabel.attributedText = [[NSString stringWithFormat:@"<scord1>%@</scord1><scord2>分</scord2>",_points] attributedStringWithStyleBook:_style];
            _sectionLabel2.attributedText = [[NSString stringWithFormat:@"<common>空间资产健康</common>"] attributedStringWithStyleBook:_style];
            
            _tagNum = 300;
            for (int i=0; i<_roomArry.count;i++) {
                int tagOther = 300+i;
                UILabel *roomLaber = (UILabel*)[self.view viewWithTag:tagOther];
                roomLaber.textColor = [UIColor colorWithHexString:@"6d6d6d"];
                int color = [self judgeTextColor:_roomArry[i][@"furnitures"]];
                if (color == 1) {
                    roomLaber.textColor = [UIColor colorWithHexString:@"F46A0C"];
                }
                if (_tagNum == tagOther) {
                    roomLaber.backgroundColor = [UIColor colorWithHexString:@"ECECEC"];
                    
                }else{
                    roomLaber.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
                   
                }
            }

            
            _pieChartView.hidden = YES;
            _percentLabel.hidden = YES;
            
            _scrollView1.hidden = NO;
            
            [self addAssetHealth:0];
            
            
            
            _state = 1;
        }else{
           [self startAnimation];
        }
        
        
    }];
    
}

-(void)addRoomMessage{
    _tagNum =300;
    _scrollView.contentSize = CGSizeMake((kScreen_Width-20)/5*2, 40*_roomArry.count);
    for (int i=0; i<_roomArry.count;i++) {
        UILabel *roomLabel = [[UILabel alloc]init];
        roomLabel.tag = 300+i;
//        NSLog(@"%ld",(long)roomLabel.tag);
        //        roomLabel.backgroundColor = [UIColor redColor];
        roomLabel.textAlignment = NSTextAlignmentCenter;
        roomLabel.attributedText = [[NSString stringWithFormat:@"<room>%d. %@</room>",i+1,_roomArry[i][@"name"]] attributedStringWithStyleBook:_style];
        if (_state ==1) {
             roomLabel.textColor = [UIColor colorWithHexString:@"6d6d6d"];
             int color = [self judgeTextColor:_roomArry[i][@"furnitures"]];
                if (color == 1) {
                    roomLabel.textColor = [UIColor colorWithHexString:@"F46A0C"];
                }
            if (_tagNum == roomLabel.tag) {
                roomLabel.backgroundColor = [UIColor colorWithHexString:@"ECECEC"];
            }
        }else{
            if (_tagNum == roomLabel.tag) {
                roomLabel.backgroundColor = [UIColor colorWithHexString:@"ECECEC"];
                roomLabel.textColor = KMajorColor;
            }
        }
        
        roomLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
        tapGesture.delegate = self;
        [roomLabel addGestureRecognizer:tapGesture];
        
        [_scrollView addSubview:roomLabel];
        
        [roomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_scrollView.mas_top).offset(40*i);
            make.left.equalTo(_scrollView.mas_left).offset(0);
            make.width.offset((kScreen_Width-20)/5*2);
            make.height.offset(40);
        }];
        
        if (i>0) {
            UIView *roomLineView = [[UIView alloc]init];
            roomLineView.backgroundColor = [UIColor colorWithHexString:@"F3F3F3"];
            [self.scrollView addSubview:roomLineView];
            
            [roomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_scrollView.mas_top).offset(40*i);
                make.left.equalTo(_scrollView.mas_left).offset(0);
                make.width.offset((kScreen_Width-20)/5*2);
                make.height.offset(0.5);
            }];
        }
        
        
    }

}

-(void)click:(UITapGestureRecognizer*)recognizer{
    int tag = (int)recognizer.view.tag;
    _tagNum = tag;

    for (int i=0; i<_roomArry.count;i++) {
        int tagOther = 300+i;
        UILabel *roomLaber = (UILabel*)[self.view viewWithTag:tagOther];
        if (tag == tagOther) {
            if (_state == 1) {
                roomLaber.backgroundColor = [UIColor colorWithHexString:@"ECECEC"];
//                roomLaber.textColor = KMajorColor;
                [self removePercent];
                [self addAssetHealth:tag-300];
            }else{
                roomLaber.backgroundColor = [UIColor colorWithHexString:@"ECECEC"];
                roomLaber.textColor = KMajorColor;
                [self netRequest_GetPercentage:_roomArry[i][@"id"] name:_roomArry[i][@"name"]];
            }
        }else{
            if (_state == 1) {
                roomLaber.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
//                roomLaber.textColor = KMajorColor;
            }else{
                roomLaber.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
                roomLaber.textColor = [UIColor colorWithHexString:@"616161"];
            }
            
        }
    }

}

-(void)addAssetHealth:(int)tag{
    NSArray *furnitures =_roomArry[tag][@"furnitures"];
//    _scrollView1.contentSize = CGSizeMake((kScreen_Width-20)/5*3, 50*5);
    NSMutableArray *furnituresOther = [[NSMutableArray alloc]init];
    
    for (int i=0; i<furnitures.count; i++) {
        if (![[NSString stringWithFormat:@"%@",furnitures[i][@"schedule"]] isEqualToString:@"<null>"]&&
            ![[NSString stringWithFormat:@"%@",furnitures[i][@"schedule"]] isEqualToString:@""]&&
            furnitures[i][@"schedule"]!=nil&&
            ![[NSString stringWithFormat:@"%@",furnitures[i][@"schedule_period"]] isEqualToString:@"<null>"]&&
            ![[NSString stringWithFormat:@"%@",furnitures[i][@"schedule_period"]] isEqualToString:@""]&&
            ![[NSString stringWithFormat:@"%@",furnitures[i][@"schedule_period"]] isEqualToString:@"0"]&&
            furnitures[i][@"schedule_period"]!=nil) {
            [furnituresOther addObject:furnitures[i]];
        }
    }
    _percentNum =(int)furnituresOther.count;
    _scrollView1.contentSize = CGSizeMake((kScreen_Width-20)/5*3, 50*furnituresOther.count);
    
   
    
    for (int j=0; j<furnituresOther.count; j++) {
        
        NSString *interval = @"";
        NSString *endTime = [NSString stringWithFormat:@"%@",furnituresOther[j][@"schedule"]];
//        interval = [self dateTimeDifferenceWithStartTime:@"" endTime:@"2016-10-21 21:34:29"];
        interval = [self dateTimeDifferenceWithStartTime:@"" endTime:endTime];
        NSString *schedule_period = [NSString stringWithFormat:@"%@",furnituresOther[j][@"schedule_period"]];
        
        UIView *bg = [[UIView alloc]init];
        bg.tag = 400+j;
        [self.scrollView1 addSubview:bg];
        
        [bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_scrollView1.mas_top).offset(50*j);
            make.left.equalTo(_scrollView1.mas_left).offset(10);
            make.width.offset((kScreen_Width-20)/5*3-20);
            make.height.offset(50);
        }];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, 57, 20)];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = KMajorColor;
        label.text = furnituresOther[j][@"name"];
        [bg addSubview:label];
        
        
        CGFloat viewWidth = (kScreen_Width-20)/5*3-20-57-25;
        
        UIView *uiviewBg = [[UIView alloc]initWithFrame:CGRectMake(57, 20, viewWidth, 20)];
        uiviewBg.layer.cornerRadius = 8;
        uiviewBg.layer.masksToBounds = YES;
        uiviewBg.layer.borderWidth = 1;
        uiviewBg.layer.borderColor = [UIColor colorWithHexString:@"DADADA"].CGColor;
        uiviewBg.backgroundColor = [UIColor whiteColor];
        [bg addSubview:uiviewBg];
        //        [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.top.equalTo(bg.mas_top).offset(10);
        //            make.left.equalTo(bg.mas_left).offset(0);
        //             make.width.offset((kScreen_Width-20)/5*3-20);
        //            make.height.offset(20);
        //        }];
//        [interval intValue]<[schedule_period intValue]
        
        if ([interval intValue]>0) {
            CGFloat pencent = [interval floatValue]/[schedule_period floatValue];
            if (pencent>1) {
                UIView *uiview1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 20)];
                uiview1.backgroundColor = KMajorColor;
                [uiviewBg addSubview:uiview1];
            }else{
                UIView *uiview1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, viewWidth*(1-pencent)*0.5, 20)];
                uiview1.backgroundColor = KMajorColor;
                [uiviewBg addSubview:uiview1];
                
                UIImageView* down = [[UIImageView alloc]initWithFrame:CGRectMake(57+viewWidth*(1-pencent)*0.5-5, 10, 10, 10)];
                down.image = [UIImage imageNamed:@"down"];
                [bg addSubview:down];
                
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(57+viewWidth*(1-pencent)*0.5-25, 40, 50, 15)];
                label.textAlignment = NSTextAlignmentCenter;
                label.attributedText =[[NSString stringWithFormat:@"<label1>保养期内</label1>"] attributedStringWithStyleBook:_style];
                label.textColor = KMajorColor;
                [bg addSubview:label];
                
            }
            
        }else if ([interval intValue]==0){
            UIView *uiview1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, viewWidth*0.5, 20)];
            uiview1.backgroundColor = KMajorColor;
            [uiviewBg addSubview:uiview1];
            
            UIImageView* down = [[UIImageView alloc]initWithFrame:CGRectMake(57+viewWidth*0.5-5, 10, 10, 10)];
            down.image = [UIImage imageNamed:@"down_red"];
            [bg addSubview:down];
            
            UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake((kScreen_Width-20)/5*3-20-25, 20, 28, 20)];
            label1.textAlignment = NSTextAlignmentLeft;
            label1.font = [UIFont systemFontOfSize:14];
            label1.textColor = [UIColor colorWithHexString:@"F46A0C"];
            label1.text = @"保养";
            [bg addSubview:label1];
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(57+viewWidth*0.5-25, 40, 50, 15)];
            label.textAlignment = NSTextAlignmentCenter;
            label.attributedText =[[NSString stringWithFormat:@"<label1>今日保养</label1>"] attributedStringWithStyleBook:_style];
            [bg addSubview:label];
            
        }else if ([interval intValue]<0){
            NSString *interval1 = [interval substringFromIndex:1];
            CGFloat pencent = [interval1 floatValue]/[schedule_period floatValue];
            
            UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake((kScreen_Width-20)/5*3-20-25, 20, 28, 20)];
            label1.textAlignment = NSTextAlignmentLeft;
            label1.font = [UIFont systemFontOfSize:14];
            label1.textColor = [UIColor colorWithHexString:@"F46A0C"];
            label1.text = @"保养";
            //        label1.backgroundColor = [UIColor blueColor];
            [bg addSubview:label1];
            if (pencent>=1) {
                UIView *uiview1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 20)];
                uiview1.backgroundColor = KMajorColor;
                [uiviewBg addSubview:uiview1];
                
                UIView *uiview2 = [[UIView alloc]initWithFrame:CGRectMake(viewWidth*0.5, 0, viewWidth*(1-pencent)*0.5, 20)];
                uiview2.backgroundColor = [UIColor colorWithHexString:@"F46A0C"];
                UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:uiview2.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(7, 8)];
                CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
                maskLayer.frame = uiview2.bounds;
                maskLayer.path = maskPath.CGPath;
                uiview2.layer.mask = maskLayer;
                [uiviewBg addSubview:uiview2];
                
                UIImageView* down = [[UIImageView alloc]initWithFrame:CGRectMake(57+viewWidth*0.5+viewWidth*0.5-5, 10, 10, 10)];
                down.image = [UIImage imageNamed:@"down_red"];
                [bg addSubview:down];
                
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(57+viewWidth*0.5+viewWidth*0.5-25, 40, 55, 15)];
                label.textAlignment = NSTextAlignmentCenter;
                label.attributedText =[[NSString stringWithFormat:@"<label1>已过%@天</label1>",interval1] attributedStringWithStyleBook:_style];
                [bg addSubview:label];

            }else{
                UIView *uiview1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, viewWidth*0.5, 20)];
                uiview1.backgroundColor = KMajorColor;
                [uiviewBg addSubview:uiview1];
                
                UIView *uiview2 = [[UIView alloc]initWithFrame:CGRectMake(viewWidth*0.5, 0, viewWidth*(1-pencent)*0.5, 20)];
                uiview2.backgroundColor = [UIColor colorWithHexString:@"F46A0C"];
                UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:uiview2.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(7, 8)];
                CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
                maskLayer.frame = uiview2.bounds;
                maskLayer.path = maskPath.CGPath;
                uiview2.layer.mask = maskLayer;
                [uiviewBg addSubview:uiview2];
                
                UIImageView* down = [[UIImageView alloc]initWithFrame:CGRectMake(57+viewWidth*0.5+viewWidth*(1-pencent)*0.5-5, 10, 10, 10)];
                down.image = [UIImage imageNamed:@"down_red"];
                [bg addSubview:down];
                
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(57+viewWidth*0.5+viewWidth*(1-pencent)*0.5-25, 40, 55, 15)];
                label.textAlignment = NSTextAlignmentCenter;
                label.attributedText =[[NSString stringWithFormat:@"<label1>已过%@天</label1>",interval1] attributedStringWithStyleBook:_style];
                [bg addSubview:label];
            }

            
            
        }
        
//        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake((kScreen_Width-20)/5*3-20-25, 20, 28, 20)];
//        label1.textAlignment = NSTextAlignmentLeft;
//        label1.font = [UIFont systemFontOfSize:14];
//        label1.textColor = [UIColor colorWithHexString:@"F26A24"];
//        label1.text = @"保养";
//        //        label1.backgroundColor = [UIColor blueColor];
//        [bg addSubview:label1];
//
//        
//        UIView *uiview1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, viewWidth*0.5, 20)];
//        uiview1.backgroundColor = KMajorColor;
//        [uiviewBg addSubview:uiview1];
//        
//        UIView *uiview2 = [[UIView alloc]initWithFrame:CGRectMake(viewWidth*0.5, 0, viewWidth*0.2, 20)];
//        uiview2.backgroundColor = [UIColor colorWithHexString:@"F26A24"];
//        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:uiview2.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(7, 8)];
//        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//        maskLayer.frame = uiview2.bounds;
//        maskLayer.path = maskPath.CGPath;
//        uiview2.layer.mask = maskLayer;
//        [uiviewBg addSubview:uiview2];

        
    }
    
    
}

-(NSString *)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    startTime=[formatter stringFromDate:[NSDate date]];
    
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *startD =[date dateFromString:startTime];
    NSDate *endD = [date dateFromString:endTime];
    NSTimeInterval start = [startD timeIntervalSince1970]*1;
    NSTimeInterval end = [endD timeIntervalSince1970]*1;
    NSTimeInterval value = end - start;
    int second = (int)value %60;//秒
    int minute = (int)value /60%60;
    int house = (int)value / (24 * 3600)%3600;
    int day = (int)value / (24 * 3600);
    NSString *str;
    if (day != 0) {
        str =[NSString stringWithFormat:@"%d",day+1];
//        str = [NSString stringWithFormat:@"耗时%d天%d小时%d分%d秒",day,house,minute,second];
    }else if (day==0 && house != 0) {
        str = [NSString stringWithFormat:@"耗时%d小时%d分%d秒",house,minute,second];
    }else if (day== 0 && house== 0 && minute!=0) {
        str = [NSString stringWithFormat:@"耗时%d分%d秒",minute,second];
    }else{
        str = [NSString stringWithFormat:@"耗时%d秒",second];
    }
    return str;
}

-(void)removePercent{
    for (int i=0; i<_percentNum;i++) {
        int tagOther = 400+i;
        UILabel *roomLaber = (UILabel*)[self.view viewWithTag:tagOther];
        [roomLaber removeFromSuperview];
    }

}

-(int)judgeTextColor:(NSArray*)furnitures{
        NSMutableArray *furnituresOther = [[NSMutableArray alloc]init];
        
        for (int i=0; i<furnitures.count; i++) {
            if (![[NSString stringWithFormat:@"%@",furnitures[i][@"schedule"]] isEqualToString:@"<null>"]&&
                ![[NSString stringWithFormat:@"%@",furnitures[i][@"schedule"]] isEqualToString:@""]&&
                furnitures[i][@"schedule"]!=nil&&
                ![[NSString stringWithFormat:@"%@",furnitures[i][@"schedule_period"]] isEqualToString:@"<null>"]&&
                ![[NSString stringWithFormat:@"%@",furnitures[i][@"schedule_period"]] isEqualToString:@""]&&
                ![[NSString stringWithFormat:@"%@",furnitures[i][@"schedule_period"]] isEqualToString:@"0"]&&
                furnitures[i][@"schedule_period"]!=nil) {
                [furnituresOther addObject:furnitures[i]];
            }
        }
    
    for (int j=0; j<furnituresOther.count; j++) {
        
        NSString *interval = @"";
        NSString *endTime = [NSString stringWithFormat:@"%@",furnituresOther[j][@"schedule"]];
        interval = [self dateTimeDifferenceWithStartTime:@"" endTime:endTime];
        if ([interval intValue]<=0) {
            return 1;
        }
    }

    
    

    return 0;
}


@end
