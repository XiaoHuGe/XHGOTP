//
//  ViewController.m
//  OTP
//
//  Created by zhangbaihu on 16/12/8.
//  Copyright © 2016年 wanwei. All rights reserved.
//

#import "ViewController.h"
#import "HeaderView.h"
#import "UIView+Extension.h"
#import "TOTPGenerator.h"
@interface ViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *otpTableView;
@property (nonatomic, strong) NSMutableArray *array;
@end

static NSString *secret = @"vghbjnkml67t8u9ioplyhuijkopl";

@implementation ViewController

- (NSMutableArray *)array {
    if (!_array) {
        self.array = [NSMutableArray array];
    }
    return _array;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupTableView];
}

- (void)setupTableView {
    self.otpTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    [self.view addSubview:self.otpTableView];
    self.otpTableView.delegate = self;
    self.otpTableView.dataSource = self;
    self.otpTableView.tableFooterView = [UIView new];
    HeaderView *headerV = [[HeaderView alloc] init];
    headerV.height = 80;
    headerV.btnBlock = ^{
        NSString *str = [self addOTPWithTimeLag:arc4random_uniform(10000) + 9999];
        NSLog(@"---%@---",str);
        [_array addObject:str];
        [self.otpTableView reloadData];
    };
    self.otpTableView.tableHeaderView = headerV;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = _array[indexPath.row];
    cell.textLabel.textColor = [UIColor redColor];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:45];
    return cell;
}

- (NSString *)addOTPWithTimeLag:(NSInteger)timelag{
    
    NSData *secretData = [secret dataUsingEncoding:NSASCIIStringEncoding];
    TOTPGenerator *generator
    
    = [[TOTPGenerator alloc] initWithSecret:secretData
                                  algorithm:kOTPGeneratorSHA1Algorithm
                                     digits:6
                                     period:60];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timelag];
    NSString *str = [generator generateOTPForDate:date];
    while (str.length < 6) {
        str = [NSString stringWithFormat:@"0%@",str];
    }
    return str;
}

@end
