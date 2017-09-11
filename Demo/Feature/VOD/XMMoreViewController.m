//
//  XMMoreViewController.m
//  Demo
//
//  Created by 薛佳妮 on 2017/8/22.
//  Copyright © 2017年 李勇杰. All rights reserved.
//

#import "XMMoreViewController.h"
#import "XMMoreCollectionViewCell.h"
#define cellWidth (MainScreenWidth - 50)/3
#define cellHeight cellWidth*2
@interface XMMoreViewController () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) NSMutableArray<XM_ContentModel *> *dataSource;
@end

@implementation XMMoreViewController
static NSString *const cellIdentifier = @"CELL";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"More";
    self.dataSource = @[].mutableCopy;
    [self getcontentCategory];
    [self.view addSubview:self.collection];
    [self.collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];

    // Do any additional setup after loading the view.
}
- (void)getcontentCategory{
    [[XM_HTTPRequest manager] requestWithMethod:POST
                                       WithPath:XM_CONTENTLIST_URL
                                     WithParams:@{@"mac":[self getMacAddress],
                                                  @"mediaType":@"vod",
                                                  @"categoryId":self.menu.categoryId,
                                                  @"pageSize":@30,
                                                  @"page":@1}
                               WithSuccessBlock:^(NSDictionary *dic) {
                                   XM_ContentListModel *model = [XM_ContentListModel yy_modelWithDictionary:dic];
                                   if (model.resultCode == 0) {
                                       [self.dataSource addObjectsFromArray:model.contents];
                                       [self.collection reloadData];
                                   }
                               } WithFailurBlock:^(NSError *error) {
                               }];
}
#pragma mark - collection
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (CGSize){cellWidth,cellHeight};
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XMMoreCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell updatecontent:self.dataSource[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *viewController = [XMRouter matchController:@"vod/detail" withDic:@{@"content":self.dataSource[indexPath.row]}];
    [self.navigationController pushViewController:viewController animated:YES];
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
- (UICollectionView *)collection {
    if (_collection == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _collection = [[UICollectionView alloc] initWithFrame:[[UIScreen mainScreen] bounds] collectionViewLayout:flowLayout];
        [_collection registerClass:[XMMoreCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
        _collection.backgroundColor = zkHexColor(0x181c28);
        _collection.delegate = self;
        _collection.dataSource = self;
        
    }
    return _collection;
}

@end
