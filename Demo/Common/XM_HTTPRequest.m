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
        = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        
        
        [self.requestSerializer setValue:@"48:A1:95:B3:B3:A5" forHTTPHeaderField:@"X-mac"];
//        [self.requestSerializer setValue:@"" forHTTPHeaderField:@"X-areaCode"];
//        [self.requestSerializer setValue:@"" forHTTPHeaderField:@"X-version"];
        [self.requestSerializer setValue:@"phone" forHTTPHeaderField:@"X-deviceType"];

        self.responseSerializer = [AFHTTPResponseSerializer serializer];
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
                NSLog(@"Success --> %@", responseObject);
                success(responseObject);
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Error -- > %@", error);
                failure(error);
            }];
            break;
        }
        case POST:{
            [self POST:path parameters:params progress:nil success:^(NSURLSessionTask *task, NSData * responseObject) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"Success --> %@", dic);
                success(dic);
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Error -- > %@", error.description);
                failure(error);
            }];
            break;
        }
        default:
            break;
    }
}

@end
