//
//  tableViewController.m
//  block实现城市传值
//
//  Created by 孙月明 on 16/4/19.
//  Copyright © 2016年 Sym. All rights reserved.
//

#import "tableViewController.h"

@interface tableViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    NSMutableArray * dataSource;//数据源
    NSMutableArray * searchArr;//添加最终的搜索结果
    UISearchBar * searchBar1;//添加搜索控件
    BOOL searchBool;//判断是否进入加载模式
    //UISearchDisplayController * display;
    UISearchContainerViewController * display;
}
@property (nonatomic,strong)UITableView * tableView;
@end

@implementation tableViewController
- (NSMutableArray *)dataSource{
    if (dataSource == nil) {
        dataSource = [NSMutableArray array];
        for(int i = 'A';i<='Z';i++)
        {
            NSMutableArray * subArr = [[NSMutableArray alloc]init];
            for(int j = 0;j<10;j++)
            {
                NSString * string = [NSString stringWithFormat:@"%c%d",i,j];
                [subArr addObject:string];
            }
            [dataSource addObject:subArr];
        }
    }
    return dataSource;
}
- (NSMutableArray *)searchArr{
    if (searchArr == nil) {
        searchArr = [NSMutableArray array];
    }
    return searchArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    searchBool = NO;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self tableView:self.view];
    // Do any additional setup after loading the view.
}
- (void)tableView:(UIView *)view{
    [self dataSource];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [view addSubview:self.tableView];
    searchBar1 = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 300, 44)];
    //display = [[UISearchContainerViewController alloc]initWithSearchController:searchBar];
    searchBar1.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    searchBar1.showsSearchResultsButton = YES;
    searchBar1.delegate = self;
    self.tableView.tableHeaderView = searchBar1;
    [self searchArr];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSString * string = searchText;
    searchBool = !searchBool;
    //NSLog(@"%@",searchText);
    for(NSArray * arr in dataSource)
    {
        for(NSString * str in arr)
        {
            //遍历每个小数组中的每个字符串与搜索框中的内容比较 查看是否包含
            NSRange range = [str rangeOfString:string];
            if(range.location != NSNotFound)
            {
                //添加的是父字符串
                [searchArr addObject:str];
            }
        }
    }
    [self.tableView reloadData];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.tableView reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(searchBool == NO)
    {
        return [dataSource count];
    }
    else
    {
        return 1;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(searchBool == NO)
    {
        return [[dataSource objectAtIndex:section] count];
    }
    else
    {
        //否则显示搜索数组中元素的个数
        //<1>清空搜索数组
        [searchArr removeAllObjects];
        //<2>根据搜索框中的内容为搜索数组添加信息
        //此处的搜索使用的是模糊查询
        NSString * string = searchBar1.text;
        
        for(NSArray * arr in dataSource)
        {
            for(NSString * str in arr)
            {
                //遍历每个小数组中的每个字符串与搜索框中的内容比较 查看是否包含
                NSRange range = [str rangeOfString:string];
                if(range.location != NSNotFound)
                {
                    //添加的是父字符串
                    [searchArr addObject:str];
                }
            }
        }
        
        return [searchArr count];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * ID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if(searchBool == NO)
    {
        cell.textLabel.text = [[dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    }
    else
    {
        cell.textLabel.text = [searchArr objectAtIndex:indexPath.row];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(searchBool == NO)
    {
        //设置分区的头标题
        return [NSString stringWithFormat:@"%c",'A'+section];
    }
    else
    {
        return @"搜索结果";
    }
}
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray * arr = [NSMutableArray array];
    
    NSString * path = [[NSBundle mainBundle]pathForResource:@"CityList.plist" ofType:nil];
    NSDictionary * dic = [NSDictionary dictionary];
    dic = [NSDictionary dictionaryWithContentsOfFile:path];
    for (NSString * s in [dic allKeys]) {
        [arr addObject:s];
    }
    
    NSMutableArray * dataArr = [NSMutableArray array];
    for (NSInteger i = 0; i < arr.count-1; i++) {
        for (NSInteger y = 1; y<arr.count; y++) {
            if (arr[i] < arr[y]) {
                [dataArr addObject:arr[i]];
                //NSLog(@"%@",dataArr);
            }
//            else{
//                [dataArr addObject:arr[y]];
//                
//            }
        }
    }
    NSLog(@"data= %@",dataArr);
    [arr sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString *a = (NSString *)obj1;
        NSString *b = (NSString *)obj2;
        int aNum = [[a substringFromIndex:1] intValue];
        NSLog(@"%@",a);
        int bNum = [[b substringFromIndex:1] intValue];
        NSLog(@"%@",b);
        if (aNum > bNum) {
            return NSOrderedDescending;
        }
        else if (aNum < bNum){
            return NSOrderedAscending;
        }
        else {
            return NSOrderedSame;
        }
    }];
    NSLog(@"dic= %@",arr);
    //添加所有分区的名称
    //通过分区名称进行模糊查询
//    for(int i = 'A';i<='Z';i++)
//    {
//        [arr addObject:[NSString stringWithFormat:@"%c",i]];
//    }
    return arr;
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
