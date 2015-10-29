//
//  AcronymMeaningCell.h
//  MacysAcronymSearch
//
//  Created by Niyaz Ahmed on 10/30/15.
//  Copyright (c) 2015 Niyaz Ahmed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AcronymMeaningCell : UITableViewCell

+(NSString*)acronymCellIdentifier;
-(void) populateAcronymMeaning :(NSString*)userEnteredText;
@end
