//
//  ChannelPlayViewController.m
//  Demo
//
//  Created by 李勇杰 on 2017/9/7.
//  Copyright © 2017年 李勇杰. All rights reserved.
//

#import "XMChannelPlayViewController.h"
#import "XM_PlayView.h"
@interface XMChannelPlayViewController ()<NV_AVPlayerDelegate>

@property (nonatomic, strong) XM_PlayView *renderView;
@end

@implementation XMChannelPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = zkHexColor(0x181c28);
    
    [self.view addSubview:self.renderView];
    self.renderView.playURL = self.model.playUrl;
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)renderView {
    if (!_renderView) {
        _renderView = [[XM_PlayView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 150)];
    }
    return _renderView;
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
