//
//  TLShopCarViewController.m
//  TL11
//
//  Created by liu on 15-4-16.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLShopCarViewController.h"
#import "TLProdSpecList_color_size.h"
#import "TLProdPurchaseViewController.h"
#import "TLCheckoutViewController.h"
#import "TLShopCar.h"
#import "TLShopCarViewCell.h"
#import "TLBaseTool.h"
#import "TLShopCarRequest.h"
#import "TLShopList.h"
#import "JSONKit.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"
#import "TLImageName.h"
#import "Url.h"
#import "UIImage+TL.h"
#import "MBProgressHUD+MJ.h"
#import "TLSubmitOrderModel.h"
#import "TLOrderDetailMeg.h"
#import "UIColor+TL.h"
#import "UIButton+TL.h"

@interface TLShopCarViewController ()<UITableViewDataSource,UITableViewDelegate,TLShopCarViewCellDelegate,UIAlertViewDelegate>

@property (nonatomic,strong)    TLShopList      *shopList;
@property (nonatomic,strong)    NSMutableArray  *shopCar;
@property (nonatomic,strong)    NSMutableArray  *chectoutProduct;
@property (nonatomic,weak)      UITableView     *tableView;
@property (nonatomic,weak)      UIButton        *rigthButton;
@property (nonatomic,assign)    int             checkoutCount;

@property (weak, nonatomic) IBOutlet UIButton *selectAllButton;
@property (nonatomic,assign) BOOL Selected;
@property (nonatomic,assign) BOOL isEditing;

@property (weak, nonatomic) IBOutlet UIButton *checkout;

@property (weak, nonatomic) IBOutlet UILabel *total;


@property (weak, nonatomic) IBOutlet UIButton *sureButton;

@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@property (weak, nonatomic) IBOutlet UILabel *summation;

- (IBAction)selectAllButton:(UIButton *)sender;

- (IBAction)checkoutButton:(UIButton *)sender;


- (IBAction)sureButton:(UIButton *)sender;

- (IBAction)deleteButton:(UIButton *)sender;


@end


@implementation TLShopCarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


/**
 *  懒加载购物车商品数组
 */
-(NSMutableArray *)chectoutProduct
{
    if (_chectoutProduct == nil) {
        _chectoutProduct = [NSMutableArray array];
    }
    return _chectoutProduct;
}


-(NSMutableArray *)shopCar
{
    if (_shopCar == nil) {
        _shopCar = [NSMutableArray array];
    }
    return _shopCar;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /**
     *  设置tabbar选中的图片
     */
    self.navigationController.tabBarItem.selectedImage = [UIImage originalImageWithName:TL_SHOPPING_CART_PRESS];
    
    CGRect frame = [UIScreen mainScreen].bounds;
    /**
     设置tableView的位置和格式
     */
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, frame.size.width, frame.size.height-108-self.tabBarController.tabBar.bounds.size.height) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.rowHeight = 100;
    /**
     *  设置数据源
     */
    tableView.dataSource = self;
    tableView.delegate = self;
    /**
     *  加入父视图
     */
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    UIButton *rigthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rigthButton.frame = CGRectMake(0, 0, 50, 25);
    [rigthButton setTitle:@"编辑" forState:UIControlStateNormal];
    [rigthButton setTitleColor:[UIColor getColor:@"72C6F7"] forState:UIControlStateNormal];
    rigthButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [rigthButton addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
    _rigthButton = rigthButton;
    UIBarButtonItem *rigthbar = [[UIBarButtonItem alloc]initWithCustomView:rigthButton];
    self.navigationItem.rightBarButtonItem = rigthbar;
    _isEditing = NO;
    
    
    [self.selectAllButton setBackgroundImage:[UIImage imageNamed:TL_CHECK_BOX_NORMAL] forState:UIControlStateNormal];
    [self.selectAllButton setBackgroundImage:[UIImage imageNamed:TL_CHECK_BOX_PRESS] forState:UIControlStateSelected];
    self.selectAllButton.adjustsImageWhenHighlighted = NO;
    self.checkoutCount = 0;
    [self.checkout setTitle:[NSString stringWithFormat:@"结算(%d)",self.checkoutCount] forState:UIControlStateNormal];
    
    self.total.text = @"0";
    
    _sureButton.hidden = YES;
    _deleteButton.hidden = YES;
}


-(void)delete:(UIButton *)rigthButton
{
    if (self.shopCar.count) {
        
        _isEditing = !_isEditing;
        NSString *buttonTitle = _isEditing ? @"完成":@"编辑";
        [rigthButton setTitle:buttonTitle forState:UIControlStateNormal];
        if (_isEditing) {
            _sureButton.hidden = NO;
            _deleteButton.hidden = NO;
            
            _summation.hidden = YES;
            _total.hidden = YES;
        }else
        {
            _sureButton.hidden = YES;
            _deleteButton.hidden = YES;
            
            _summation.hidden = NO;
            _total.hidden = NO;
        }
        [self reloadCellWith:_isEditing];
        if (!_selectAllButton.selected) {
            [self selectAllButton:_selectAllButton];
        }
    }else
    {
        [MBProgressHUD showError:TL_SHOPCAR_EDIT_TIPS];
    }
}

-(void)reloadCellWith:(BOOL)isEditing
{
    int number = (int)self.shopCar.count;
    for (int row = 0; row < number; row++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        TLShopCarViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        [cell edit:isEditing];
         //[self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    }
}



-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController setNavigationBarHidden:NO];
    [self loadData];
}


/**
 *  加载数据
 */
-(void)loadData
{
    NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,shopping_carts_show_Url];
    
    TLShopCarRequest *request = [[TLShopCarRequest alloc]init];

    __unsafe_unretained __typeof(self) weakself = self;
    [TLBaseTool postWithURL:url param:request success:^(id result) {
        weakself.shopList = result;
        weakself.shopCar = weakself.shopList.my_shopping_cart;
        if (weakself.shopCar.count==0) {
            weakself.Selected = NO;
            //[self selectAllButton:nil];
            weakself.total.text = @"0";
            weakself.checkoutCount = 0;
            [weakself.checkout setTitle:[NSString stringWithFormat:@"结算(%d)",weakself.checkoutCount] forState:UIControlStateNormal];
            weakself.selectAllButton.selected = weakself.Selected;
            [weakself.chectoutProduct removeAllObjects];
            weakself.checkout.enabled = NO;
        }else
        {
            weakself.Selected = NO;
            [weakself selectAllButton:nil];
        }
        [weakself.tableView reloadData];
        
    } failure:^(NSError *error) {
        } resultClass:[TLShopList class]];
   
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return self.shopCar.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  取得每组中每行的cell
     */
    TLShopCarViewCell *cell = [TLShopCarViewCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.shopcar = self.shopCar[indexPath.row];
    cell.delegate = self;
    cell.isEditing = _isEditing;
    return cell;
}
/**
 *  选择商品跳转商品详情
 *
 *  @param tableView 商品列表
 *  @param indexPath 列表
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    TLShopCarViewCell *cell = (TLShopCarViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    TLShopCar *shopcar = self.shopCar[indexPath.row];
    UIButton *button = (UIButton *)[cell viewWithTag:1000];
    [self TLShopCarViewCellWithSelectButton:button prod:shopcar];
}


-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isEditing) {
        return UITableViewCellEditingStyleNone;
    }else
    {
       return UITableViewCellEditingStyleDelete;
    }
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSString *url = [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,item_remove_Url];
        
        NSMutableArray *temp = [NSMutableArray array];
        TLShopCar *shop = self.shopCar[indexPath.row];
        NSDictionary *dict = @{@"seq_no":shop.seq_no,@"product_id":shop.prod_id};
        [temp addObject:dict];
        NSDictionary *detailDict = @{@"detail":temp};
        
        NSString *json = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:detailDict options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
        
        NSDictionary *param = @{@"user_id":[TLPersonalMegTool currentPersonalMeg].user_id,TL_USER_TOKEN:[TLPersonalMegTool currentPersonalMeg].token,@"detail_json":json};
        
        __unsafe_unretained __typeof(self) weakself = self;
        [TLHttpTool postWithURL:url params:param success:^(id json) {
            if ([weakself.chectoutProduct containsObject:shop]) {
                [weakself.chectoutProduct removeObject:shop];
                weakself.total.text =  [NSString stringWithFormat:@"%.2f",[weakself.total.text doubleValue]-[shop.price doubleValue]*[shop.order_qty intValue]];
                weakself.checkoutCount -= [shop.order_qty intValue];
            }
            [weakself.shopCar removeObject:shop];
            if (weakself.chectoutProduct.count) {
                weakself.checkout.enabled = YES;
                if (_chectoutProduct.count == _shopCar.count) {
                    weakself.selectAllButton.selected = YES;
                    weakself.Selected = weakself.selectAllButton.selected;
                }
            }else
            {
                weakself.checkout.enabled = NO;
                weakself.selectAllButton.selected = NO;
                weakself.Selected = weakself.selectAllButton.selected;
            }
            [weakself.checkout setTitle:[NSString stringWithFormat:@"结算(%d)",self.checkoutCount] forState:UIControlStateNormal];
            [weakself.tableView reloadData];
            [MBProgressHUD showSuccess:TL_SHOPCAR_DELETE_SUCCESS];
        } failure:nil];
    }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id vc = segue.destinationViewController;
    if ([vc  isKindOfClass: [TLProdPurchaseViewController class]]) {
        TLProdPurchaseViewController *prodPurchase = vc;
        prodPurchase.prod_id = sender;
    }else if ([vc isKindOfClass:[TLCheckoutViewController class]])
    {
        TLCheckoutViewController *checkoutView = vc;
        checkoutView.orderDetailMeg = sender;
        checkoutView.chectoutProduct = self.chectoutProduct;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  选择所有现在按键
 *
 *  @param sender 全选按键
 */
- (IBAction)selectAllButton:(UIButton *)sender {

    [self.chectoutProduct removeAllObjects];
    self.total.text = @"0";
    self.checkoutCount = 0;
    if (self.shopCar.count) {
        self.Selected = !self.Selected;
        self.selectAllButton.selected = self.Selected;
        for (TLShopCar *shopCar in self.shopCar)
        {
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",self.Selected] forKey:shopCar.seq_no];
            if (self.Selected) {
                self.total.text =  [NSString stringWithFormat:@"%.2f",[self.total.text doubleValue]+[shopCar.price doubleValue]*[shopCar.order_qty intValue]];
                self.checkoutCount += [shopCar.order_qty intValue];
                [self.chectoutProduct addObject:shopCar];
                self.checkout.enabled = YES;
            }else
            {
                self.checkoutCount = 0;
                self.total.text = @"0";
                self.checkout.enabled = NO;
            }
        }

    }else
    {
        self.checkoutCount = 0;
        self.total.text = @"0";
        self.checkout.enabled = NO;
    }
    
    [self.checkout setTitle:[NSString stringWithFormat:@"结算(%d)",self.checkoutCount] forState:UIControlStateNormal];
    [self.tableView reloadData];
}


-(void)TLShopCarViewCellWithSelectButton:(UIButton *)btn prod:(TLShopCar *)prod
{

    btn.selected = !btn.selected;
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",btn.selected] forKey:prod.seq_no];
    if (self.Selected) {
        self.Selected = !self.Selected;
        self.selectAllButton.selected = self.Selected;
    }
    self.checkoutCount = 0;
    self.total.text = @"0";
    [self.chectoutProduct removeAllObjects];
    int number=0;
    for (TLShopCar *shopCar in self.shopCar)
    {
        BOOL sign = [[[NSUserDefaults standardUserDefaults] objectForKey:shopCar.seq_no]intValue];
        if (sign) {
            number ++;
            self.checkoutCount += [shopCar.order_qty intValue];
            self.total.text =  [NSString stringWithFormat:@"%.2f",[self.total.text doubleValue]+[shopCar.price doubleValue]*[shopCar.order_qty intValue]];
            [self.chectoutProduct addObject:shopCar];
            self.checkout.enabled = YES;
        }
        if (number == self.shopCar.count) {
            self.Selected = !self.Selected;
            self.selectAllButton.selected = self.Selected;
        }
        if (self.checkoutCount == 0) {
            self.checkout.enabled = NO;
        }
    }
    [self.checkout setTitle:[NSString stringWithFormat:@"结算(%d)",self.checkoutCount] forState:UIControlStateNormal];
    [self.tableView reloadData];

}


- (IBAction)checkoutButton:(UIButton *)sender
{
    [sender ButtonDelay];

    TLSubmitOrderModel *submitOrder = [[TLSubmitOrderModel alloc]init];
    NSMutableArray *prodNoArray = [NSMutableArray array];
        for (TLShopCar *shopCar in self.chectoutProduct) {
          //  NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:shopCar.prod_id,@"detail_no", nil];
            [prodNoArray addObject:shopCar.seq_no];
        }
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:prodNoArray,@"product_info", nil];
    NSString *dict_string = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    submitOrder.product_info_json = dict_string;
    NSString *url= [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,balance_Url];
    
    __unsafe_unretained __typeof(self) weakself = self;
    [TLBaseTool postWithURL:url param:submitOrder success:^(id result) {
        TLOrderDetailMeg *orderDetailMeg = result;
        [weakself performSegueWithIdentifier:@"submitorder" sender:orderDetailMeg];
    } failure:nil resultClass:[TLOrderDetailMeg class]];
    
}

- (IBAction)sureButton:(UIButton *)sender {
    [self delete:_rigthButton];
}

- (IBAction)deleteButton:(UIButton *)sender {
    NSString *url = [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,item_remove_Url];
    
    NSMutableArray *temp = [NSMutableArray array];
    for (TLShopCar *shop in self.chectoutProduct) {
        NSDictionary *dict = @{@"seq_no":shop.seq_no,@"product_id":shop.prod_id};
        [temp addObject:dict];
    }
    NSDictionary *detailDict = @{@"detail":temp};
    
    NSString *json = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:detailDict options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    
    NSDictionary *param = @{@"user_id":[TLPersonalMegTool currentPersonalMeg].user_id,TL_USER_TOKEN:[TLPersonalMegTool currentPersonalMeg].token,@"detail_json":json};
    
    __unsafe_unretained __typeof(self) weakself = self;
    [TLHttpTool postWithURL:url params:param success:^(id json) {
        [weakself.shopCar removeObjectsInArray:weakself.chectoutProduct];
        [weakself.chectoutProduct removeAllObjects];
        weakself.checkoutCount = 0;
        weakself.total.text = @"0";
        weakself.checkout.enabled = NO;
        [weakself.checkout setTitle:[NSString stringWithFormat:@"结算(%d)",weakself.checkoutCount] forState:UIControlStateNormal];
        [weakself.tableView reloadData];
        [MBProgressHUD showSuccess:TL_SHOPCAR_DELETE_SUCCESS];
        if (!weakself.shopCar.count) {
            _isEditing = !_isEditing;
            NSString *buttonTitle = _isEditing ? @"完成":@"编辑";
            [_rigthButton setTitle:buttonTitle forState:UIControlStateNormal];
            if (_isEditing) {
                _sureButton.hidden = NO;
                _deleteButton.hidden = NO;
                
                _summation.hidden = YES;
                _total.hidden = YES;
            }else
            {
                _sureButton.hidden = YES;
                _deleteButton.hidden = YES;
                
                _summation.hidden = NO;
                _total.hidden = NO;
            }
            weakself.selectAllButton.selected = NO;
            weakself.Selected = weakself.selectAllButton.selected;
        }
    } failure:nil];
}
@end
