//
//  XMMeViewController.m
//  Demo
//
//  Created by 薛佳妮 on 2017/8/3.
//  Copyright © 2017年 李勇杰. All rights reserved.
//

#import "XMMeViewController.h"
#import "XM_MeInfoTableViewCell.h"
#import "XM_MeActionTableViewCell.h"
#import "XM_MEDeatilTableViewCell.h"
@interface XMMeViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy  ) NSArray *dataSourceArray;

@end

@implementation XMMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = zkHexColor(0x181c28);
    _dataSourceArray = @[@{@"image":@"形状-1",@"text":@"My playing history"},
                         @{@"image":@"矩形-1",@"text":@"My collection"},
                         @{@"image":@"矩形-1-拷贝-7",@"text":@"My reservation"},
                         @{@"image":@"矩形-1-拷贝-2",@"text":@"Scan"},
                         @{@"image":@"矩形-1-拷贝-3",@"text":@"My order center"},
                         @{@"image":@"形状-68",@"text":@"My question feedback"},
                         @{@"image":@"矩形-1-拷贝-5",@"text":@"My discount code"},
                         @{@"image":@"形状-70",@"text":@"My settings"}];
    [self setupSubViews];
    /*
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 50)];
    [self.view addSubview:view];
    view.center = self.view.center;
    
    UIColor *color1 = RGBCOLOR(119, 64, 210);
    UIColor *color2 = RGBCOLOR(45, 104, 210);
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    
    gradient.colors = @[(id)[color1 colorWithAlphaComponent:1.f].CGColor,
                        (id)[color2 colorWithAlphaComponent:1.f].CGColor];
    
    gradient.locations = @[[NSNumber numberWithFloat:0.4f],
                           [NSNumber numberWithFloat:1.f]];
    
    gradient.startPoint = CGPointMake(0, .5);
    gradient.endPoint = CGPointMake(1, .5);
    [view.layer addSublayer:gradient];
    view.layer.cornerRadius = 25.f;
    view.layer.masksToBounds = YES;
     */
    // Do any additional setup after loading the view.
}

- (void)setupSubViews {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.top.bottom.equalTo(self.view);
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
    return  section == 2 ? self.dataSourceArray.count : 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = [NSString stringWithFormat:@"CELL%ld",(long)indexPath.section];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        if (indexPath.section == 2) {
            cell = [[XM_MEDeatilTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL2"];
        } else if (indexPath.section == 1){
            cell = [[XM_MeActionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL1"];
        } else {
            cell = [[XM_MeInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL0"];
        }
    }
    
    if ([cell isKindOfClass:[XM_MEDeatilTableViewCell class]]) {
        [((XM_MEDeatilTableViewCell *)cell) updateCellWithDic:_dataSourceArray[indexPath.row]];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 44+74;
    } else if (indexPath.section == 1) {
        return 100;
    } else {
        return 36+22;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.000001;
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
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}
@end
