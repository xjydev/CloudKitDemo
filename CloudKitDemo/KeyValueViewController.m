//
//  KeyValueViewController.m
//  CloudKitDemo
//
//  Created by XiaoDev on 2022/11/18.
//

#import "KeyValueViewController.h"

@interface KeyValueViewController ()
@property (weak, nonatomic) IBOutlet UITextField *keyTextField;
@property (weak, nonatomic) IBOutlet UITextField *valueTextField;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@end

@implementation KeyValueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyValuesDidChange:) name:NSUbiquitousKeyValueStoreDidChangeExternallyNotification object:[NSUbiquitousKeyValueStore defaultStore]];

}
- (IBAction)saveButtonAction:(UIButton *)sender {
    if (self.keyTextField.text.length == 0 || self.valueTextField.text.length == 0) {
        return;
    }
    NSUbiquitousKeyValueStore *keyValueStore = [NSUbiquitousKeyValueStore defaultStore];
    [keyValueStore setObject:self.valueTextField.text    forKey:self.keyTextField.text];
    [keyValueStore synchronize];
    
}
- (IBAction)readButtonAction:(id)sender {
    
    if (self.keyTextField.text.length == 0) {
        return;
    }
    NSUbiquitousKeyValueStore *keyValueStore = [NSUbiquitousKeyValueStore defaultStore];
    NSString *value = [keyValueStore objectForKey:self.keyTextField.text];
    if(value > 0) {
        self.contentTextView.text = value;
    }
    else {
        self.contentTextView.text = @"未查询到结果";
    }
}
- (void)keyValuesDidChange:(NSUbiquitousKeyValueStore *)store {
    NSLog(@"keyvalue ==== %@",store);
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
