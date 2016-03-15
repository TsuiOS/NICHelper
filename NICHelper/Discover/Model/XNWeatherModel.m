//
//  XNWeatherModel.m
//  NICHelper
//
//  Created by mac on 16/3/13.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNWeatherModel.h"
#import "NetworkTools.h"


@implementation XNFuture


- (instancetype)initWithDict:(NSDictionary *)dict {
    if ([dict isKindOfClass:[NSDictionary class]]) {
        
        if ([super init]) {
            [self setValuesForKeysWithDictionary:dict];
        }
        return self;
    } else {
        return nil;
    }

}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end

#pragma mark --------------------------XNResult---------------------------------


@implementation XNResult

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if ([dict isKindOfClass:[NSDictionary class]]) {
        
        if ([super init]) {
            [self setValuesForKeysWithDictionary:dict];
        }
        return self;
    } else {
        return nil;
    }
}


- (void)setValue:(id)value forKey:(NSString *)key {
    
    if ([value isKindOfClass:[NSNull class]]) {
        return;
    }
    if ([key isEqualToString:@"future"] && [value isKindOfClass:[NSArray class]]) {
        
        NSArray *temp = value;
        NSMutableArray *futureList = [NSMutableArray arrayWithCapacity:temp.count];
        for (NSDictionary *dict in temp) {
            
            XNFuture *future = [[XNFuture alloc]initWithDict:dict];
            [futureList addObject:future];

        }
        value = futureList;
    }
    [super setValue:value forKey:key];


}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}


@end


#pragma mark -----------------------XNWeatherModel------------------------------

@implementation XNWeatherModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if ([dict isKindOfClass:[NSDictionary class]]) {
        
        if ([super init]) {
            [self setValuesForKeysWithDictionary:dict];
        }
        return self;
    } else {
        return nil;
    }
    
}


- (void)setValue:(id)value forKey:(NSString *)key {
    
    if ([value isKindOfClass:[NSNull class]]) {
        return;
    }
    
    if ([key isEqualToString:@"result"] && [value isKindOfClass:[NSArray class]] ) {
        NSArray *temp = value;
        
        NSMutableArray *weatherList = [NSMutableArray arrayWithCapacity:temp.count];
       
        for (NSDictionary *dict in temp) {
            
            XNResult *result = [[XNResult alloc] initWithDict:dict];
            [weatherList addObject:result];
        }
        value = weatherList;
    }
    // 必须先处理完自己的, 然后在调用父类的
    [super setValue:value forKey:key];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

}



@end
