//
//  JCLruCacheNode.m
//  JCLruCache
//
//  Created by zhangjc on 2023/10/20.
//

#import "JCLruCacheNode.h"

@implementation JCLruCacheNode

- (instancetype)initWithKey:(NSString *)key Value:(id)value{
    if (self = [super init]) {
        _key = key;
        _value = value;
    }
    return self;
}

@end
