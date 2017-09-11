//
//  XMDeatilViewController.m
//  Demo
//
//  Created by 薛佳妮 on 2017/9/4.
//  Copyright © 2017年 李勇杰. All rights reserved.
//

#import "XMDeatilViewController.h"
#import "XMDetail_VideoTableViewCell.h"
#import "XMDetail_CommentTableViewCell.h"
#import "XMDetail_RelatedTableViewCell.h"
#import "XMDetail_BriefIntroductionTableViewCell.h"
#import "XMDetail_AnthologyTableViewCell.h"
@interface XMDeatilViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy  ) NSString *playUrl;
@end

@implementation XMDeatilViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Detail";
    [self getcontentDetail];
    [self.tableView setSeparatorColor:[UIColor clearColor]];

    [self setupSubViews];
    // Do any additional setup after loading the view.
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NV_AVPlayer sharedInstance] stop];
    NV_AVPlayer *player =  [NV_AVPlayer sharedInstance];
    [player stop];
    player = nil;
}
- (void)setupSubViews {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
}
- (void)getcontentDetail {
    [[XM_HTTPRequest manager] requestWithMethod:POST
                                       WithPath:XM_CONTENTDETAIL_URL
                                     WithParams:@{@"mac":[self getMacAddress],
                                                  @"contentId":self.content.contentId,
                                                  }
     
                               WithSuccessBlock:^(NSDictionary *dic) {
                                   NSString *contentID = dic[@"contentInfo"][@"contentId"];
                                   [self creatRequestPlay:contentID];
                               } WithFailurBlock:^(NSError *error) {
                                   NSLog(@"failed -->error == %@",error.description);
                               }];

}
-(void)creatRequestPlay:(NSString *)contentId {
    
    [[XM_HTTPRequest manager] requestWithMethod:POST
                                       WithPath:XM_Play_URL
                                     WithParams:@{@"mac":@"48:A1:95:B3:B3:A5",
                                                  @"contentId":contentId,
                                                  @"mediaType":@"vod",
                                                  @"quality":@"auto"
                                                  }
     
                               WithSuccessBlock:^(NSDictionary *dic) {
                                   XM_PlayauthModel *model = [XM_PlayauthModel yy_modelWithJSON:dic];
                                   if (model.resultCode == 0) {
                                       self.playUrl = model.playUrl;
                                       [self.tableView reloadData];
                                   }
                               } WithFailurBlock:^(NSError *error) {
                                   NSLog(@"failed -->error == %@",error.description);
                               }];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.000001;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 150;
    }
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            XMDetail_VideoTableViewCell *cell = [[XMDetail_VideoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
            
            if (self.playUrl) {
                cell.playView.playURL = self.playUrl;
            }
            return cell;
        } else if (indexPath.row == 1) {
            XMDetail_CommentTableViewCell *cell = [[XMDetail_CommentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
            return cell;
        } else {
            XMDetail_BriefIntroductionTableViewCell *cell = [[XMDetail_BriefIntroductionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
            return cell;
        }
    } else if (indexPath.section == 1) {
        XMDetail_AnthologyTableViewCell *cell = [[XMDetail_AnthologyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
        return cell;
    } else {
        XMDetail_RelatedTableViewCell *cell = [[XMDetail_RelatedTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
        return cell;
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 0 && indexPath.row == 0) {
//        XMDetail_VideoTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//        cell.playView.toolsView.hidden = !cell.playView.toolsView.hidden;
//    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}
@end
