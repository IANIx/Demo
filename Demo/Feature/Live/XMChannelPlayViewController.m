//
//  ChannelPlayViewController.m
//  Demo
//
//  Created by 李勇杰 on 2017/9/7.
//  Copyright © 2017年 李勇杰. All rights reserved.
//

#import "XMChannelPlayViewController.h"

@interface XMChannelPlayViewController ()

@end

@implementation XMChannelPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatRequestPlay];
    [self requestschedules];
    self.view.backgroundColor = zkHexColor(0x181c28);
    
    // Do any additional setup after loading the view.
}

-(void)requestschedules{
        [[XM_HTTPRequest manager] requestWithMethod:POST
                                           WithPath:XM_CHANNELSCEDULES_URL
                                         WithParams:@{@"mac":[self getMacAddress],
                                                      @"scheduleType":@"0",
                                                      @"channelId" :self.model.channelId,
                                                      @"pageSize":[NSNumber numberWithInt:10],
                                                      @"page":[NSNumber numberWithInt:1]}
                                   WithSuccessBlock:^(NSDictionary *dic) {
                                   } WithFailurBlock:^(NSError *error) {
                                   }];
    }
-(void)creatRequestPlay{
    
    [[XM_HTTPRequest manager] requestWithMethod:POST
                                       WithPath:XM_Play_URL
                                     WithParams:@{@"mac":@"FC:D5:D9:02:F6:1A",
                                                  @"contentId":@"1ba443a0-9c53-4f18-8ede-eb91668c567f",
                                                  @"mediaType":@"vod",
                                                  @"quality":@"auto"
                                                  }
     
                               WithSuccessBlock:^(NSDictionary *dic) {
                               } WithFailurBlock:^(NSError *error) {
                               }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
