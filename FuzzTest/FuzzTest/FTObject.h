//
//  FTObject.h
//  FuzzTest
//
//  Created by Ravi Vooda on 3/4/15.
//  Copyright (c) 2015 Ravi Vooda. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    DATA_TYPE_TEXT,
    DATA_TYPE_IMAGE,
    DATA_TYPE_UNKNOWN
} DATA_TYPE;

@interface FTObject : NSObject

@property (strong, nonatomic) NSString *objectID;
@property (nonatomic) DATA_TYPE type;
@property (strong, nonatomic) NSString *data;

-(instancetype) initWithDictionary:(NSDictionary*)dictionary;

@end
