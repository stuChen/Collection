//
//  SearchBrandViewController.m
//  differennt
//
//  Created by apple on 15/12/8.
//  Copyright © 2015年 bodecn. All rights reserved.
//

#import "SearchBrandViewController.h"
#import "UITableView+AllowPanGestureEventPass.h"
#import "HistroyView.h"
#import "CategoryViewController.h"

@interface SearchBrandViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource> {
    
    __weak IBOutlet UITextField *SearchTextfield;
    __weak IBOutlet UITableView *BrandTable;
    
    NSArray *_allData; //整体数据
    NSMutableArray *_chooseData; //筛选数据
    NSMutableArray *_SectionArray;//分组
    //历史记录
    HistroyView *_histroyView;
}

@end

@implementation SearchBrandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = LocatizedStirngForkey(@"");
    BrandTable.dataSource = self;
    BrandTable.delegate = self;
    BrandTable.sectionIndexBackgroundColor = [UIColor clearColor];
    [[UITableViewHeaderFooterView appearance] setTintColor:[UIColor clearColor]];
    
    [self addLeftBtn:YES
             BackBtn:YES
             shopBag:[self creatItemWithAction:nil imageName:@"购物包"]
              Search:[self creatItemWithAction:nil imageName:@"搜索"]
                 ALL:[self creatItemWithAction:nil imageName:@"ALL)"]];
    //获取数据内容
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textChange)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:nil];
    [self getData];
}

//监听输入内容
- (void)textChange {
    
    [_chooseData removeAllObjects];
    if (SearchTextfield.text.length > 0) {
        
        _histroyView.hidden = YES;
        
        //搜索内容
        NSString *search = SearchTextfield.text;
        //搜索后内容
        NSArray * array = _allData;
        for (int i = 0; i < search.length; i++) {
            NSString *chart = [NSString stringWithFormat:@"%c",[search characterAtIndex:i]];
            array           = [self reloadChangeData:array content:chart];
        }
        [_chooseData addObjectsFromArray:array];
        [self DataSize:_chooseData];
    }
    else {
        //搜索历史页
        [self addHistroy];
        
        [_chooseData addObjectsFromArray:_allData];;
        [self DataSize:_allData];
    }
}
//加载历史记录
- (void)addHistroy {
    if (!_histroyView) {
        CGFloat originY = 64 + ScreenWidth / 8;
        _histroyView = [[NSBundle mainBundle] loadNibNamed:@"HistroyView" owner:self options:nil].firstObject;
        _histroyView.frame = CGRectMake(0, originY, ScreenWidth, 120);
        [self.view addSubview:_histroyView];
        [self.view bringSubviewToFront:_histroyView];
        _histroyView.hidden = YES;
    }
    //
    _histroyView.hidden = NO;
    [_histroyView searchKey:SearchTextfield.text inKey:@"SearchBrand"];
    //
}
//根据内容筛选
- (NSMutableArray *)reloadChangeData:(NSArray *)array content:(NSString *)content {
    NSMutableArray *SearchArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in array) {
        //获取二级菜单下内容
        NSMutableArray *searchArrayForSection = [[NSMutableArray alloc] init];
        NSArray *array                        = dict[@"Brands"];
        for (NSDictionary *dic in array) {
            //检查是否包含该字符串
            if([[[NSString stringWithFormat:@"%@",dic[@"Name"]] uppercaseString] rangeOfString:[content uppercaseString]].location != NSNotFound) {
                [searchArrayForSection addObject:dic];
            }
        }
        if (searchArrayForSection.count > 0) {
            NSMutableDictionary *chooseDict = [NSMutableDictionary dictionaryWithDictionary:dict];
            [chooseDict removeObjectForKey:@"Brands"];
            [chooseDict setObject:searchArrayForSection forKey:@"Brands"];
            [SearchArray addObject:chooseDict];
        }
    }
    return SearchArray;
}
#pragma mark - get data
- (void)getData {
    [RequestManager PostUrl:URI_GetBrandsGroup loding:nil dic:nil response:^(id response) {
        if (response) {
            if ([response[@"ReturnCode"] integerValue] == 1) {
                _allData = response[@"ReturnData"];
                _chooseData = [NSMutableArray arrayWithArray:_allData];
                [self DataSize:_chooseData];
            }
        }
    }];
}
//tableview 需要的数据
- (void)DataSize:(NSArray *)array {
    if (!_SectionArray) {
        _SectionArray = [[NSMutableArray alloc] init];
    }
    else {
        [_SectionArray removeAllObjects];
    }
    for (NSDictionary *dict in array) {
        [_SectionArray addObject:dict[@"Key"]];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [BrandTable reloadData];
    });
    
}
#pragma mark - textfield delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    //搜索历史页
    [self addHistroy];
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [UserData AddHistroyDataForKey:@"SearchBrand" value:SearchTextfield.text];
    return [textField resignFirstResponder];
}

#pragma mark - tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _chooseData.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_chooseData[section][@"Brands"] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001f;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return _SectionArray[section];
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *HeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
//    UILabel *label = [[UILabel alloc] init];
//    label.font = [UIFont systemFontOfSize:17];
//    return HeaderView;
//}
//关键方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellDeque = @"SearchBrand";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellDeque];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SearchBrand"];
    }
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    cell.textLabel.font  = [UIFont fontWithName:FONT_NAME size:14];
    cell.backgroundColor = [UIColor clearColor];
    if (SearchTextfield.text.length > 0) {
        NSString *search              = SearchTextfield.text;
        NSString *name                = _chooseData[indexPath.section][@"Brands"][indexPath.row][@"Name"];
        cell.textLabel.attributedText = [self rangeAll:name rangeString:search];
    }
    else {
        cell.textLabel.attributedText = [[NSAttributedString alloc]initWithString:@""];
        cell.textLabel.text           = _chooseData[indexPath.section][@"Brands"][indexPath.row][@"Name"];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryViewController *vc = [[CategoryViewController alloc]init];
    vc.BrandId                 = [NSString stringWithFormat:@"%@",_chooseData[indexPath.section][@"Brands"][indexPath.row][@"Id"]];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
#pragma mark - Scroll
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat sectionHeaderHeight = 40;
    //固定section 随着cell滚动而滚动
    if (scrollView.contentOffset.y <= sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        
    } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        
    }
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (_histroyView) {
        _histroyView.hidden = YES;
    }
}
//添加索引列

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return _SectionArray;
}
#pragma mark - 输入字符高亮
- (NSMutableAttributedString *)rangeAll:(NSString *)string rangeString:(NSString *)rangeString {
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:string];
    
    for (int i = 0; i < rangeString.length; i++) {
        //当前字符串
        NSString *nowString = string;
        //遍历输入的每个字符
        NSString *locationString = [NSString stringWithFormat:@"%c",[rangeString characterAtIndex:i]];
        //每次置为初始
        NSInteger firstLocation = 0;
        while ([[nowString uppercaseString] rangeOfString:[locationString uppercaseString]].location != NSNotFound) {
            NSRange range = [[nowString uppercaseString] rangeOfString:[locationString uppercaseString]];//现获取要截取的字符串位置
            [attString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:17] range:NSMakeRange(firstLocation + range.location, range.length)];
            nowString = [nowString substringFromIndex:range.location + range.length];//截取字符串
            firstLocation += range.location + range.length;
        }
    }
    
    return attString;
}


- (void)dealloc {
    DLog(@"已删除");
}
@end
