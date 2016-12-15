//
//  PsersonalInfoViewController.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/11/7.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "PsersonalInfoViewController.h"
#import "PsersonalInfoTableView.h"
#import "MBProgressHUD+Custom.h"


@interface PsersonalInfoViewController ()<BaseTableViewDelegate,PsersonalInfoTableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) PsersonalInfoTableView *tableView;

@end

@implementation PsersonalInfoViewController

#pragma mark - Cycle life
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    
    _userAccoutBlock = self.receiveParams[@"block"];
    
    [self.view addSubview:self.tableView];
    
    [self netRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Getter and setter

- (PsersonalInfoTableView *)tableView{
    if (!_tableView) {
        _tableView = [[PsersonalInfoTableView alloc] initWithFrame:kViewFrame];
        _tableView.clickDelegate = self;
        _tableView.editGenderDelegate = self;
    }
    return _tableView;
}

#pragma mark - Delegate

- (void)BaseTableViewClickWithIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        //编辑name
    }
    else{
        //编辑nickName
        
    }
    NSString *title = indexPath.row == 1 ? @"姓名" : @"昵称";
    WS(weakSelf);
    EditInfoBlock block = ^(UserAccout *userAccout){
        weakSelf.tableView.userAccout = userAccout;
        if (weakSelf.userAccoutBlock) {
            weakSelf.userAccoutBlock(_tableView.userAccout);
        }
        [weakSelf.tableView reloadData];
    };
    [self pushNewViewController:@"EditPsersonalInfoViewController" params:@{@"type":[NSString stringWithFormat:@"%ld",indexPath.row],@"userAccout":_tableView.userAccout,@"title":title,@"block":block}];
}

- (void)editGenderWithGender:(NSInteger)gender{
    [self netRequest_editGender:(NSInteger)gender];
}

- (void)avaterClick{
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

#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [self dismissViewControllerAnimated:YES completion:nil];
    picker.allowsEditing = YES;
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    [self netRequestUploadHeadImage:image];
}

#pragma mark - Net request

//获取个人信息
- (void)netRequest{
    [kApi_member_info httpRequestWithParams:nil networkMethod:Post andBlock:^(id data, NSError *error) {
        if (error) {
            [self showError:error];
            return ;
        }
        if ([data[@"code"] integerValue] == 1) {
            
            UserAccout *userAccout = [[UserAccout alloc] initWithDic:data[@"data"]];
            _tableView.userAccout = userAccout;
            [self netRequestGetImage];
        }
    }];
}

//获取头像
- (void)netRequestGetImage{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:[UsersManager memberId] forKey:@"type_id"];
    [params setValue:@"head" forKey:@"type"];
    [kApi_member_image httpRequestWithParams:params hudView:nil networkMethod:Post andBlock:^(id data, NSError *error) {
        if (error) {
            [self showError:error];
            return ;
        }
        if ([data[@"code"] integerValue] == 1) {
            _tableView.userAccout.avatar = data[@"data"][@"url"];
            [_tableView reloadData];
        }
    }];
}

//编辑性别
- (void)netRequest_editGender:(NSInteger)gender{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:_tableView.userAccout.nickname forKey:@"nickname"];
    [params setValue:_tableView.userAccout.name forKey:@"name"];
    [params setValue:@(gender) forKey:@"gender"];
    [params setValue:_tableView.userAccout.birth forKey:@"birth"];
    [kApi_member_update httpRequestWithParams:params networkMethod:Post andBlock:^(id data, NSError *error) {
        if (error) {
            [self showError:error];
            return ;
        }
        if ([data[@"code"] integerValue] == 1) {
            _tableView.userAccout = [[UserAccout alloc] initWithDic:data[@"data"]];
            if (self.userAccoutBlock) {
                self.userAccoutBlock(_tableView.userAccout);
            }
            [_tableView reloadData];
        }
    }];
}

//上传头像
- (void)netRequestUploadHeadImage:(UIImage *)image{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"head" forKey:@"type"];
    [params setValue:[UsersManager memberId] forKey:@"type_id"];
    [kApi_member_upload uploadImageWithParams:params image:image andBlock:^(id data, NSError *error) {
        
        NSLog(@"%@",data);
        if ([data[@"code"] integerValue] == 1) {
            [self showHudTipStr:@"上传成功"];
            _tableView.userAccout.avatar = data[@"data"][@"url"];
            if (self.userAccoutBlock) {
                self.userAccoutBlock(_tableView.userAccout);
            }
            [_tableView reloadData];
        }
    } progressBlock:^(CGFloat progress) {
        NSLog(@"%f",progress);
        if (progress >= 1) {

            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });
            
        }
        [hud setProgress:progress];
    }];
}

#pragma mark - Event method


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


#pragma mark - Pravit method

@end
