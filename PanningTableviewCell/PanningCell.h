//
//  PanningCell.h
//  PanningTableviewCell
//
//  Created by Struzinski,Mark on 4/4/13.
//  Copyright (c) 2013 BobStruz Software. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PCSwipeTableViewCellDirection){
    PCSwipeTableViewCellDirectionLeft = 0,
    PCSwipeTableViewCellDirectionCenter,
    PCSwipeTableViewCellDirectionRight
};

typedef NS_ENUM(NSUInteger, PCSwipeTableViewCellMode){
    PCSwipeTableViewCellModeExit = 0,
    PCSwipeTableViewCellModeSwitch
};

typedef NS_ENUM(NSUInteger, PCCellState){
    PCCellStateClosed = 0,
    PCCellStateOpen = 1
};

@interface PanningCell : UITableViewCell<UIGestureRecognizerDelegate>

@property(strong,nonatomic) UIView                      *drawerView;
@property(strong,nonatomic) UILabel                     *titleLabel;
@property(assign,nonatomic) PCSwipeTableViewCellMode    mode;

@end
