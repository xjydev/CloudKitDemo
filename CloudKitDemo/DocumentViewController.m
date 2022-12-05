//
//  DocumentViewController.m
//  CloudKitDemo
//
//  Created by XiaoDev on 2022/11/18.
//

#import "DocumentViewController.h"
#import "DemoDocument.h"
@interface DocumentViewController ()
@property (nonatomic, strong)NSMetadataQuery *dataQuery;
@end

@implementation DocumentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataQuery = [[NSMetadataQuery alloc]init];
    //获取最新数据完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getAllDocument:) name:NSMetadataQueryDidFinishGatheringNotification object:self.dataQuery];
    //数据更新通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateDocument:) name:NSMetadataQueryDidUpdateNotification object:self.dataQuery];
}
- (NSURL *)getUbiquityContainerURLWithName:(NSString *)name {
    NSURL *ubiquityURL = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:@"iCloud.co.xiaodev.icloud"];
    if(!ubiquityURL)
    {
        NSLog(@"尚未开启iCloud功能");
        return nil;
    }
    NSURL *fileURL = [ubiquityURL URLByAppendingPathComponent:name];
    return fileURL;
}
- (IBAction)saveButtonAction:(id)sender {
    NSURL *fileURL = [self getUbiquityContainerURLWithName:@"wish"];
    DemoDocument *doc = [[DemoDocument alloc]initWithFileURL:fileURL];
    NSURL *localFile = [[NSBundle mainBundle]pathForResource:@"wish2" ofType:@"json"];
    doc.data = [[NSData data]initWithContentsOfURL:localFile];
    [doc saveToURL:fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
        if(success){
            NSLog(@"创建文档成功");
        }
        else{
            NSLog(@"创建文档失败");
        }
    }];
}
- (IBAction)readButtonAction:(id)sender {
    DemoDocument *doc = [[DemoDocument alloc]initWithFileURL:[self getUbiquityContainerURLWithName:@"wish"]];
    [doc openWithCompletionHandler:^(BOOL success) {
        NSString *docContent = [[NSString alloc]initWithData:doc.data encoding:NSUTF8StringEncoding];
        NSLog(@"读取成功 == %@",docContent);
    }];
}
- (IBAction)allReadButtonAction:(id)sender {
    [self.dataQuery setSearchScopes:@[NSMetadataQueryUbiquitousDocumentsScope]];
    [self.dataQuery startQuery];
}
- (void)getAllDocument:(NSMetadataQuery *)metadataQuery {
    [self.dataQuery.results enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([obj isKindOfClass:[NSMetadataItem class]]) {
            NSMetadataItem *item = obj;
            NSString *fileName = [item valueForAttribute:NSMetadataItemFSNameKey];
            NSLog(@"fileName ======= %@",fileName);
        }
    }];
}
- (void)updateDocument:(NSMetadataQuery *)query {
    NSLog(@"数据更新");
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
