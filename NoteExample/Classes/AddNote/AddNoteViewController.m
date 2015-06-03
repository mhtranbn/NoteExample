//
//  AddNoteViewController.m
//  ExampleNotes
//
//  Created by mhtran on 6/2/15.
//  Copyright (c) 2015 mhtran. All rights reserved.
//

#import "AddNoteViewController.h"
#import "NoteModel.h"
#import "NoteService.h"
@interface AddNoteViewController () <NoteServiceDelegate,UIImagePickerControllerDelegate, UIPickerViewDelegate, UINavigationControllerDelegate>

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
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation AddNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _service = [NoteService new];
    _service.delegate = self;
    _titleTextField.text = _model.title;
    _contentTextView.text = _model.content;
    _imageView.image = [UIImage imageNamed:_model.imageUrl];
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(hideKeyBoard)];
    
    [self.view addGestureRecognizer:tapGesture];
}

-(void)hideKeyBoard {
    [_titleTextField resignFirstResponder];
    [_contentTextView resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setupLocalization];
    [self setupNavigationBar];
}

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

- (void)doneAddNoteAction:(id)sender {
    NSString *titleText = _titleTextField.text;
    NSString *contentText = _contentTextView.text;
    if (_model == nil) {
        NSString *imagePath;
        if (self.imageView.image) {
            imagePath = NSTemporaryDirectory();
            imagePath = [imagePath stringByAppendingPathComponent:[NSUUID UUID].UUIDString];
            NSData *imageData = UIImageJPEGRepresentation(self.imageView.image, 1.0);
            [imageData writeToFile:imagePath atomically:YES];
        }
        NoteModel *model = [[NoteModel alloc] initWithTitle:titleText content:contentText imageUrl:imagePath];
        [_service addNoteWithModel:model];
    }
    else {
        NSLog(@"editting");
        NSString *imagePath;
        imagePath = NSTemporaryDirectory();
        imagePath = [imagePath stringByAppendingPathComponent:[NSUUID UUID].UUIDString];
        NSData *imageData = UIImageJPEGRepresentation(self.imageView.image, 1.0);
        [imageData writeToFile:imagePath atomically:YES];
        NoteModel *model = _model;
        model.title = _titleTextField.text;
        model.content = _contentTextView.text;
        model.imageUrl = imagePath;
        [_service editNoteWithModel:model];
    }

}
- (void)addImageAction:(id)sender {
    NSLog(@"Add image");
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:picker animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    [picker dismissViewControllerAnimated:YES completion:^{
        [self.imageView setImage:image];
    }];   
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
