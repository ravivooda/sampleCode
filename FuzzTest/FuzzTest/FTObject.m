//
//  FTObject.m
//  FuzzTest
//
//  Created by Ravi Vooda on 3/4/15.
//  Copyright (c) 2015 Ravi Vooda. All rights reserved.
//

#import "FTObject.h"

@implementation FTObject

-(instancetype) initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.objectID = [dictionary objectForKey:@"id"];
        NSString *type = [dictionary objectForKey:@"type"];
        if ([type isEqualToString:@"text"]) {
            self.type = DATA_TYPE_TEXT;
        } else if ([type isEqualToString:@"image"]) {
            self.type = DATA_TYPE_IMAGE;
        } else {
            self.type = DATA_TYPE_UNKNOWN;
        }
        self.data = [dictionary objectForKey:@"data"];
    }
    return self;
}

@end
