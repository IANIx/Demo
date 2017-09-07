//
//  ChannelPlayViewController.m
//  Demo
//
//  Created by 李勇杰 on 2017/9/7.
//  Copyright © 2017年 李勇杰. All rights reserved.
//

#import "ChannelPlayViewController.h"

@interface ChannelPlayViewController ()

@end

@implementation ChannelPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestschedules];
    self.view.backgroundColor = zkHexColor(0x181c28);
    
    // Do any additional setup after loading the view.
}

-(void)requestschedules{
        [[XM_HTTPRequest manager] requestWithMethod:POST
                                           WithPath:XM_CHANNELSCEDULES_URL
                                         WithParams:@{@"mac":[self getMacAddress],
                                                      @"scheduleType":@"0",
                                                      @"channelId" :@"237",
                                                      @"pageSize":[NSNumber numberWithInt:10],
                                                      @"page":[NSNumber numberWithInt:1]}
                                   WithSuccessBlock:^(NSDictionary *dic) {
                                       NSLog(@"success --> %@",dic);
                                   } WithFailurBlock:^(NSError *error) {
                                       NSLog(@"failed -->error == %@",error.description);
                                   }];
    }
-(void)creatRequestPlay{
    
    [[XM_HTTPRequest manager] requestWithMethod:POST
                                       WithPath:XM_Play_URL
                                     WithParams:@{@"mac":[self getMacAddress],
                                                  @"contentId":@"0",
                                                  @"mediaType":@"vod",
                                                  @"quality":@"auto"
                                                  }
     
                               WithSuccessBlock:^(NSDictionary *dic) {
                                   NSLog(@"success --> %@",dic);
                               } WithFailurBlock:^(NSError *error) {
                                   NSLog(@"failed -->error == %@",error.description);
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
