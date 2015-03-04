//
//  FTBaseTableViewController.m
//  FuzzTest
//
//  Created by Ravi Vooda on 3/4/15.
//  Copyright (c) 2015 Ravi Vooda. All rights reserved.
//

#import "FTBaseTableViewController.h"
#import "FTObject.h"
#import "FTTextTableViewCell.h"
#import "FTImageTableViewCell.h"
#import "FTWebViewController.h"

@interface FTBaseTableViewController ()

@end

@implementation FTBaseTableViewController

-(void) reloadWithData:(NSArray *)objects {
    _itemsHolder = objects;
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat tabBarHeight = self.tabBarController.tabBar.frame.size.height;
    self.tableView.contentInset =
    self.tableView.scrollIndicatorInsets =
    UIEdgeInsetsMake(statusBarHeight + navigationBarHeight, 0, tabBarHeight, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    FTObject *currObject = [_itemsHolder objectAtIndex:indexPath.row];
    switch (currObject.type) {
        case DATA_TYPE_TEXT:{
            NSString * tweetTextString = [currObject data];
            NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
            paragraphStyle.alignment = NSTextAlignmentLeft;
            
            NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                                  [UIFont systemFontOfSize:[UIFont systemFontSize]], NSFontAttributeName,
                                                  paragraphStyle, NSParagraphStyleAttributeName,
                                                  nil];
            
            CGRect textSize =[tweetTextString boundingRectWithSize:CGSizeMake(self.view.frame.size.width, CGFLOAT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine) attributes:attributesDictionary context:nil];
            
            return MAX(textSize.size.height, 44) + 20;
        }
            break;
        case DATA_TYPE_IMAGE: {
            return 100;
        }
            break;
            
        default:
            return 49;
            break;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _itemsHolder.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FTObject *currObject = [_itemsHolder objectAtIndex:indexPath.row];
    static NSString *textCellIdentifier = @"textCellIdentifier";
    static NSString *imageCellIdentifier = @"imageCellIdentifier";
    static NSString *unknownCellIdentifier = @"unknownCellIdentifier";
    NSString *cellIdentifier = @"";
    switch (currObject.type) {
        case DATA_TYPE_TEXT:
            cellIdentifier = textCellIdentifier;
            break;
        case DATA_TYPE_IMAGE:
            cellIdentifier = imageCellIdentifier;
            break;
        default:
            cellIdentifier = unknownCellIdentifier;
            break;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    switch (currObject.type) {
        case DATA_TYPE_TEXT: {
            FTTextTableViewCell *textCell = (FTTextTableViewCell*)cell;
            [textCell setItem:currObject];
        }
            break;
        case DATA_TYPE_IMAGE: {
            FTImageTableViewCell *imageCell = (FTImageTableViewCell*)cell;
            [imageCell setItem:currObject];
        }
            break;
        default:
            break;
    }
    
    // Configure the cell...
    
    return cell;
}

#pragma mark - Table view delegate source 
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *web_url = @"http://www.fuzzproductions.com/";
    UINavigationController *navController = [self.storyboard instantiateViewControllerWithIdentifier:@"webViewNavigation"];
    FTWebViewController *webController = (FTWebViewController*)[navController topViewController];
    webController.url = web_url;
    
    [self presentViewController:navController animated:YES completion:nil];
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
