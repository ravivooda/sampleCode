//
//  FTImageView.m
//  FuzzTest
//
//  Created by Ravi Vooda on 3/4/15.
//  Copyright (c) 2015 Ravi Vooda. All rights reserved.
//

#import "FTImageView.h"

@interface FTImageView ()

@property (strong, nonatomic) UIActivityIndicatorView *loadingIndicator;
@property (strong, nonatomic) UIImage *errorImage;

@end

@implementation FTImageView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(void) awakeFromNib {
    [super awakeFromNib];
    [self setContentMode:UIViewContentModeScaleAspectFit];
    
    _loadingIndicator = [[UIActivityIndicatorView alloc] initWithFrame:self.frame];
    [_loadingIndicator setColor:[UIColor colorWithWhite:0.5f alpha:1.0f]];
    [self addSubview:_loadingIndicator];
    [self bringSubviewToFront:_loadingIndicator];
    _errorImage = [UIImage imageNamed:@"error.png"];
}

-(void) setUrl:(NSString *)url {
    [_loadingIndicator setHidden:NO];
    [_loadingIndicator startAnimating];
    [_loadingIndicator setFrame:self.frame];
//    [self setImage:nil];
    @synchronized(self) {
        _url = url;
        NSString *localURL = url;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSError *error = nil;
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:localURL] options:NSDataReadingMappedAlways error:&error]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                @synchronized(self) {
                    if ([localURL isEqualToString:_url]) {
//                        [_loadingIndicator setHidden:YES];
//                        [_loadingIndicator stopAnimating];
//                        if (error) {
//                            NSLog(@"An error occurred in fetching images");
//                            NSLog(localURL);
//                            [self setImage:_errorImage];
//                        } else {
//                            [self setImage:image];
//                        }
                    }
                }
            });
        });
    }
}

@end
