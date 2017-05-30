//
//  ItemView.m
//  scrollViewSample
//
//  Created by inkeansong on 2017. 5. 30..
//  Copyright © 2017년 inkeansong. All rights reserved.
//

#import "ItemView.h"
#import "ItemContentView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define IS_IPHONE_5 (SCREEN_HEIGHT == 568.0)
#define IS_IPHONE_6 (SCREEN_HEIGHT == 667.0)
#define IS_IPHONE_6P_OR_LATER (SCREEN_HEIGHT >= 736.0)

#define CELL_WIDTH              270.0f

@interface ItemView() < UIScrollViewDelegate >{
    NSInteger cellWidth;
    NSInteger cellSpace;            // 쿠폰 Space
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *labelCount;

@property (strong, nonatomic) NSMutableArray *pageViewArray;

@property (nonatomic) NSInteger pageIndex;

@end

@implementation ItemView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _labelCount.text = @"0/0";
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *view = [super hitTest:point withEvent:event];
    if (point.y > _scrollView.frame.origin.y && point.y < _scrollView.frame.origin.y + _scrollView.frame.size.height) {
        if (CGRectContainsPoint(_scrollView.frame, point)) {
            return view;
        }
        else {
            return _scrollView;
        }
    }
    return view;
}

- (ItemContentView *)findAndRemoveWithIndex:(NSString *)index
{
    for (ItemContentView *page in _pageViewArray) {
        if ([page.itemIndex isEqualToString:index]) {
            [_pageViewArray removeObject:page];
            return page;
        }
    }
    
    return nil;
}

-(void)setMargins{
    
    if(IS_IPHONE_5){
        cellSpace = 20;
    }
    else if(IS_IPHONE_6){
        cellSpace = 35;
    }
    else if(IS_IPHONE_6P_OR_LATER){
        cellSpace = 50;
    }
    cellWidth = CELL_WIDTH - cellSpace;
}

- (void)loadPages
{
    NSMutableArray *pageViewArray = [NSMutableArray array];
    
    [self setMargins];

    NSInteger count = 5;
    for (NSInteger i = 0; i < count; i++) {
        
        ItemContentView *itemContentView = [self findAndRemoveWithIndex:[@(i) stringValue]];
        if (itemContentView == nil) {
            itemContentView = [[[NSBundle mainBundle] loadNibNamed:@"ItemContentView" owner:nil options:nil] firstObject];
            [_scrollView addSubview:itemContentView];
        }
        
        itemContentView.itemIndex = [@(i) stringValue];
        itemContentView.frame = CGRectMake((i * _scrollView.frame.size.width) + (i * cellSpace), 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
        
        [itemContentView update];
        
        [pageViewArray addObject:itemContentView];
        
    }
    
    for (ItemContentView *page in _pageViewArray) {
        [page didHide];
        [page removeFromSuperview];
    }
    
    self.pageViewArray = pageViewArray;
    
    _scrollView.contentSize = CGSizeMake((_scrollView.frame.size.width * [pageViewArray count]) + (cellSpace * [pageViewArray count]), _scrollView.frame.size.height);
    
    _labelCount.text = [NSString stringWithFormat:@"%d/%d", (int)_pageIndex+1, (int)[_pageViewArray count]];
    
}

- (void)resetViews
{
    for (ItemContentView *page in _pageViewArray) {
        [page didHide];
    }
}

- (void)setPageIndex:(NSInteger)pageIndex
{
    if (_pageIndex != pageIndex) {
        if (_pageIndex < [_pageViewArray count]) {
            ItemContentView *page = _pageViewArray[_pageIndex];
            [page didHide];
        }
        
        
        _pageIndex = pageIndex;
        
        ItemContentView *page = _pageViewArray[_pageIndex];
        [page didShow];
        
        _labelCount.text = [NSString stringWithFormat:@"%d/%d", (int)_pageIndex+1, (int)[_pageViewArray count]];

    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    float pageWidth = cellWidth + (cellSpace * 2); // width + space
    
    float currentOffset = scrollView.contentOffset.x;
    float targetOffset = targetContentOffset->x;
    float newTargetOffset = 0;
    
    if (targetOffset > currentOffset)
        newTargetOffset = ceilf(currentOffset / pageWidth) * pageWidth;
    else
        newTargetOffset = floorf(currentOffset / pageWidth) * pageWidth;
    
    if (newTargetOffset < 0)
        newTargetOffset = 0;
    else if (newTargetOffset > scrollView.contentSize.width)
        newTargetOffset = scrollView.contentSize.width;
    
    targetContentOffset->x = currentOffset;
    [scrollView setContentOffset:CGPointMake(newTargetOffset, 0) animated:YES];
    
    int index = newTargetOffset / pageWidth;
    
    if (index >= 0 && index < [_pageViewArray count]) {
        self.pageIndex = index;
    }
    
}




@end
