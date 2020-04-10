//
//  PatternView.m
//  ToolPackage
//
//  Created by xing on 2019/12/30.
//  Copyright © 2019 xing. All rights reserved.
//

#import "PatternView.h"
#import <QuartzCore/QuartzCore.h>

@interface PatternNodeView : UIView

@property (nonatomic, assign) BOOL selected;
@property (nonatomic, strong) UIView *pointView;

@end

@implementation PatternNodeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatPointView];
    }
    return self;
}

- (void)creatPointView
{
    _pointView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    _pointView.backgroundColor = [UIColor darkGrayColor];
    _pointView.layer.cornerRadius = _pointView.bounds.size.width / 2.0;
    _pointView.layer.masksToBounds = YES;
    _pointView.center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
    _pointView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin |
                                    UIViewAutoresizingFlexibleBottomMargin |
                                    UIViewAutoresizingFlexibleLeftMargin |
                                    UIViewAutoresizingFlexibleRightMargin;
    [self addSubview:_pointView];
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    _pointView.backgroundColor = selected ? [UIColor greenColor] : [UIColor darkGrayColor];
}

@end


@interface PatternView ()

@property (nonatomic, strong) NSMutableArray *nodeViews;
@property (nonatomic, strong) NSMutableArray *selectedNodes;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, assign) CGPoint currentPoint;

@end

@implementation PatternView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initiation];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initiation];
    }
    return self;
}

- (void)initiation
{
    _selectedNodes = [[NSMutableArray alloc] init];
    [self creatItemViews];
    [self createShapeLayer];
}

- (void)creatItemViews
{
    _nodeViews = [[NSMutableArray alloc] init];
    
    CGFloat itemWidth= floor(self.bounds.size.width / 3.0);
    CGFloat itemHeight= floor(self.bounds.size.height / 3.0);
    for (int i = 0; i < 9; i++) {
        CGRect frame = CGRectMake((i%3) * itemWidth, (i/3) * itemHeight, itemWidth, itemHeight);
        PatternNodeView *node = [[PatternNodeView alloc] initWithFrame:frame];
        node.tag = i+1;
        [self addSubview:node];
        [_nodeViews addObject:node];
    }
}

- (void)createShapeLayer
{
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.lineWidth = 5;
    layer.lineCap = kCALineCapRound;
    layer.lineJoin = kCALineJoinBevel;
    layer.strokeColor = [UIColor greenColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    _shapeLayer = layer;
}

#pragma mark - UITouch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _currentPoint = [[touches anyObject] locationInView:self];
    [self trackTouchPoint:_currentPoint];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _currentPoint = [[touches anyObject] locationInView:self];
    [self trackTouchPoint:_currentPoint];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endTrackTouch];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endTrackTouch];
}

#pragma mark - DrawPattern
- (CGPathRef)patternLinePath
{
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    for (int i = 0; i < self.selectedNodes.count; i++) {
        
        UIView *node = [self.selectedNodes objectAtIndex:i];
        CGPoint point = node.center;
        if (i == 0) {
            [bezierPath moveToPoint:point];
        } else {
            [bezierPath addLineToPoint:point];
        }
    }
    if (!CGPointEqualToPoint(CGPointZero, _currentPoint)) {
        [bezierPath addLineToPoint:self.currentPoint];
    }
    return bezierPath.CGPath;
}

- (void)drawPatternLine
{
    self.shapeLayer.path = [self patternLinePath];
    [self.layer addSublayer:self.shapeLayer];
}

- (void)trackTouchPoint:(CGPoint)point
{
    for (PatternNodeView *node in self.nodeViews) {
        CGRect rect = CGRectInset(node.frame, node.frame.size.width/3.0, node.frame.size.height/3.0);
        if (![_selectedNodes containsObject:node] && CGRectContainsPoint(rect, point)) {
            node.selected = YES;
            [_selectedNodes addObject:node];
            break;
        }
    }
    [self drawPatternLine];
}

- (void)endTrackTouch
{
    _currentPoint = CGPointZero;
    [self drawPatternLine];
    
    [self transformPatternToPassword];
}

- (void)resetState
{
    _currentPoint = CGPointZero;
    [_selectedNodes makeObjectsPerformSelector:@selector(setSelected:) withObject:@(NO)];
    [_selectedNodes removeAllObjects];
    [self.shapeLayer removeFromSuperlayer];
}

#pragma mark - Password

- (void)transformPatternToPassword
{
    NSString *password = @"";
    for (PatternNodeView *node in _selectedNodes) {
        password = [password stringByAppendingFormat:@"%ld", node.tag];
    }
    [self performSelector:@selector(resetState) withObject:nil afterDelay:0.1];
    if (self.complation) {
        self.complation(password);
    }
}

@end
