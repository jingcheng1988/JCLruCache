//
//  JCLruCacheNode.h
//  JCLruCache
//
//  Created by zhangjc on 2023/10/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JCLruCacheNode : NSObject

@property (nonatomic, strong) id value;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, weak, nullable) JCLruCacheNode *prev;
@property (nonatomic, strong, nullable) JCLruCacheNode *next;

- (instancetype)initWithKey:(NSString *)key Value:(id)value;

@end

NS_ASSUME_NONNULL_END
