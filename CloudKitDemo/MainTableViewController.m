//
//  MainTableViewController.m
//  CloudKitDemo
//
//  Created by XiaoDev on 2022/11/8.
//

#import "MainTableViewController.h"

@interface MainTableViewController ()
@property (nonatomic, strong)NSArray *array;
@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = @[@{@"title":@"key-value",@"target":@"KeyValueViewController"},
                   @{@"title":@"Document",@"target":@"DocumentViewController"},
                   @{@"title":@"Cloudkit",@"target":@"CloudKitViewController"},];
    
    
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    headerView.backgroundColor = [UIColor redColor];
    self.tableView.tableHeaderView = headerView;
    
    
    UIView *cView = [[UIView alloc]initWithFrame:CGRectMake(50, 50, 54, 14)];
    cView.backgroundColor = [UIColor greenColor];
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform.c = -0.2;
    transform.b = 0;
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(3, 0, cView.frame.size.width - 6, cView.frame.size.height);
    layer.cornerRadius = 3;
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.affineTransform = transform;
    cView.layer.mask = layer;
    [headerView addSubview:cView];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid" forIndexPath:indexPath];
    
    NSDictionary *dict = self.array[indexPath.row];
    cell.textLabel.text = [dict objectForKey:@"title"];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = self.array[indexPath.row];
    [self performSegueWithIdentifier:dict[@"target"] sender:[dict objectForKey:@"title"]];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *VC = segue.destinationViewController;
    VC.title = sender;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


@end
