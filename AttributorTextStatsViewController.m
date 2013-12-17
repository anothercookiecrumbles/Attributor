//
//  AttributorTextStatsViewController.m
//  Attributor
//
//  Created by Priyanjana Bengani on 16/12/2013.
//  Copyright (c) 2013 anothercookiecrumbles. All rights reserved.
//

#import "AttributorTextStatsViewController.h"

@interface AttributorTextStatsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *colourfulCharactersLabel;
@property (weak, nonatomic) IBOutlet UILabel *outlinedCharactersLabel;
@end

@implementation AttributorTextStatsViewController

// Just creating this in order to test the view-controller, independent of the main root controller. 
//- (void) viewDidLoad {
//    [super viewDidLoad];
//    self.textToAnalyse = [[NSAttributedString alloc] initWithString:@"test" attributes:@{ NSForegroundColorAttributeName: [UIColor greenColor],
//                                                                                          NSStrokeWidthAttributeName: @-3}];
//}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void) setTextToAnalyse:(NSAttributedString *)textToAnalyse {
    _textToAnalyse = textToAnalyse;
    if (self.view.window) { // Essentially, if outlets are set/view is visible (on-screen), it has to update the UI. Else, viewWillAppear will handle it.
        [self updateUI];
    }
}

- (NSAttributedString*) charactersWithAttributes:(NSString*)attributeName {
    NSMutableAttributedString* characters = [[NSMutableAttributedString alloc] init];
    int index = 0;
    while (index < [self.textToAnalyse length]) {
        NSRange range;
        id value = [self.textToAnalyse attribute:attributeName
                                         atIndex:index
                                  effectiveRange:&range];
        if (value) {
            [characters appendAttributedString:[self.textToAnalyse attributedSubstringFromRange:range]];
            index = range.location + range.length;
        }
        else {
            index++;
        }
    }
    return characters;
}

- (void) updateUI {
    self.colourfulCharactersLabel.text = [NSString stringWithFormat:@"%d colourful characters!", [[self charactersWithAttributes:NSForegroundColorAttributeName] length]];
    self.outlinedCharactersLabel.text = [NSString stringWithFormat:@"%d outlined characters!", [[self charactersWithAttributes:NSStrokeWidthAttributeName] length]];
}
@end
