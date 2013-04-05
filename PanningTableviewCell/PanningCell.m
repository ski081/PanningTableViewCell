//
//  PanningCell.m
//  PanningTableviewCell
//
//  Created by Struzinski,Mark on 4/4/13.
//  Copyright (c) 2013 BobStruz Software. All rights reserved.
//

#import "PanningCell.h"
#import <QuartzCore/QuartzCore.h>

static NSTimeInterval const kPCDurationLowLimit     = 0.25; // Lowest duration when swiping the cell because we try to simulate velocity
static NSTimeInterval const kPCDurationHighLimit    = 0.1; // Highest duration when swiping the cell because we try to simulate velocity

@interface PanningCell ()

@property(strong,nonatomic) UIPanGestureRecognizer  *panRecognizer;
@property(nonatomic,assign) CGFloat                 currentPercentage;
@property(assign,nonatomic) PCCellState             currentCellState;
@property(assign,nonatomic) CGFloat                 firstX;
@property(assign,nonatomic) CGFloat                 firstY;

@end

@implementation PanningCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 10.0f, 100.0f, 20.0f)];
        UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(panRecognized:)];
        recognizer.maximumNumberOfTouches = 1;
        recognizer.minimumNumberOfTouches = 1;
        recognizer.delegate = self;
        self.panRecognizer = recognizer;
        self.currentCellState = PCCellStateClosed;
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    NSAssert(self.topView != nil && self.backingView != nil, @"Top view and backing view must be present");
    [self.contentView addSubview:self.backingView];
    [self.contentView addSubview:self.topView];
    [self.topView addSubview:self.titleLabel];
    
    self.topView.layer.shadowColor = [[UIColor darkGrayColor] CGColor];
    self.topView.layer.shadowOffset = CGSizeMake(-3.0f, 0.0f);
    self.topView.layer.shadowRadius = 3.0f;
    self.topView.layer.shadowOpacity = 1.0f;
}

-(void)layoutSubviews{
    [self.topView addGestureRecognizer:self.panRecognizer];
}

//-(UIView *)backingView{
//    if (!_backingView) {
//        _backingView = [[UIView alloc] initWithFrame:self.contentView.bounds];
//        _backingView.backgroundColor = [UIColor greenColor];
//    }
//    return _backingView;
//}
//
//-(UIView *)topView{
//    if (!_topView) {
//        _topView = [[UIView alloc] initWithFrame:self.contentView.bounds];
//        _topView.backgroundColor = [UIColor redColor];
//        [_topView addGestureRecognizer:self.panRecognizer];
//    }
//    return _topView;
//}

-(void)panRecognized:(UIPanGestureRecognizer *)gesture{
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            self.firstX = gesture.view.center.x;
            self.firstY = gesture.view.center.y;
            break;
        case UIGestureRecognizerStateChanged:{
            CGPoint translation = [gesture translationInView:self];
            CGPoint translatedPoint = CGPointMake(self.firstX + translation.x, self.topView.center.y);
            if (translatedPoint.x < 160) {
                translatedPoint.x = 160;
            }
            gesture.view.center = translatedPoint;
        }
            break;
        case UIGestureRecognizerStateEnded:{
            CGPoint velocity = [gesture velocityInView:self];
            NSTimeInterval animationDuration = [self animationDurationWithVelocity:velocity];
            CGFloat percentage = [self percentageWithOffset:self.topView.frame.origin.x
                                            relativeToWidth:CGRectGetWidth(self.bounds)];
            PCCellState updatedState = percentage > .5 ? PCCellStateOpen : PCCellStateClosed;
            [self moveWithDuration:animationDuration
                           toState:updatedState];
        }
            break;
        default:
            break;
    }    
}

#pragma mark - Gesture Recognizer Delegate
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    BOOL shouldBegin = NO;
    if (gestureRecognizer == self.panRecognizer) {
        CGPoint translation = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:self.contentView];
        
        // Check if sure scrolling horizontally
        if (fabs(translation.x) / fabs(translation.y) > 1) {
            shouldBegin = YES;
        }else{
            shouldBegin = NO;
        }
    }
    return shouldBegin;
}

#pragma mark - Utility
- (CGFloat)percentageWithOffset:(CGFloat)offset relativeToWidth:(CGFloat)width {
    CGFloat percentage = offset / width;
    
    if (percentage < -1.0){
        percentage = -1.0;
    }else if (percentage > 1.0) {
        percentage = 1.0;
    }
    
    return percentage;
}

-(void)moveWithDuration:(NSTimeInterval)duration toState:(PCCellState)cellState{
    CGFloat origin = CGRectGetWidth(self.contentView.frame) - 50.0f;
    CGRect rect = self.contentView.frame;
    if (cellState == PCCellStateOpen) {
        rect.origin.x = origin;
    }
    
    rect.size = self.topView.frame.size;

    [UIView animateWithDuration:duration
                          delay:0.0f
                        options:(UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         [self.topView setFrame:rect];
                     } completion:^(BOOL finished) {
                         DLog(@"topview: %@",self.topView);
                     }];
    
}

- (NSTimeInterval)animationDurationWithVelocity:(CGPoint)velocity {
    CGFloat width = CGRectGetWidth(self.bounds);
    NSTimeInterval animationDurationDiff = kPCDurationHighLimit - kPCDurationLowLimit;
    CGFloat horizontalVelocity = velocity.x;
    
    if (horizontalVelocity < -width){
        horizontalVelocity = -width;
    }else if(horizontalVelocity > width){
        horizontalVelocity = width;
    }
    
    return (kPCDurationHighLimit + kPCDurationLowLimit) - fabs(((horizontalVelocity / width) * animationDurationDiff));
}

@end
