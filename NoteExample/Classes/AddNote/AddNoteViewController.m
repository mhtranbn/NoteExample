//
//  AddNoteViewController.m
//  NoteExample
//
//  Created by mhtran on 6/1/15.
//  Copyright (c) 2015 mhtran. All rights reserved.
//

#import "AddNoteViewController.h"
#import "NoteModel.h"
#import "NoteService.h"

@interface AddNoteViewController () <NoteServiceDelegate>

@property (nonatomic, weak) IBOutlet UILabel *titleName;
@property (nonatomic, weak) IBOutlet UITextField *titleTextField;

@property (nonatomic, weak) IBOutlet UILabel *contentName;
@property (nonatomic, weak) IBOutlet UITextView *contentTextView;

@property (nonatomic, weak) IBOutlet UIButton *addImageButton;
- (IBAction)addImageAction:(id)sender;

- (void)setupLocalization;
- (void)setupNavigationBar;

- (void)doneAddNoteAction:(id)sender;

@property (nonatomic, strong) NoteService *service;

@end

@implementation AddNoteViewController

#pragma mark - View delegates
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _service = [NoteService new];
    _service.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setupLocalization];
    [self setupNavigationBar];
}

#pragma mark - Setups
- (void)setupLocalization {
    _titleName.text = @"Title:";
    _contentName.text = @"Content:";
}

- (void)setupNavigationBar {
    self.navigationItem.title = @"Add Note";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                           target:self
                                                                                           action:@selector(doneAddNoteAction:)];
}

#pragma mark - Actions
- (void)doneAddNoteAction:(id)sender {
    // Save data to core data
    // Get data from view to model
    NSString *titleText = _titleTextField.text;
    NSString *contentText = _contentTextView.text;
    // Pending for image
    
    // Check model is createNew or Editting
    if (_model == nil) {
        NoteModel *model = [[NoteModel alloc] initWithTitle:titleText content:contentText imageURL:nil];
        [_service addNoteWithModel:model];
    }
    else {
        NSLog(@"editting");
        NoteModel *model = _model;
        model.title = _titleTextField.text;
        model.content = _contentTextView.text;
        [_service updateNoteWithModel:model];
    }
    

}

- (void)addImageAction:(id)sender {
    NSLog(@"Add image");
}

#pragma mark - NoteServiceDelegate
- (void)serviceBeginSaveNote:(NoteService *)service {
    // do sthing
    NSLog(@"Start save note, show loading...");
}

- (void)serviceDidCompleteSaveNote:(NoteService *)service {
    // do sthing
    NSLog(@"Stop loading...");
    // Back to list view
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)serviceBeginEditNote:(NoteService *)service {
    NSLog(@"Start edit note, show loading...");
}

- (void)serviceDidCompleteEdit:(NoteService *)service withModels:(NSArray *)models {
    // do sthing
    NSLog(@"Stop loading...");
    // Back to list view
    [self.navigationController popViewControllerAnimated:YES];
}

@end
