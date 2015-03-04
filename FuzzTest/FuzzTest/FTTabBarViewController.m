//
//  FTTabBarViewController.m
//  FuzzTest
//
//  Created by Ravi Vooda on 3/4/15.
//  Copyright (c) 2015 Ravi Vooda. All rights reserved.
//

#import "FTTabBarViewController.h"
#import "FTObject.h"

@interface FTTabBarViewController ()

@end

@implementation FTTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *urlAsString = [NSString stringWithFormat:@"http://dev.fuzzproductions.com/MobileTest/test.json"];
        NSURL *url = [[NSURL alloc] initWithString:urlAsString];
        NSLog(@"%@", urlAsString);
        
        [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            if (error) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"FUZZ TEST" message:@"An error occurred in fetching the messages" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                [alert show];
            } else {
                NSError *jsonError = nil;
                NSArray *responseObjects = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                if (jsonError) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"FUZZ TEST" message:@"An error occurred in parsing the JSON" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                    [alert show];
                } else {
                    NSMutableArray *arr = [[NSMutableArray alloc] init];
                    for (NSDictionary *dict in responseObjects) {
                        [arr addObject:[[FTObject alloc] initWithDictionary:dict]];
                    }
                    _allObjects = [[NSArray alloc] initWithArray:arr];
                    
                    for (UIViewController *childController in self.childViewControllers) {
                        if ([childController conformsToProtocol:@protocol(dataSetChangedListner)]) {
                            [(id<dataSetChangedListner>)childController reloadWithData:_allObjects];
                        }
                    }
                }
            }
        }];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
