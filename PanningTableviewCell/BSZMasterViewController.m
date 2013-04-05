//
//  BSZMasterViewController.m
//  PanningTableviewCell
//
//  Created by Struzinski,Mark on 4/4/13.
//  Copyright (c) 2013 BobStruz Software. All rights reserved.
//

#import "BSZMasterViewController.h"
#import "PanningCell.h"

@interface BSZMasterViewController ()

@property(strong,nonatomic) NSArray *dataArray;

@end

@implementation BSZMasterViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.dataArray = @[@"1",@"2",@"3"];
    self.tableView.allowsSelection = NO;
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                               target:self
                                                                               action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    [self.tableView registerClass:[PanningCell class]
           forCellReuseIdentifier:@"PanningCell"];
}

#pragma mark - Table View

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PanningCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PanningCell"
                                                        forIndexPath:indexPath];

    cell.titleLabel.text = self.dataArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
}

@end
