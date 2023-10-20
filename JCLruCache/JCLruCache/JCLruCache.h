//
//  JCLruCache.h
//  JCLruCache
//
//  Created by zhangjc on 2023/10/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JCLruCache : NSObject

//最大容量，默认100
@property (nonatomic, readonly) NSInteger maxCount;
//当前缓存的数量
@property (nonatomic, readonly) NSUInteger count;

//初始化方法
- (instancetype)initWithMaxCount:(NSInteger)maxCount;

//添加缓存数据
- (void)setObject:(id)value forKey:(NSString *)key;

//移除缓存数据
- (void)removeObjectForKey:(NSString *)key;

//获取缓存数据
- (id)objectForKey:(NSString *)key;

//移除所有数据
- (void)removeAllObjects;

//获取所有的key
- (NSArray *)allKeys;

@end

NS_ASSUME_NONNULL_END
