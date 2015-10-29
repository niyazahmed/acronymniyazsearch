//
//  AcronymMeaningCell.m
//  MacysAcronymSearch
//
//  Created by Niyaz Ahmed on 10/30/15.
//  Copyright (c) 2015 Niyaz Ahmed. All rights reserved.
//

#import "AcronymMeaningCell.h"

#define acronymMeaningCell @"acronymSearch"

@implementation AcronymMeaningCell

+(NSString*)acronymCellIdentifier {
    return acronymMeaningCell;
}

-(void) populateAcronymMeaning :(NSString*)userEnteredText {
    self.textLabel.numberOfLines = 0;
    self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.textLabel.text = userEnteredText;
}
@end
