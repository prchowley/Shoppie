//
//  CartViewController.m
//  Shoppie
//
//  Created by Priyabrata Chowley on 7/7/16.
//  Copyright © 2016 Priyabrata Chowley. All rights reserved.
//

#import "CartViewController.h"
#import "ProductTableViewCell.h"

@interface CartViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tblviewCart;

@property (weak, nonatomic) IBOutlet UILabel *lblTotalAmount;

@end

@implementation CartViewController{
    NSMutableArray * arrCartItems;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavigationBar];
    self.navBar.btnCart.hidden = self.navBar.btnSearch.hidden = YES;
    self.navBar.lblTitle.text = @"My Cart";
    
    [self loadData];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tblviewCart reloadData];
}

// MARK:- UITablevieDatasource and Delegates -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrCartItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ProductTableViewCell * cell;
    
    if (!cell) {
        [self.tblviewCart registerNib:[UINib nibWithNibName:@"ProductCell" bundle:nil] forCellReuseIdentifier:@"ProductTableViewCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"ProductTableViewCell" forIndexPath:indexPath];
    }
    
    
    cell.constWidthButton.constant = 0;
    cell.btnBuy.clipsToBounds = YES;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.userInteractionEnabled = NO;
    
    //Placing Values
    Product * prod = [arrCartItems objectAtIndex:indexPath.row];
    cell.lblProduct.text = prod.name;
    cell.imgProduct.image = [UIImage imageNamed:prod.productImage];
    
    [cell.btnView setTitle:@"Remove from cart" forState:UIControlStateNormal];
    cell.btnView.tag = indexPath.row;
    [cell.btnView addTarget:self action:@selector(removeFromCart:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

// MARK:- Cell button action -
- (void)removeFromCart:(UIButton *)btn{
    
    Product * prod = [arrCartItems objectAtIndex:btn.tag];
    [DBManager deleteItemOfID:prod.productID.stringValue inType:kEntityTypeCart];
    [arrCartItems removeObjectAtIndex:btn.tag];
    [_tblviewCart reloadData];
    
}

// MARK:- Initialization -
- (void)loadData{
    
    arrCartItems = [NSMutableArray array];
    
    [DBManager getDBValuesOfType:kEntityTypeCart andPerdicate:nil andWithCompletion:^(NSArray *items) {
        
        for (Cart * cartItem in items) {
            NSString * strPredicateFOrmat = [NSString stringWithFormat:@"productID == %@",cartItem.productid];
            [DBManager getDBValuesOfType:kEntityTypeProduct andPerdicate:strPredicateFOrmat andWithCompletion:^(NSArray *items1) {
                if (items1.count>0) {
                    
                    Product * prod = items1.firstObject;
                    if ([_lblTotalAmount.text isEqualToString:@"Total Amount"]) {
                        _lblTotalAmount.text = @"0";
                    }
                    _lblTotalAmount.text = [NSString stringWithFormat:@"%d",(_lblTotalAmount.text.intValue + prod.price.intValue)];
                    [arrCartItems addObject:prod];
                    
                }
                [_tblviewCart reloadData];
            }];
        }
    }];
}
- (IBAction)actionBuy:(id)sender {
    
    
    for (Product * prod in arrCartItems) {
        [DBManager buyProduct:prod];
    }
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Success!"
                                  message:@"Thanks for buying our lovely products!"
                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Visit again"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             [arrCartItems removeAllObjects];
                             [_tblviewCart reloadData];
                             
                         }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
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
