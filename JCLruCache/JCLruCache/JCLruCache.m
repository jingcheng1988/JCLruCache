//
//  JCLruCache.m
//  JCLruCache
//
//  Created by zhangjc on 2023/10/20.
//

#import "JCLruCache.h"
#import "JCLruCacheNode.h"

const NSInteger kLRUCacheDefaultMaxCount = 256;

@interface JCLruCache (){
    //辅助节点
    JCLruCacheNode *_p;
}

//缓存map信息
@property (nonatomic, strong) NSMutableDictionary<NSString*, JCLruCacheNode*> *map;

@end


@implementation JCLruCache

- (instancetype)init {
    return [self initWithMaxCount:kLRUCacheDefaultMaxCount];
}

- (instancetype)initWithMaxCount:(NSInteger)maxCount {
    if (self = [super init]) {
        _p = [[JCLruCacheNode alloc] init];
        _map = [NSMutableDictionary dictionary];
        _maxCount = maxCount > 0 ? maxCount : kLRUCacheDefaultMaxCount;
    }
    return self;
}

- (void)setObject:(id)value forKey:(NSString *)key {
    if (!value || !key || ![key isKindOfClass:[NSString class]] || !key.length) {
        return;
    }
    
    //添加node
    JCLruCacheNode *node = [_map objectForKey:key];
    if (!node) {
        node = [[JCLruCacheNode alloc] initWithKey:key Value:value];
        [_map setObject:node forKey:key];
        //创建新节点，插入到头部
        [self insertNode:node];
    } else {
        //更新已有节点，移动到头部
        node.value = value;
        [self updateNode:node];
    }
    
    // 数量超限，移除不常用内容
    if (_maxCount > 0 && _map.count > _maxCount) {
        [self updateLimitCount:_maxCount];
    }
    
}

- (void)removeObjectForKey:(NSString *)key {
    if (!key || ![key isKindOfClass:[NSString class]] || !key.length) {
        return;
    }
    
    //移除node
    JCLruCacheNode *node = [_map objectForKey:key];
    if (node) {
        //更新前后节点
        JCLruCacheNode *prev = node.prev;
        JCLruCacheNode *next = node.next;
        if (prev) {
            prev.next = next;
        }
        if (next) {
            next.prev = prev;
        }
        
        //置空前后节点
        node.prev = nil;
        node.next = nil;
        
        //移除节点
        [_map removeObjectForKey:key];
    }
}

- (id)objectForKey:(NSString *)key {
    if (!key || ![key isKindOfClass:[NSString class]] || !key.length) {
        return nil;
    }
    
    //获取node
    JCLruCacheNode *node = [_map objectForKey:key];
    if (!node) {
        return nil;
    }
    
    // 移动到头部
    [self updateNode:node];
    
    return node.value;
}

- (void)updateLimitCount:(NSInteger)limitCount {
    //获取有效的lastNode
    JCLruCacheNode *node = _p;
    for (int i = 0; i < limitCount; i++) {
        node = node.next;
    }
    
    //获取invalidNode
    JCLruCacheNode *tmpNode = node.next;
    while (tmpNode) {
        [_map removeObjectForKey:tmpNode.key];
        tmpNode = tmpNode.next;
    }

    //最后一个node的next置空
    node.next = nil;
}

- (void)removeAllObjects {
    _p.next = nil;
    [_map removeAllObjects];
}

- (NSArray *)allKeys {
    return _map.allKeys;
}

- (NSUInteger)count {
    return _map.count;
}


#pragma mark - Node Operation

//创建新节点
- (void)insertNode:(JCLruCacheNode *)node {
    JCLruCacheNode *head = _p.next;
    
    //更新当前节点前后节点
    node.next = head;
    node.prev = _p;
        
    //原head节点后移
    if (head) {
        head.prev = node;
    };
    
    //更新工具节点
    _p.next = node;
}

//更新已存在的节点
- (void)updateNode:(JCLruCacheNode *)node {
    JCLruCacheNode *head = _p.next;
    // 已是头节点，直接return
    if (node == head) {
        return;
    }
    
    //获取节点前后节点
    JCLruCacheNode *prev = node.prev;
    JCLruCacheNode *next = node.next;
    if (prev) {
        prev.next = next;
    }
    if (next) {
        next.prev = prev;
    }
    
    //更新head节点
    node.prev = _p;
    node.next = head;
    head.prev = node;
    
    //更新工具节点
    _p.next = node;
}



@end
