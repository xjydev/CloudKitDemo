//
//  MainTableViewController.m
//  CloudKitDemo
//
//  Created by XiaoDev on 2022/11/8.
//

#import "MainTableViewController.h"

@interface ActivityIndView : UIView

@end
@implementation ActivityIndView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        CFTimeInterval duration = 1;
        CFTimeInterval beginTime = CACurrentMediaTime();
        NSArray *beginTimes = @[@(0.4),@(0.2),@(0.0),@(0.2),@(0.4)];
        CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.85 :0.25 :0.37 :0.85];
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.y"];
        animation.keyTimes = @[@(0.0),@(0.5),@(1)];
        animation.timingFunctions = @[timingFunction,timingFunction];
        animation.values =@[@(1),@(0.4),@(1)];
        animation.duration = duration;
        animation.repeatCount = HUGE;
        animation.removedOnCompletion = NO;
        CGFloat width = frame.size.width/9;
        for (NSInteger i = 0;i<5;i++) {
            CAShapeLayer *line = [CAShapeLayer layer];
            CGRect rect = CGRectMake((width*2)*i, 0,width, frame.size.height);
            UIBezierPath *path =[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, width, frame.size.height) cornerRadius:width/2.0];
//            [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 10, 60)];
            line.path = path.CGPath;
            line.lineJoin = kCALineJoinRound;
            line.lineCap = kCALineCapRound;
            line.fillColor = [UIColor redColor].CGColor;
            line.frame = rect;
            animation.beginTime = beginTime+[beginTimes[i] doubleValue];
            [line addAnimation:animation forKey:@"animation"];
            [self.layer addSublayer:line];
            
        }
        
    }
    return self;
}

@end

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
    headerView.backgroundColor = [UIColor yellowColor];
    self.tableView.tableHeaderView = headerView;
    
    
//    UIView *cView = [[UIView alloc]initWithFrame:CGRectMake(50, 50, 54, 14)];
//    cView.backgroundColor = [UIColor greenColor];
//    CGAffineTransform transform = CGAffineTransformIdentity;
//    transform.c = -0.2;
//    transform.b = 0;
//    CALayer *layer = [CALayer layer];
//    layer.frame = CGRectMake(3, 0, cView.frame.size.width - 6, cView.frame.size.height);
//    layer.cornerRadius = 3;
//    layer.backgroundColor = [UIColor redColor].CGColor;
//    layer.affineTransform = transform;
//    cView.layer.mask = layer;
//    [headerView addSubview:cView];
    
    ActivityIndView *aview = [[ActivityIndView alloc]initWithFrame:CGRectMake(50, 50, 50, 50)];
    aview.backgroundColor =[UIColor grayColor];
    [headerView addSubview:aview];
    
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
-(BOOL)prefersStatusBarHidden {
    return NO;
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
