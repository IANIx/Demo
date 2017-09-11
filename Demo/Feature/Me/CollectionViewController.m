//
//  CollectionViewController.m
//  XMediaTV
//
//  Created by 李勇杰 on 2017/9/8.
//  Copyright © 2017年 李勇杰. All rights reserved.
//

#import "CollectionViewController.h"

@interface CollectionViewController ()

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = zkHexColor(0x181c28);
    
    UIImageView *image =[[UIImageView alloc]initWithFrame:CGRectMake(80, 160, 180, 120)];
    
    [image setImage:[UIImage imageNamed:@"空"]];
    
    UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(80, 280, 200, 30)];
    label.textColor=[UIColor grayColor];
    label.text=@"No data was obtained";
    [self.view addSubview:label];
    [self.view addSubview:image];
    // Do any additional setup after loading the view.
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
