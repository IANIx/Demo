//
//  XM_HTTPRequest.m
//  Demo
//
//  Created by 薛佳妮 on 2017/9/6.
//  Copyright © 2017年 李勇杰. All rights reserved.
//

#import "XM_HTTPRequest.h"

@implementation XM_HTTPRequest
+ (instancetype)sharedManager {
    static XM_HTTPRequest *manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        manager = [[self alloc] initWithBaseURL:[NSURL URLWithString:@"http://httpbin.org/"]];
    });
    return manager;
}

-(instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        // 请求超时设定
        self.requestSerializer.timeoutInterval = 5;
        self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        self.responseSerializer.acceptableContentTypes
        = [NSSet
           setWithObjects:@"text/html",@"text/plain",@"application/json",nil];
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer=[AFJSONRequestSerializer serializer];
        
        self.securityPolicy.allowInvalidCertificates = YES;
    }
    return self;
}
- (void)requestWithMethod:(HTTPMethod)method
                 WithPath:(NSString *)path
               WithParams:(NSDictionary*)params
         WithSuccessBlock:(requestSuccessBlock)success
          WithFailurBlock:(requestFailureBlock)failure
{
    switch (method) {
        case GET:{
            [self GET:path parameters:params progress:nil success:^(NSURLSessionTask *task, NSDictionary * responseObject) {
                NSLog(@"Success: %@", responseObject);
                success(responseObject);
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Error: %@", error);
                failure(error);
            }];
            break;
        }
        case POST:{
            [self POST:path parameters:params progress:nil success:^(NSURLSessionTask *task, NSDictionary * responseObject) {
                NSLog(@"Success: %@", responseObject);
                success(responseObject);
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Error: %@", error);
                failure(error);
            }];
            break;
        }
        default:
            break;
    }
}

@end