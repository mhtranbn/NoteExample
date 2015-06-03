//
//  NoteListTableViewController.m
//  ExampleNotes
//
//  Created by mhtran on 6/1/15.
//  Copyright (c) 2015 mhtran. All rights reserved.
//

#import "NoteListTableViewController.h"
#import "AddNoteViewController.h"
#import "NoteModel.h"
#import "NoteService.h"

@interface NoteListTableViewController () <NoteServiceDelegate>

@property (nonatomic, strong) NoteService *service;
@property (nonatomic, strong) NSArray *noteModels;
- (void)setupNavigationBar;
- (void)addNoteAction:(id)sender;
@end

@implementation NoteListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _service = [NoteService new];
    _service.delegate = self;
    _noteModels = [NSArray new];
    
    [self setupNavigationBar];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [_service loadAllNoteFromCoreData];
}
- (void)setupNavigationBar {
    self.navigationItem.title = @"Note List";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(addNoteAction:)];
}

- (void)addNoteAction:(id)sender {
    AddNoteViewController *addNoteVC = [AddNoteViewController new];
    [self.navigationController pushViewController:addNoteVC animated:YES];
}
- (void)serviceBeginGetNote:(NoteService *)service {
    NSLog(@"Service begin get note, show loading...");
}
- (void)serviceDidCompleteGetNote:(NoteService *)service withModels:(NSArray *)models {
    NSLog(@"Service complete get note, reload tableview to get new data");
    _noteModels = models;
    [self.tableView reloadData];
}



    
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return _noteModels.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse"];
    NoteModel *model = _noteModels[indexPath.row];
    cell.textLabel.text = model.title;
    cell.detailTextLabel.text = model.dataCreatedString;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AddNoteViewController *addNoteVC = [AddNoteViewController new];
    addNoteVC.model = _noteModels[indexPath.row];
    [self.navigationController pushViewController:addNoteVC animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if( editingStyle == UITableViewCellEditingStyleDelete) {
        NoteModel *noteRemove;
        noteRemove = _noteModels[indexPath.row];
        NSMutableArray *noteModelNew;
        noteModelNew = _noteModels.mutableCopy;
        [noteModelNew removeObjectAtIndex:indexPath.row];
        _noteModels = noteModelNew.copy;
        [_service deleteNoteWithModel:noteRemove];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
