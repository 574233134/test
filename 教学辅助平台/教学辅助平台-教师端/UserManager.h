//
//  UserManager.h
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2017/12/29.
//  Copyright © 2017年 郭挺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BmobSDK/Bmob.h>

typedef void (^CompleteBlock)(int result);
typedef void (^CompleteAndResultBlock)(int result,NSArray *array);
typedef void (^CompleteAndObjectBlock)(int result,BmobObject *bmobObject);
@interface UserManager : NSObject

@property (retain) BmobObject *userInfo;

//获取单例
+(instancetype)sharedUserManager;

//注册
-(void)toRegister:(NSString *)username with:(NSString *)password block:(CompleteBlock) complete;

//登录
-(void)logInUser:(NSString *)username with:(NSString *)password block:(CompleteBlock) complete;

//退出登录
-(void)logOut;

//更改密码
-(void)changeWithNewPassword:(NSString *) password block:(CompleteBlock) complete;

//更新用户信息
-(void)updateUserInfoFromBackgroundWithblock:(CompleteBlock) complete;

//判断是否登录
-(BOOL)isLogin;

//判断是否为管理员
-(BOOL)getIsManagerFromLocal;

//获取objectId
-(NSString *)getObjectIdFromLocal;

//新建文件夹
-(void)newFolderWithName:(NSString *)folderName path:(NSString *) path block:(CompleteBlock) complete;
//删除文件夹
-(void)removeFolderWithObjectId:(NSString *)objectId Name:(NSString *)folderName path:(NSString *) path block:(CompleteBlock) complete;
//新建书籍
-(void)newBookWithName:(NSString *)bookName info:(NSDictionary *)bookInfo path:(NSString *) path block:(CompleteBlock) complete;
//删除书籍
-(void)removeBookWithObjectId:(NSString *)objectId block:(CompleteBlock) complete;
//获取某个路径下的文件夹
-(void)getFolderWithPath:(NSString *)path block:(CompleteAndResultBlock) completeAndResult;
//获取某个路径下的书籍
-(void)getBookWithPath:(NSString *)path block:(CompleteAndResultBlock) completeAndResult;
//保存反馈到后台
-(void)saveSuggestionToBackgroundWith:(NSString *)username type:(NSString *)type description:(NSString *)description contact:(NSString *)contact block:(CompleteBlock) complete;
//------------课堂模块-----------
//-----教师端------
//新建一个课程
-(void)newCourseWithName:(NSString *)coursename teacher:(BmobObject *)teacher block:(CompleteBlock) complete;
//删除指定的课程
-(void)removeCourseWithObjectId:(NSString *)objectId block:(CompleteBlock) complete;
//获取某个教师的所有课程
-(void)getCoursesWithTeacher:(BmobObject *)techer block:(CompleteAndResultBlock) completeAndResult;
//保存到题库（选择题）
-(void)saveToBankWithQuestion:(NSString *)question choiceA:(NSString *)choiceA choiceB:(NSString *)choiceB choiceC:(NSString *)choiceC choiceD:(NSString *)choiceD andAnswer:(NSString *)answer score:(NSNumber *)score block:(CompleteAndObjectBlock) complete;
//拉取题库（适用于所有题型）
-(void)getQuestionsWithType:(NSString *)type block:(CompleteAndResultBlock) completeAndResult;
//删除指定课堂的当前作业（必须指出所有已支持的题型。题型字符串：choice、judge、fill、QandA）
-(void)deleteTaskOfCourseWithObjectId:(NSString *)objectId types:(NSArray *)types block:(CompleteBlock) complete;
//添加指定题型到指定课程
-(void)addQuestions:(NSArray *)questions WithType:(NSString *)type toCourse:(BmobObject *)course;
//提交指定课程的当前作业（即所有添加的题型）到后台
-(void)submitTastWithTitle:(NSString *)title course:(BmobObject *)course block:(CompleteBlock) complete;
//获取指定课程的指定作业
-(void)getQuestionsOfCourse:(BmobObject *)course WithType:(NSString *)type block:(CompleteAndResultBlock) completeAndResult;
@end
