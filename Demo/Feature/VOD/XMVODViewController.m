//
//  XMVODViewController.m
//  Demo
//
//  Created by 薛佳妮 on 2017/8/3.
//  Copyright © 2017年 李勇杰. All rights reserved.
//

#import "XMVODViewController.h"
#import "XMVODTableViewCell.h"
#import "XMBannerView.h"
#import "XMTitleMenuView.h"
#import "PlayhistoryViewController.h"


@interface XMVODViewController () <UITableViewDelegate,UITableViewDataSource,XMVODCellActionDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) XMTitleMenuView *titleView;
@property (nonatomic, strong) XMBannerView *bannerView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *contentCategoryArray;
@end

@implementation XMVODViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"英文-1"]];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"历史记录"] style:UIBarButtonItemStylePlain target:self action:@selector(onClickedOKbtn)];
    
    self.navigationItem.rightBarButtonItem = rightBarItem;
   self.view.backgroundColor = XM_COMMON_BG_COLOR;
    self.contentCategoryArray = @[].mutableCopy;
//    [self.tableView.mj_header beginRefreshing];
    [self getTitleRequest];
    [self setupSubViews];
    [self.tableView setSeparatorColor:[UIColor darkGrayColor]];
    // Do any additional setup after loading the view.
}

-(void)onClickedOKbtn{
    PlayhistoryViewController *Playhistory = [[PlayhistoryViewController alloc]init];
    Playhistory.title = @"播放历史";
    [self.navigationController pushViewController:Playhistory animated:YES];

}
- (void)setupSubViews {
    self.bannerView = [[XMBannerView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 175) andMenu:self.menu];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.mas_equalTo(40);
    }];
    [self.view addSubview:self.titleView];
}
#pragma mark - request
- (void)getcontentCategoryWithcategoryId:(NSString *)categoryId andIdx:(NSInteger)idx{
    [[XM_HTTPRequest manager] requestWithMethod:POST
                                       WithPath:XM_CONTENTLIST_URL
                                     WithParams:@{@"mac":[self getMacAddress],
                                                  @"mediaType":@"vod",
                                                  @"categoryId":categoryId,
                                                  @"pageSize":@4,
                                                  @"page":@1}
                               WithSuccessBlock:^(NSDictionary *dic) {
                                   XM_ContentListModel *model = [XM_ContentListModel yy_modelWithDictionary:dic];
                                   if (model.resultCode == 0) {
                                       [self.contentCategoryArray addObject:model];
                                       if (self.contentCategoryArray.count == self.dataSource.count) {
                                           
                                           [self.tableView.mj_header endRefreshing];
                                           [self.tableView reloadData];
                                       }
                                   }
                               } WithFailurBlock:^(NSError *error) {
                               }];
}
- (void)getTitleRequest {
    [[XM_HTTPRequest manager] requestWithMethod:POST
                                       WithPath:XM_MENULIST_URL
                                     WithParams:@{@"mac":[self getMacAddress],
                                                  @"menuId":self.menu.menuId,
                                                  @"menuId":@"CN_zh"}
                               WithSuccessBlock:^(NSDictionary *dic) {
                                   XM_MenuListModel *model = [XM_MenuListModel yy_modelWithDictionary:dic];
                                   if (model.resultCode == 0) {
                                       self.titleView.menuList = model.menus;
                                       if (model.menus.count > 0) {
                                           [self getContentTitleWithMenuId:model.menus[0].menuId];
                                           [self getbannerWithMenuId:model.menus[0].menuId];
                                       }
                                   }
                               } WithFailurBlock:^(NSError *error) {
                               }];
}
- (void)getContentTitleWithMenuId:(NSString *)menuId {
    [[XM_HTTPRequest manager] requestWithMethod:POST
                                       WithPath:XM_MENULIST_URL
                                     WithParams:@{@"mac":[self getMacAddress],
                                                  @"menuId":menuId,
                                                  @"menuId":@"CN_zh"}
                               WithSuccessBlock:^(NSDictionary *dic) {
                                   XM_MenuListModel *model = [XM_MenuListModel yy_modelWithDictionary:dic];
                                   if (model.resultCode == 0) {
                                       self.dataSource = [[NSMutableArray alloc]initWithArray:model.menus];
                                       [self.dataSource enumerateObjectsUsingBlock:^(XM_MenuModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                           [self getcontentCategoryWithcategoryId:obj.categoryId andIdx:idx];
                                       }];
                                   }
                               } WithFailurBlock:^(NSError *error) {
                               }];
}
- (void)getbannerWithMenuId:(NSString *)menuId {
    [[XM_HTTPRequest manager] requestWithMethod:POST
                                       WithPath:XM_MENURECOMMEND_URL
                                     WithParams:@{@"mac":[self getMacAddress],
                                                  @"menuId":menuId}
                               WithSuccessBlock:^(NSDictionary *dic) {
                                   XM_MenuRecommendModel *model = [XM_MenuRecommendModel yy_modelWithDictionary:dic];
                                   if (model.resultCode == 0) {
                                       NSArray<XM_rContentModel *> *bannerArray = model.menus[0].recommend[0].rContent;
                                       [self.bannerView updateBannerImageWithArray:bannerArray];
                                   }
                               } WithFailurBlock:^(NSError *error) {
                               }];
}
#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 175.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.bannerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMVODTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[XMVODTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.delegate = self;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        

    }
    [cell updateTitle:((XM_MenuModel *)self.dataSource[indexPath.row]).menuName content:self.contentCategoryArray[indexPath.row]];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 480;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *viewController = [XMRouter matchController:@"vod/more" withDic:@{@"menu":self.dataSource[indexPath.row]}];
    [self.navigationController pushViewController:viewController animated:YES];
}
#pragma mark - cell
- (void)XMVODCell:(XMVODTableViewCell *)cell MorebtnDidClicked:(UIButton *)button {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    UIViewController *viewController = [XMRouter matchController:@"vod/more" withDic:@{@"menu":self.dataSource[indexPath.row]}];
    [self.navigationController pushViewController:viewController animated:YES];
}
- (void)XMVODCell:(XMVODTableViewCell *)cell collectionDidClicked:(XM_ContentModel *)contentModel {
    UIViewController *viewController = [XMRouter matchController:@"vod/detail" withDic:@{@"content":contentModel}];
    [self.navigationController pushViewController:viewController animated:YES];
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
- (XMTitleMenuView *)titleView {
    if (!_titleView) {
        _titleView = [[XMTitleMenuView alloc]initWithFrame:CGRectMake(5, 0, MainScreenWidth-10, 40)];
        _titleView.backgroundColor = XM_COMMON_BG_COLOR;
    }
    return _titleView;
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
