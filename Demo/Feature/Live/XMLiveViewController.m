//
//  XMLiveViewController.m
//  Demo
//
//  Created by 薛佳妮 on 2017/8/3.
//  Copyright © 2017年 李勇杰. All rights reserved.
//

#import "XMLiveViewController.h"
#import "XMLiveTableViewCell.h"
@interface XMLiveViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView   *tableView;
@property (nonatomic, strong) NSMutableArray<XM_ChannelModel *> *dataSource;

@end

@implementation XMLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = @[].mutableCopy;
    [self requestchannellist];
//    [self.tableView.mj_header beginRefreshing];
    [self.view addSubview:self.tableView];
    [self.tableView setSeparatorColor:[UIColor darkGrayColor]];

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];

    // Do any additional setup after loading the view.
}
#pragma mark - request
-(void)requestchannellist{
    [[XM_HTTPRequest manager] requestWithMethod:POST
                                       WithPath:XM_CHANELLIST_URL
                                     WithParams:@{@"mac":[self getMacAddress],
                                                  @"pageSize":[NSNumber numberWithInt:10],
                                                  @"page":[NSNumber numberWithInt:1]}
                               WithSuccessBlock:^(NSDictionary *dic) {
                                   XM_ChannelListModel *model = [XM_ChannelListModel yy_modelWithDictionary:dic];
                                   if (model.resultCode == 0) {
                                       [self.dataSource addObjectsFromArray:model.channels];
//                                       dispatch_sync(dispatch_get_main_queue(), ^{
//                                           //Update UI in UI thread here
//                                          
//                                           
//                                       });
                                       [self.tableView.mj_header endRefreshing];
                                       [self.tableView reloadData];
                                   }
                               } WithFailurBlock:^(NSError *error) {
                               }];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.000001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMLiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[XMLiveTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    [cell updateWithModel:self.dataSource[indexPath.row]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *viewController = [XMRouter matchController:@"live/play" withDic:@{@"model":self.dataSource[indexPath.row]}];
    [self.navigationController pushViewController:viewController animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (16+108+16)/2;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
//        _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            // 进入刷新状态后会自动调用这个block
//        }];
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
