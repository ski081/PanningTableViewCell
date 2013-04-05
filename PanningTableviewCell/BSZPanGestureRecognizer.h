//
//  BSZPanGestureRecognizer.h
//  PanningTableviewCell
//
//  Created by Struzinski,Mark on 4/4/13.
//  Copyright (c) 2013 BobStruz Software. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum BSZPanGestureRecognizerDirection{
    BSZPanGestureRecognizerDirectionHorizontal = (UISwipeGestureRecognizerDirectionRight | UISwipeGestureRecognizerDirectionLeft),
    BSZPanGestureRecognizerDirectionVertical  = (UISwipeGestureRecognizerDirectionUp | UISwipeGestureRecognizerDirectionDown),
} BSZPanGestureRecognizerDirection;

@interface BSZPanGestureRecognizer : UIPanGestureRecognizer

@property(assign,nonatomic) BSZPanGestureRecognizerDirection direction;
@property(assign,nonatomic,readonly) BOOL panRecognized;

@end
