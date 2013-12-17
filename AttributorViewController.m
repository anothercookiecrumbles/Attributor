//
//  AttributorViewController.m
//  Attribtuor
//
//  Created by Priyanjana Bengani on 11/12/2013.
//  Copyright (c) 2013 anothercookiecrumbles. All rights reserved.
//

#import "AttributorViewController.h"
#import "AttributorTextStatsViewController.h"

@interface AttributorViewController ()
@property (weak, nonatomic) IBOutlet UITextView *body;
@property (weak, nonatomic) IBOutlet UILabel *headline;
@property (weak, nonatomic) IBOutlet UIButton *outlineButton;

@end

@implementation AttributorViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:self.outlineButton.currentTitle];
    [title setAttributes:@{ NSStrokeWidthAttributeName: @3,
                            NSStrokeColorAttributeName: self.outlineButton.tintColor}
                   range:NSMakeRange(0, title.length)];
    [self.outlineButton setAttributedTitle:title forState:UIControlStateNormal];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self usePreferredFonts];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(preferredFontsChanged:) name:UIContentSizeCategoryDidChangeNotification object:nil];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Analyse Text"]) {
        if ([segue.destinationViewController isKindOfClass:[AttributorTextStatsViewController class]]) {
            AttributorTextStatsViewController* destination = (AttributorTextStatsViewController*) segue.destinationViewController;
            destination.textToAnalyse = self.body.textStorage;
        }
    }
}

- (void) preferredFontsChanged:(NSNotification*) notification {
    [self usePreferredFonts];
}

- (void) usePreferredFonts {
    self.body.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.headline.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
}

- (IBAction)changeBodySelectionToMatchBackgroundOfColor:(UIButton *)sender {
    [self.body.textStorage addAttribute:NSForegroundColorAttributeName
                                  value:sender.backgroundColor
                                  range:self.body.selectedRange];
}

- (IBAction)outlineBodySelection:(UIButton *)sender {
    [self.body.textStorage addAttributes:@{NSStrokeWidthAttributeName : @-3,
                                           NSStrokeColorAttributeName : [UIColor blackColor]}
                                   range:self.body.selectedRange];
}

- (IBAction)unoutlineBodySelection:(UIButton *)sender {
    [self.body.textStorage removeAttribute:NSStrokeWidthAttributeName range:self.body.selectedRange];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
