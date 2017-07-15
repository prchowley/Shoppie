//
//  MainViewController.m
//  Shoppie
//
//  Created by Priyabrata Chowley on 7/4/16.
//  Copyright © 2016 Priyabrata Chowley. All rights reserved.
//

#import "MainViewController.h"
#import "ProductTableViewCell.h"
#import "ViewSort.h"

@interface MainViewController ()

@property (strong, nonatomic) NSMutableArray * arrProducts;

@property (weak, nonatomic) IBOutlet UITableView *tblViewProduct;

@property (weak, nonatomic) IBOutlet UIButton *btnSort;

@end

@implementation MainViewController{
    CGPoint centerViewSort;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavigationBar];
    
    [self.navBar.txtSearch addTarget:self action:@selector(searchProduct:) forControlEvents:UIControlEventEditingChanged];
    
    _viewSort.layer.cornerRadius = _viewSort.frame.size.height/2;
    _viewSort.layer.masksToBounds = YES;
    
    
    _arrProducts = [NSMutableArray array];
    
    [DBManager getDBValuesOfType:kEntityTypeProduct andPerdicate:nil andWithCompletion:^(NSArray *items) {
        _arrProducts = items.mutableCopy;
    }];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    [self.tblViewProduct registerNib:[UINib nibWithNibName:@"ProductCell" bundle:nil] forCellReuseIdentifier:@"ProductTableViewCell"];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [_tblViewProduct reloadData];
}

// MARK:- Tableview Datasource and Delegates -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrProducts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ProductTableViewCell * cell;
    
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"ProductCell" bundle:nil] forCellReuseIdentifier:@"ProductTableViewCellMain"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"ProductTableViewCellMain" forIndexPath:indexPath];
    }
    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.viewMain.layer.borderColor = [UIColor colorWithRed:0.871 green:0.502 blue:0.141 alpha:1.00].CGColor;
    cell.viewMain.layer.borderWidth = 1;
    cell.viewMain.layer.cornerRadius = 5;
    cell.viewMain.layer.masksToBounds = YES;
    
    Product * prod = [_arrProducts objectAtIndex:indexPath.row];
    
    cell.lblProduct.text = prod.name;
    cell.imgProduct.image = [UIImage imageNamed:prod.productImage];
    
    cell.btnBuy.tag = cell.btnView.tag = prod.productID.integerValue;
    
    [cell.btnBuy addTarget:self action:@selector(actionCellButtonOne:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnView addTarget:self action:@selector(actionCellButtonTwo:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.contentView.userInteractionEnabled = NO;
    
    cell.constWidthButton.constant = (cell.btnBuy.superview.frame.size.width/2)-1;
    [cell layoutIfNeeded];
    
    return cell;
}
// MARK:- UITextField Delegates -
- (void)searchProduct:(UITextField *)textField{
    
    if (textField.text.length==0) {
        [DBManager getDBValuesOfType:kEntityTypeProduct andPerdicate:nil andWithCompletion:^(NSArray *items) {
            _arrProducts = items.mutableCopy;
            [_tblViewProduct reloadData];
        }];
        return;
    }
    
    NSString * strPredicate = [NSString stringWithFormat:@"name CONTAINS[cd] \"%@\"",textField.text];
    [DBManager getDBValuesOfType:kEntityTypeProduct andPerdicate:strPredicate andWithCompletion:^(NSArray *items) {
        _arrProducts = items.mutableCopy;
        [_tblViewProduct reloadData];
    }];
    
}
// MARK:- Cell button actions -
- (void)actionCellButtonOne:(UIButton *)btn{
    
    //Do the first button press over here
    [self addCartAnimationOfButton:btn];
    
    [self updateCart:@(btn.tag).stringValue];
    
}
- (void)actionCellButtonTwo:(UIButton *)btn{
    //Do the second button press over here
    [self addCartAnimationOfButton:btn];
    
    [self updateCart:@(btn.tag).stringValue];
    
}

- (void)updateCart:(NSString *)productID{
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:productID forKey:@"productid"];
    
    [DBManager insertData:dic intoEntityType:kEntityTypeCart];
}


- (void)addCartAnimationOfButton:(UIButton *)btn {
    centerViewSort = self.navBar.btnCart.center;
    
    //button position respective to the window
    CGRect position = [btn convertRect:btn.bounds toView:nil];
    
    UIView * view = [[UIView alloc] initWithFrame:position];
    view.backgroundColor = self.navBar.backgroundColor;
    
    [self.view addSubview:view];
    
    [UIView animateWithDuration:0.2 animations:^{
        
        view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, self.navBar.btnCart.frame.size.width, self.navBar.btnCart.frame.size.height);
        view.layer.cornerRadius = view.frame.size.height/2;
        view.layer.masksToBounds = YES;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            view.alpha = 0.0;
            view.center = self.navBar.btnCart.center;
            
        }];
    }];
}
// MARK:- Other actions -
- (IBAction)actionSort:(id)sender {
    
    //add sort popup view over here
    
    centerViewSort = _viewSort.center;
    
    [UIView animateWithDuration:0.3 animations:^{
        _viewSort.center = self.view.center;
        
    } completion:^(BOOL finished) {
        ViewSort * vSort = [[NSBundle mainBundle] loadNibNamed:@"ViewSort" owner:self options:nil].firstObject;
        vSort.frame = _viewSort.frame;
        vSort.layer.cornerRadius = _viewSort.layer.cornerRadius;
        
        [self.view addSubview:vSort];
        
        [UIView animateWithDuration:0.3 animations:^{
            _viewSort.alpha = 0.0;
            CGFloat heightOfSortView = self.view.frame.size.height;
            vSort.frame = CGRectMake(0, 0, [self widthOfView:self.view], heightOfSortView);
            
        }];
        
        UITapGestureRecognizer * tapView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closePopup:)];
        [vSort addGestureRecognizer:tapView];
        
        [vSort.btnPrice addTarget:self action:@selector(sortArray:) forControlEvents:UIControlEventTouchUpInside];
        [vSort.btnAvaQuatity addTarget:self action:@selector(sortArray:) forControlEvents:UIControlEventTouchUpInside];
    }];
    
    
    
}
- (void)sortArray:(UIButton *)btn{
    
    [self closePopup:btn.superview];
    
    NSString * strDescriptorName;
    
    
    switch (btn.tag) {
        case 0:
        {
            //Price
            strDescriptorName = @"price";
        }
            break;
        case 1:
        {
            //Quantity
            strDescriptorName = @"quantity";
        }
            break;
            
        default:
            break;
    }
    NSSortDescriptor *nameDescriptor = [NSSortDescriptor sortDescriptorWithKey:strDescriptorName ascending:YES];
    NSArray *sorted = [_arrProducts sortedArrayUsingDescriptors:[NSArray arrayWithObject:nameDescriptor]];
    _arrProducts = [NSMutableArray arrayWithArray:sorted];
    [_tblViewProduct reloadData];
}
- (void)closePopup:(id)sender{
    
    UIView * view;
    
    if ([sender isKindOfClass:[UIGestureRecognizer class]]) {
        view = ((UIGestureRecognizer *)sender).view;
    }else{
        view = (UIView *)sender;
    }
    
    [UIView  animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
        view.frame = _viewSort.frame;
        view.alpha = 0.0;
        _viewSort.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            _viewSort.center = centerViewSort;
        }];
    }];
    
}

@end
