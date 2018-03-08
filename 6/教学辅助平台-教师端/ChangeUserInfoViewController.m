//
//  ChangeUserInfoViewController.m
//  教学辅助平台-教师端
//
//  Created by 李梦珂 on 2018/1/3.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "ChangeUserInfoViewController.h"
#import <Masonry.h>
@interface ChangeUserInfoViewController ()

@end

@implementation ChangeUserInfoViewController
{
    UITableView *userinfotableview;
    NSArray *section0Array;
    NSArray *section1Array;
    UIButton *uploadPhoto;
    NSMutableDictionary *infoDic;
}
- (void)viewDidLoad {
   
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)loadView
{
    [super loadView];
    [self loadSubviews];
}
-(void)loadSubviews
{
     self.view.backgroundColor = [UIColor whiteColor];
    userinfotableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 120, self.view.frame.size.width, self.view.frame.size.height-254) style:UITableViewStyleGrouped];
   // userinfotableview.backgroundColor = [UIColor grayColor];
    userinfotableview.delegate = self;
    userinfotableview.dataSource = self;
    userinfotableview.bounces = NO;
    [self.view addSubview:userinfotableview];
    
    section0Array = [[NSArray alloc]initWithObjects:@"姓名",@"性别",@"联系方式", nil];
    section1Array = [[NSArray alloc]initWithObjects:@"学校",@"教工号", nil];
    infoDic = [[NSMutableDictionary alloc]init];
    
    uploadPhoto = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.view addSubview:uploadPhoto];
    [uploadPhoto setBackgroundImage:[UIImage imageNamed:@"上传图片"] forState:UIControlStateNormal];
    [uploadPhoto addTarget:self action:@selector(uploadPhoto) forControlEvents:UIControlEventTouchUpInside];
    [uploadPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(20);
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
 
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [saveButton setTintColor:[UIColor whiteColor]];
    [saveButton setTitle:@"保存修改" forState:UIControlStateNormal];
    saveButton.backgroundColor = [UIColor colorWithRed:243/256.0 green:92/256.0 blue:90/256.0 alpha:1];
    saveButton.layer.cornerRadius = 5;
    [saveButton addTarget:self action:@selector(saveUserInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];
    [saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userinfotableview.mas_bottom);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width-30, 40));
    }];
    
}
-(void)saveUserInfo
{
    NSArray *array = [infoDic allKeys];
    for (NSString *key in array)
    {
        NSLog(@"%@:%@",key,infoDic[key]);
    }
    self.block(infoDic);
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)uploadPhoto
{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    alertVc.title.accessibilityElementsHidden = YES;
    UIAlertAction *album = [UIAlertAction actionWithTitle:@"从相册上传" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //打开本地相册
        [self openLocalPicter];
    }];
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        // 开始拍照
        [self takePhoto];
        
    } ];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVc addAction:album];
    [alertVc addAction:camera];
    [alertVc addAction:cancel];
    [self presentViewController:alertVc animated:YES completion:^{
        
    }];
}
//调用相册
-(void)openLocalPicter
{
    // 判断相册是否可用
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        // 实例化UIImagePickerController控制器
        UIImagePickerController * imagePickerVC = [[UIImagePickerController alloc] init];
        // 设置资源来源（相册、相机、图库之一）
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 允许的视屏质量（如果质量选取的质量过高，会自动降低质量）
        imagePickerVC.videoQuality = UIImagePickerControllerQualityTypeHigh;
        // 设置代理，遵守UINavigationControllerDelegate, UIImagePickerControllerDelegate 协议
        imagePickerVC.delegate = self;
        // 是否允许编辑（YES：图片选择完成进入编辑模式）
        imagePickerVC.allowsEditing = YES;
        // model出控制器
        [self presentViewController:imagePickerVC animated:YES completion:nil];
    }
    
}
//调用相机
-(void)takePhoto
{       // 判断相机是否可用
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        // 实例化UIImagePickerController控制器
        UIImagePickerController * imagePickerVC = [[UIImagePickerController alloc] init];
        // 设置资源来源
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        // 设置代理，遵守UINavigationControllerDelegate, UIImagePickerControllerDelegate 协议
        imagePickerVC.delegate = self;
        // 是否允许编辑
        imagePickerVC.allowsEditing = YES;
        // 允许的视屏质量（如果质量选取的质量过高，会自动降低质量）
        imagePickerVC.videoQuality = UIImagePickerControllerQualityTypeHigh;
        // 相机获取媒体的类型（照相、录制视屏）
        imagePickerVC.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        // 使用前置还是后置摄像头
        imagePickerVC.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        // 是否看起闪光灯
        imagePickerVC.cameraFlashMode = UIImagePickerControllerCameraFlashModeOn;
        // imagePickerVC.showsCameraControls = NO;
        // model出控制器
        [self presentViewController:imagePickerVC animated:YES completion:nil];
        
    }
    else
    {
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:@"相机不可用!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertVc addAction:okAction];
        [self presentViewController:alertVc animated:YES completion:nil];
        
    }
    
    
}
// 选择图片成功调用此方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // dismiss UIImagePickerController
    [self dismissViewControllerAnimated:YES completion:nil];
    // 选择的图片信息存储于info字典中
    //    在操作完成回调info字典中,拥有如下可用信息
    //    UIImagePickerControllerMediaType // 媒体类型（kUTTypeImage、kUTTypeMovie等）
    //    UIImagePickerControllerOriginalImage // 原始图片
    //    UIImagePickerControllerEditedImage // 编辑后图片
    //    UIImagePickerControllerCropRect // 裁剪尺寸
    //    UIImagePickerControllerMediaMetadata // 拍照的元数据
    //    UIImagePickerControllerMediaURL // 媒体的URL
    //    UIImagePickerControllerReferenceURL // 引用相册的URL
    //    UIImagePickerControllerLivePhoto // PHLivePhoto1234567812345678
    infoDic[@"info"] = info;
    [uploadPhoto setBackgroundImage:info[UIImagePickerControllerEditedImage]  forState:UIControlStateNormal];
    
}


// 取消图片选择调用此方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    // dismiss UIImagePickerController
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma UserInfoTableViewCellDelegate
// cell的代理方法中拿到text进行保存
- (void)contentDidChanged:(NSString *)text forIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0)
    {
        infoDic[section0Array[indexPath.row]] = text;
    }
    else
        infoDic[section1Array[indexPath.row]] = text;
}

#pragma tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }
    else
        return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    UserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell)
    {
        cell = [[UserInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
    }
    if (indexPath.section == 0)
    {
        cell.titlelabel.text = section0Array[indexPath.row];
    }
    else
        cell.titlelabel.text = section1Array[indexPath.row];
    cell.infoTextfield.indexPath = indexPath;
    cell.infoTextfield.textAlignment = NSTextAlignmentRight;
    cell.delegate = self;
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
#pragma tableview delegate
- (nullable NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:
    (NSIndexPath *)indexPath
{
       return indexPath;
}
#pragma textfield delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
