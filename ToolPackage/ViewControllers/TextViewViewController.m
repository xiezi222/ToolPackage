//
//  TextViewViewController.m
//  ToolPackage
//
//  Created by xing on 2020/6/29.
//  Copyright © 2020 xing. All rights reserved.
//

#import "TextViewViewController.h"
#import "TextView.h"

@interface TextViewViewController ()<UITextViewDelegate>

@property (nonatomic, strong) TextView *textView;
@property (nonatomic, strong) NSTextContainer *textContainer;
@property (nonatomic, strong) NSLayoutManager *layoutManager;
@property (nonatomic, strong) NSTextStorage *textStorage;


@end

@implementation TextViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor greenColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    scrollView.contentSize = CGSizeMake(self.view.width, self.view.height * 2);
//    [self.view addSubview:scrollView];
    

    CGRect rect = CGRectMake(0, 100, CGRectGetWidth(self.view.bounds), 200);
    NSString *text = @"我是中文 wo shi A~Z 我是🤗🤗🤗🤗 莹北__㤫";
    
    _textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake(CGRectGetWidth(rect), 10000)];
    _textContainer.lineFragmentPadding = 100;
    _textContainer.maximumNumberOfLines = 4;
    _textContainer.widthTracksTextView = YES;
    
    _layoutManager = [[NSLayoutManager alloc] init];
    _layoutManager.allowsNonContiguousLayout = NO;// 据说是为了解决iOS7 输入时textview内容跳动的系统bug
    [_layoutManager addTextContainer:_textContainer];
    
    _textStorage = [[NSTextStorage alloc] initWithString:text];
    [_textStorage addLayoutManager:_layoutManager];
    
    _textView = [[TextView alloc] initWithFrame:rect textContainer:_textContainer];
    _textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _textView.textColor = [UIColor greenColor];
    _textView.delegate = self;
    _textView.maxLengthOfText = 34;
    [self.view addSubview:_textView];
    
    _textView.placeholder = [[NSAttributedString alloc] initWithString:@"qeqeqeq"
                                                            attributes:@{NSForegroundColorAttributeName : [UIColor redColor],
                                                                         NSFontAttributeName: [UIFont systemFontOfSize:17]}];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textView resignFirstResponder];
}

//- (NSArray *)getSeparatedLinesWithWidth:(CGFloat)width
//{
//    NSString *text = self.textStorage.string;
//    if (!text || text.length<1) {
//        return 0;
//    }
//    UIFont *font = self.textView.font;
//    CTFontRef myFont = CTFontCreateWithName((__bridge CFStringRef)([font fontName]), [font pointSize], NULL);
//    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
//    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)myFont range:NSMakeRange(0, attStr.length)];
//    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attStr);
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathAddRect(path, NULL, CGRectMake(0,0,width,CGFLOAT_MAX));
//    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
//    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
//    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
//    for (id line in lines) {
//        CTLineRef lineRef = (__bridge CTLineRef )line;
//        CFRange lineRange = CTLineGetStringRange(lineRef);
//        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
//        NSString *lineString = [text substringWithRange:range];
//        [linesArray addObject:lineString];
//
//    }
//    return linesArray;
//
//}

#pragma mark - UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    
}

//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
//    return YES;
//}
- (void)textViewDidChange:(UITextView *)textView {
    
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    
}

@end
