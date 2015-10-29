//
//  ViewController.m
//  MacysAcronymSearch
//
//  Created by Niyaz Ahmed on 10/29/15.
//  Copyright (c) 2015 Niyaz Ahmed. All rights reserved.
//

#import "AcronymSearchViewController.h"
#import "AcronymMeaningCell.h"
#import "AcronymSearchService.h"
#import "AcronymMeanings.h"
#import "AcronymLongForm.h"
#import "NSString+MacysAdditions.h"
#import "MBProgressHUD.h"

@interface AcronymSearchViewController ()<UISearchBarDelegate, UISearchDisplayDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property(nonatomic,strong) AcronymSearchService* acronymSearchService;
@property(nonatomic,strong) NSArray* searchResults;
@property(nonatomic,strong) AcronymSearchSuccessCallback acronymsearchSuccess;
@property(nonatomic,strong) AcronymSearchFailureCallback acronymsearchFailure;
@end

@implementation AcronymSearchViewController


-(void)dealloc {
    self.tableView.dataSource = nil;
    self.searchBar.delegate = self;
}

#pragma mark Life Cycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBar.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
    self.tableView.allowsSelection = NO;
}


#pragma mark - private methods
-(AcronymSearchSuccessCallback)acronymsearchSuccess {
    __weak AcronymSearchViewController* me = self;
    return ^(AcronymMeanings *response) {
        AcronymSearchViewController* meRef = me;
        [meRef updateSearchResults:response];
    };
    
}

-(AcronymSearchFailureCallback) acronymsearchFailure {
    __weak AcronymSearchViewController* me = self;
    return ^(NSError* error) {
        AcronymSearchViewController* meRef = me;
        [meRef presentOKCancelAlert:@"Network Connection Failure"
                       alertMessage:@"Please Try Again!"
                       cancelAction:nil
                           okAction:^{
                               [meRef.searchDisplayController.searchResultsTableView reloadData];
                           }];
        [MBProgressHUD hideHUDForView:meRef.view animated:YES];
    };
}

-(void) updateSearchResults:(AcronymMeanings*) meanings {
    self.searchResults = meanings.longForms;
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [self.searchDisplayController.searchResultsTableView reloadData];
}

- (void)presentOKCancelAlert:(NSString *)alertTitle
                alertMessage:(NSString *)alertMessage
                cancelAction:(void (^)(void))cancelAction
                    okAction:(void (^)(void))okAction {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:alertTitle
                                                                             message:alertMessage
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action) {
                                                          if (cancelAction) {
                                                              cancelAction();
                                                          }
                                                      }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          if (okAction) {
                                                              okAction();
                                                          }
                                                      }]];
    [self presentViewController:alertController animated:YES completion:nil];
}



#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if([self.searchResults count] !=0) {
        return [self.searchResults count];
    } else {
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AcronymMeaningCell* cell = [self.tableView
 dequeueReusableCellWithIdentifier:[AcronymMeaningCell acronymCellIdentifier]];
    if(cell == nil) {
        cell = [[AcronymMeaningCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:[AcronymMeaningCell acronymCellIdentifier]];
    }
    
    if(tableView ==  self.searchDisplayController.searchResultsTableView) {
        if([self.searchResults count]==0) {
            [cell populateAcronymMeaning:@"No Results Found"];
        } else {
            AcronymLongForm* longForm = (AcronymLongForm*)self.searchResults[indexPath.row];
            [cell populateAcronymMeaning:longForm.lf];
        }
    } else {
        [cell populateAcronymMeaning:@"Type Acronym/Initialism to find its meaning"];

    }
    
    return cell;

}

#pragma mark Content Filtering
-(void)searchAcronymMeaning:(NSString*)searchText {
    if([self.searchBar.text isPresent]) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
     [self.acronymSearchService fetchAcronymMeanings:self.searchBar.text onSuccess:self.acronymsearchSuccess onFailure:self.acronymsearchFailure];
    }
}

#pragma mark - UISearchDisplayDelegateDelegate
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    return NO;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    return NO;
}


-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (![searchText isPresent])
    {
        [self.searchBar performSelector:@selector(resignFirstResponder) withObject:nil afterDelay:0];
    } else {
        [self searchAcronymMeaning:searchText];
    }
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

-(AcronymSearchService*)acronymSearchService{
    if(!_acronymSearchService) {
        _acronymSearchService = [AcronymSearchService new];
    }
    return _acronymSearchService;
}



@end
