//
//  CloudKitViewController.m
//  CloudKitDemo
//
//  Created by XiaoDev on 2022/11/18.
//

#import "CloudKitViewController.h"
#import <CloudKit/CloudKit.h>
#define  RecordType @"Note"
@interface CloudKitViewController ()

@end

@implementation CloudKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
}
- (IBAction)publicWriteAction:(id)sender {
    [self saveTitle:@"公共写入" content:@"公共写入内容" public:YES];
}
- (IBAction)publicReadAction:(id)sender {
    [self queryCloudKitDataPublic:YES];
}
- (IBAction)privateWriteAction:(id)sender {
    [self saveTitle:@"私人写入" content:@"私人写入内容" public:NO];
}
- (IBAction)privateReadAction:(id)sender {
    [self queryCloudKitDataPublic:NO];
}

- (void)saveTitle:(NSString *)title content:(NSString *)content public:(BOOL)public {
    //默认的bundleid相应的containerid
    CKContainer *container = [CKContainer defaultContainer];
    //同一个账号下的其他containerid 也可以在这个应用内使用。
//    container = [CKContainer containerWithIdentifier:@""];
    //获取当前账号状态
    [container accountStatusWithCompletionHandler:^(CKAccountStatus accountStatus, NSError * _Nullable error) {
            
    }];
    
    CKDatabase *database = nil;
//    CKDatabase *database = container.sharedCloudDatabase;
    if (public) {
        database = container.publicCloudDatabase;
    } else {
        database = container.privateCloudDatabase;
    }
     
    CKRecord *noteRecord = [[CKRecord alloc] initWithRecordType:RecordType];
    
    [noteRecord setValue:title forKey:@"title"];
    [noteRecord setValue:content forKey:@"content"];
    [database saveRecord:noteRecord completionHandler:^(CKRecord * _Nullable record, NSError * _Nullable error) {
        if(!error)
        {
            NSLog(@"保存成功 == %@",record);
            [self querySingleRecordWithRecordID:record.recordID];
        }
        else
        {
            NSLog(@"保存失败");
            NSLog(@"%@",error.description);
        }
    }];
    
}
- (void)queryCloudKitDataPublic:(BOOL)public {
    //获取位置
    CKContainer *container = [CKContainer defaultContainer];
    //请求电子邮件权限。
    [container requestApplicationPermission:CKApplicationPermissionUserDiscoverability completionHandler:^(CKApplicationPermissionStatus applicationPermissionStatus, NSError * _Nullable error) {
        if (error) {
            NSLog(@"3 == %@: %@", NSStringFromSelector(_cmd), error);
        }
    }];
    CKDatabase *database = nil;
    if (public) {
        database = container.publicCloudDatabase;
    } else {
        database = container.privateCloudDatabase;
    }
    //添加查询条件
    NSPredicate *predicate = [NSPredicate predicateWithValue:YES];
    CKQuery *query = [[CKQuery alloc] initWithRecordType:RecordType predicate:predicate];
    
    //开始查询
    [database performQuery:query inZoneWithID:nil completionHandler:^(NSArray<CKRecord *> * _Nullable results, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"1== %@ ",error);
        } else {
            NSLog(@"1== %@ ",results);
        }
    }];
}
//查询单条数据
- (void)querySingleRecordWithRecordID:(CKRecordID *)recordID
{
    //获取容器
    CKContainer *container = [CKContainer defaultContainer];
    //获取公有数据库
    CKDatabase *database = container.publicCloudDatabase;
    
    [database fetchRecordWithID:recordID completionHandler:^(CKRecord * _Nullable record, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                NSLog(@"2== %@ ",error);
            } else {
                NSLog(@"2== %@ ",record);
            }
        });
    }];
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
