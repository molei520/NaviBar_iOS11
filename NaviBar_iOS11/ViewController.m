//
//  ViewController.m
//  NaviBar_iOS11
//
//  Created by zhangMo on 2017/9/27.
//  Copyright © 2017年 AutoHome. All rights reserved.
//

#import "ViewController.h"
#import "ResultViewController.h"

static NSString *reuseIdentifier = @"cell";

@interface ViewController ()<UISearchControllerDelegate,UISearchResultsUpdating,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) ResultViewController *resultVC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"大标题";
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.definesPresentationContext = YES;
    
    _resultVC = [[ResultViewController alloc] init];
    UISearchController *search = [[UISearchController alloc] initWithSearchResultsController:_resultVC];
    search.searchResultsUpdater = self;
    search.delegate = self;
    search.hidesNavigationBarDuringPresentation = NO;
    self.navigationItem.searchController = search;

    [self createSubViewsAndConstraints];
    [self config];
}

- (void)config {
    _dataArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 20; i++) {
        NSInteger temp = arc4random() + 1500000;
        [_dataArray addObject:[NSString stringWithFormat:@"%zd",temp]];
    }
    [_table reloadData];
}

#pragma mark - Create Subviews
- (void)createSubViewsAndConstraints {
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.textLabel.text = _dataArray[indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *text = searchController.searchBar.text;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF BEGINSWITH %@",text];
    NSArray *resultArray = [_dataArray filteredArrayUsingPredicate:predicate];
    NSLog(@"array : %@",resultArray);
    _resultVC.dataArray = resultArray;
    [_resultVC reloadData];
}

#pragma mark - dealloc
- (void)dealloc {
    NSLog(@"<< dealloc >>");
}

@end
