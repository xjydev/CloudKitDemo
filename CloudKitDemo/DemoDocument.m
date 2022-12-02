//
//  DemoDocument.m
//  CloudKitDemo
//
//  Created by XiaoDev on 2022/11/23.
//

#import "DemoDocument.h"

@implementation DemoDocument
- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError *__autoreleasing  _Nullable *)outError {
    self.data = [contents copy];
    return YES;
}
- (id)contentsForType:(NSString *)typeName error:(NSError *__autoreleasing  _Nullable *)outError {
    return self.data;
}
@end
