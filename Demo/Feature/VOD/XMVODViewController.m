//
//  XMVODViewController.m
//  Demo
//
//  Created by 薛佳妮 on 2017/8/3.
//  Copyright © 2017年 李勇杰. All rights reserved.
//

#import "XMVODViewController.h"
#import "XMVODTableViewCell.h"

@interface XMVODViewController () <UITableViewDelegate,UITableViewDataSource,XMVODCellActionDelegate>

@property (nonatomic, strong) UITableView *tableView;
@end

@implementation XMVODViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       self.view.backgroundColor = XM_COMMON_BG_COLOR;
    [self getchanelSchedulesList];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    // Do any additional setup after loading the view.
}

- (void)getlist {
    
    [[XM_HTTPRequest manager] requestWithMethod:POST
                                       WithPath:XM_CATEGORY_URL
                                     WithParams:@{@"mac":[self getMacAddress],
                                                  @"mediaType":@"vod",
                                                  @"categoryId":@"0"}
                               WithSuccessBlock:^(NSDictionary *dic) {
                                   NSLog(@"success --> %@",dic);
                               } WithFailurBlock:^(NSError *error) {
                                   NSLog(@"failed -->error == %@",error.description);
                               }];
}
- (void)getliveList {
    [[XM_HTTPRequest manager] requestWithMethod:POST
                                       WithPath:XM_CONTENTLIST_URL
                                     WithParams:@{@"mac":[self getMacAddress],
                                                  @"mediaType":@"live",
                                                  @"categoryId":@"3",
                                                  @"pageSize":[NSNumber numberWithInt:10],
                                                  @"page":[NSNumber numberWithInt:1]}
                               WithSuccessBlock:^(NSDictionary *dic) {
                                   NSLog(@"success --> %@",dic);
                               } WithFailurBlock:^(NSError *error) {
                                   NSLog(@"failed -->error == %@",error.description);
                               }];
}
- (void)getchanelList {
    
    [[XM_HTTPRequest manager] requestWithMethod:POST
                                       WithPath:XM_CHANELLIST_URL
                                     WithParams:@{@"mac":[self getMacAddress],
                                                  @"pageSize":[NSNumber numberWithInt:10],
                                                  @"page":[NSNumber numberWithInt:1]}
                               WithSuccessBlock:^(NSDictionary *dic) {
                                   NSLog(@"success --> %@",dic);
                               } WithFailurBlock:^(NSError *error) {
                                   NSLog(@"failed -->error == %@",error.description);
                               }];
}
- (void)getchanelSchedulesList {
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
- (void)createRequest {
    [[XM_HTTPRequest manager] requestWithMethod:POST
                                       WithPath:XM_SPECIALLIST_URL
                                     WithParams:@{@"mac":[self getMacAddress]}
                               WithSuccessBlock:^(NSDictionary *dic) {
                                   if (dic[@"resultCode"] == 0) {
                                       NSArray *array = dic[@"specials"];
                                   }
                               } WithFailurBlock:^(NSError *error) {
    
                               }];
}

-(void)creatRequsst{
   
}
#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMVODTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[XMVODTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.delegate = self;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 370;
}
#pragma mark - cell
- (void)XMVODCell:(XMVODTableViewCell *)cell MorebtnDidClicked:(UIButton *)button {
    UIViewController *viewController = [XMRouter matchController:@"vod/more"];
    [self.navigationController pushViewController:viewController animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
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
