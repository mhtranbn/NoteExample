//
//  NoteListTableViewController.m
//  NoteExample
//
//  Created by mhtran on 6/1/15.
//  Copyright (c) 2015 mhtran. All rights reserved.
//

#import "NoteListTableViewController.h"
#import "AddNoteViewController.h"
#import "NoteService.h"
#import "NoteModel.h"

@interface NoteListTableViewController () <NoteServiceDelegate>

@property (nonatomic, strong) NoteService *service;
@property (nonatomic, strong) NSArray *noteModels;

- (void)setupNavigationBar;
- (void)addNoteAction:(id)sender;

@end

@implementation NoteListTableViewController

#pragma mark - View delegates
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

#pragma mark - Setups
- (void)setupNavigationBar {
    self.navigationItem.title = @"Note List";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(addNoteAction:)];
}

#pragma mark - Actions
- (void)addNoteAction:(id)sender {
    AddNoteViewController *addNoteVC = [AddNoteViewController new];
    [self.navigationController pushViewController:addNoteVC animated:YES];
}



#pragma mark - NoteService delegates
- (void)serviceBeginGetNote:(NoteService *)service {
    NSLog(@"Service begin get note, show loading...");
}

- (void)serviceDidCompleteGetNote:(NoteService *)service withModels:(NSArray *)models {
    NSLog(@"Service complete get note, reload tableview to get new data");
    _noteModels = models;
    [self.tableView reloadData];
}

- (void)serviceBeginEditNote:(NoteService *)service {
    NSLog(@"Service begin edit note, show loadding...");
}

- (void)serviceDidCompleteEdit:(NoteService *)service withModels:(NSArray *)models{
    _noteModels = models;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _noteModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse"];
    
    NoteModel *model = _noteModels[indexPath.row];
    
    cell.textLabel.text = model.title;
    cell.detailTextLabel.text = model.dateCreatedString;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    NSInteger row = [indexPath row];
    AddNoteViewController *addNoteVC = [AddNoteViewController new];
    addNoteVC.model = _noteModels[indexPath.row];
    [self.navigationController pushViewController:addNoteVC animated:YES];
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    [_noteModels removeObjectAtIndex:indexPath.row];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}


@end
