//
//  AssetInvoiceViewController.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/11/25.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "AssetInvoiceViewController.h"
#import "BaseModel.h"

@interface AssetInvoiceViewController ()<UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView *invoiceImageView;

@property (nonatomic, strong) FurnitureModel *model;

@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, strong) UIImageView *noInvoiceImageView;
@property (nonatomic, strong) UILabel *noInvoiceLabel;
@property (nonatomic, strong) UIButton *noInvoiceButton;

@end

@implementation AssetInvoiceViewController

#pragma mark - life circle
- (void)dealloc {
    NSLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的发票";
    
    _model = self.receiveParams[@"model"];
    
    [self.view addSubview:self.scrollView];
    
    
    [self netRequestGetImage];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - method

/**
 *  push到相册或者拍照页面
 *
 *  @param sourceType SavedPhotosAlbum-相册 | Camera-拍照
 */
- (void)showImagePickerControllerWithSourceType:(UIImagePickerControllerSourceType)sourceType{
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc] init];
    imagePicker.delegate=self;
    
    if([UIImagePickerController isSourceTypeAvailable:sourceType]){
        imagePicker.sourceType = sourceType;
    }
    imagePicker.allowsEditing = YES;
    [self presentViewController:imagePicker animated:YES completion:nil];
}


/**
 设置image
 */
- (void)setInvoiceImageViewImageWithUrl:(NSString *)url{
    [_invoiceImageView sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) {
            [self showError:error];
            return ;
        }
        if (image) {
            CGFloat imageW = image.size.width;
            CGFloat imageH = image.size.height;
            
            CGFloat width = MIN(imageW, kScreen_Width);
            CGFloat height = width * imageH / imageW;
            
            _scrollView.contentSize = CGSizeMake(0, MAX(width * imageH / imageW, kScreen_Height - kNavHeight));
            _invoiceImageView.frame = CGRectMake(0, 0, width, height);
            
        }
    }];

}


- (void)showNoInvoiceView{
    [_scrollView addSubview:self.noInvoiceImageView];
    [_scrollView addSubview:self.noInvoiceLabel];
    [_scrollView addSubview:self.noInvoiceButton];
}

- (void)hidNoInvoiceView{
    [self.noInvoiceImageView removeFromSuperview];
    [self.noInvoiceLabel removeFromSuperview];
    [self.noInvoiceButton removeFromSuperview];
    
    [self.scrollView addSubview:self.invoiceImageView];
}

#pragma mark - event

- (void)updateImage{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cameraAlertAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self showImagePickerControllerWithSourceType:UIImagePickerControllerSourceTypeCamera];
    }];
    
    UIAlertAction *photoAlertAction = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self showImagePickerControllerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertVC addAction:cameraAlertAction];
    [alertVC addAction:photoAlertAction];
    [alertVC addAction:cancelAction];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource

#pragma mark - getter && setter

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:kViewFrame];
        _scrollView.backgroundColor = kBackgroundColor;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.minimumZoomScale = 1;
        _scrollView.maximumZoomScale = 2;
        _scrollView.contentSize = _scrollView.bounds.size;
        
    }
    return _scrollView;
}

- (UIImageView *)invoiceImageView{
    if (!_invoiceImageView) {
        _invoiceImageView = [[UIImageView alloc] init];
    }
    return _invoiceImageView;
}

- (UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [_rightButton setTitle:@"更改" forState:UIControlStateNormal];
        [_rightButton setTitleColor:KMajorColor forState:UIControlStateNormal];
        _rightButton.titleLabel.font = kFont14;
        [_rightButton addTarget:self action:@selector(updateImage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

- (UIImageView *)noInvoiceImageView{
    if (!_noInvoiceImageView) {
        _noInvoiceImageView = [[UIImageView alloc] initWithImage:Image(@"invoice")];
        _noInvoiceImageView.frame = CGRectMake(0, 30, 220, 200);
        _noInvoiceImageView.centerX = self.view.centerX;
        
    }
    return _noInvoiceImageView;
}

- (UILabel *)noInvoiceLabel{
    if (!_noInvoiceButton) {
        _noInvoiceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.noInvoiceImageView.bottom + 20, kScreen_Width, 55)];
        _noInvoiceLabel.font = kFont14;
        _noInvoiceLabel.textAlignment = NSTextAlignmentCenter;
        _noInvoiceLabel.textColor = Color_Hex(@"666666");
        _noInvoiceLabel.numberOfLines = 0;
        _noInvoiceLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _noInvoiceLabel.text = @"请上传设备发票\n以便更好的管理你您的资产";
    }
    return _noInvoiceLabel;
}

- (UIButton *)noInvoiceButton{
    if (!_noInvoiceButton) {
        _noInvoiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _noInvoiceButton.frame = CGRectMake(0, self.noInvoiceLabel.bottom + 10 , kScreen_Width - 40, 45);
        _noInvoiceButton.centerX = self.view.centerX;
        [_noInvoiceButton setTitle:@"上传" forState:UIControlStateNormal];
        [_noInvoiceButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_noInvoiceButton setBackgroundColor:KMajorColor];
        _noInvoiceButton.layer.cornerRadius = 4;
        _noInvoiceButton.layer.masksToBounds = YES;
        [_noInvoiceButton addTarget:self action:@selector(updateImage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _noInvoiceButton;
}

#pragma mark - API

//获取发票
- (void)netRequestGetImage{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:_model.id forKey:@"type_id"];
    [params setValue:@"invoice" forKey:@"type"];
    [kApi_member_image httpRequestWithParams:params hudView:self.hudView networkMethod:Post andBlock:^(id data, NSError *error) {
        if (error) {
            [self showError:error];
            return ;
        }
        
        NSString *url = @"";
        if ([data[@"data"] isKindOfClass:[NSDictionary class]]) {
            url = data[@"data"][@"url"];
        }
        
        _model.invoice = url;
        
        if (url.length == 0) {
            [self showNoInvoiceView];
        }
        else{
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
            [_scrollView addSubview:self.invoiceImageView];
        }
        [self setInvoiceImageViewImageWithUrl:url];
        
        
    }];
}


//上传发票
- (void)netRequestUploadImage:(UIImage *)image{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"invoice" forKey:@"type"];
    [params setValue:_model.id forKey:@"type_id"];
    
    [kApi_member_upload uploadImageWithParams:params image:image andBlock:^(id data, NSError *error) {
        if (error) {
            [self showError:error];
            return ;
        }
        if ([data[@"code"] integerValue] == 1) {
            NSLog(@"%@",data);
            if ([data[@"code"] integerValue] == 1) {
                
                [self hidNoInvoiceView];
                
                [self showHudTipStr:@"上传成功"];
                _invoiceImageView.image = image;
                
                NSString *url = data[@"data"][@"url"];
                
                [self setInvoiceImageViewImageWithUrl:url];
                _model.invoice = url;
                
            }
        }
    } progressBlock:^(CGFloat progress) {
        if (progress >= 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hide:YES];
            });
           
        }
    }];
}

#pragma mark - override

#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [self dismissViewControllerAnimated:YES completion:nil];
    picker.allowsEditing = YES;
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    [self netRequestUploadImage:image];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _invoiceImageView;
}

@end
