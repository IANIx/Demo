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

@end

@implementation XMDeatilViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Detail";
    // Do any additional setup after loading the view.
}

- (void)setupSubViews {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
}

-(void)creatRequestmenu{
    [[XM_HTTPRequest manager] requestWithMethod:POST
                                       WithPath:XM_CONTENTDETAIL_URL
                                     WithParams:@{@"mac":[self getMacAddress],
                                                  @"contentId":@"0",
                                                 }
     
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

#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 3 : 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            XMDetail_VideoTableViewCell *cell = [[XMDetail_VideoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
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
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}
@end
