//
//  NewClassViewController.m
//  教学辅助平台-教师端
//
//  Created by 李梦珂 on 2018/1/7.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "NewClassViewController.h"
#import <Masonry.h>
#import <Photos/Photos.h>
#import <MediaPlayer/MediaPlayer.h>
@interface NewClassViewController ()

@end

@implementation NewClassViewController
{
    UIButton *uploadPhoto; // 课程封面
    UITextField *className; //班级名
    UITextField *courseName; // 课程名
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadView
{
    [super loadView];
    [self loadSubviews];
}
-(void)loadSubviews
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    
    
    
    uploadPhoto = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [uploadPhoto setBackgroundImage:[UIImage imageNamed: @"上传图片"] forState:UIControlStateNormal];
    [uploadPhoto addTarget:self action:@selector(uploadPhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:uploadPhoto];
    [uploadPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(50);
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    UILabel *tipLabel = [[UILabel alloc]init];
    tipLabel.font = [UIFont systemFontOfSize:12];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.text = @"课程封面";
    [self.view addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(uploadPhoto.mas_bottom).offset(1);
        make.centerX.equalTo(uploadPhoto.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(50, 18));
    }];
    UIImageView *line1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line"]];
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(uploadPhoto.mas_bottom).offset(40);
        make.left.equalTo(self.view.mas_left).offset(5);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width-10, 1));
    }];
    
    UILabel *classLabel = [[UILabel alloc]init];
    classLabel.text = @"班级";
    [self.view addSubview:classLabel];
    [classLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.mas_bottom).offset(1);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.size.mas_equalTo(CGSizeMake(60, 42));
    }];
    
    className = [[UITextField alloc]init];
    className.placeholder = @"未设置";
    className.delegate = self;
    className.font = [UIFont systemFontOfSize:13];
    className.textAlignment=NSTextAlignmentRight;
    [self.view addSubview:className];
    [className mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(classLabel.mas_right);
        make.top.equalTo(classLabel.mas_top);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width-90, 42));
    }];
    
    UIImageView *line2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line"]];
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(classLabel.mas_bottom).offset(1);
        make.left.equalTo(self.view.mas_left).offset(5);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width-10, 1));
    }];

    UILabel *courseLabel = [[UILabel alloc]init];
    courseLabel.text = @"课程";
    [self.view addSubview:courseLabel];
    [courseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(classLabel.mas_left);
        make.top.equalTo(line2.mas_bottom).offset(1);
        make.size.mas_equalTo(CGSizeMake(60, 42));
    }];
    courseName = [[UITextField alloc]init];
    courseName.textAlignment=NSTextAlignmentRight;
    courseName.delegate = self;
    courseName.placeholder = @"未设置";
    courseName.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:courseName];
    [courseName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(className.mas_left);
        make.top.equalTo(courseLabel.mas_top);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width-90, 42));
    }];
    
    UIImageView *line3 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line"]];
    [self.view addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(courseLabel.mas_bottom).offset(1);
        make.left.equalTo(self.view.mas_left).offset(5);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width-10, 1));
    }];
    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    saveButton.layer.cornerRadius = 5;
    saveButton.layer.borderColor = [UIColor whiteColor].CGColor;
    [saveButton setTintColor:[UIColor whiteColor]];
    saveButton.backgroundColor = [UIColor colorWithRed:243/256.0 green:92/256.0 blue:90/256.0 alpha:1];
    [saveButton setTitle:@"创建" forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(addClass) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];
    [saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(courseLabel.mas_left);
        make.top.equalTo(line3.mas_bottom).offset(30);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width-30, 40));
    }];}
//上传课程封面
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

-(void)cancel
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)addClass
{
    [className resignFirstResponder];
    [courseName resignFirstResponder];
    NSLog(@"创建课程");
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [className resignFirstResponder];
    [courseName resignFirstResponder];
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
    [uploadPhoto setBackgroundImage:info[UIImagePickerControllerEditedImage]  forState:UIControlStateNormal];
}


// 取消图片选择调用此方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    // dismiss UIImagePickerController
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma textfiele delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
