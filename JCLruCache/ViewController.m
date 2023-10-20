//
//  ViewController.m
//  JCLruCache
//
//  Created by zhangjc on 2023/10/20.
//

#import "ViewController.h"
#import "JCLruCache.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //使用LRU算法作为缓存策略，保证内存的使用率
    
    JCLruCache *cache = [[JCLruCache alloc] init];
    
    [cache setObject:@"11111" forKey:@"value"];
    
    [cache objectForKey:@"value"];

    [cache removeObjectForKey:@"value"];
    
    [cache removeAllObjects];
    
}


@end
