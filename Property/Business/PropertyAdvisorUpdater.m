 
#import "PropertyAdvisorUpdater.h"
 #import "MKNetworkKit.h"
 #import "ZipArchive.h"
#import "SplashView.h"
 #import "AppDelegate.h"
#import "DbAccssor.h"

#import "PropertyAdvisorStringHelper.h"

@implementation PropertyAdvisorUpdater




///////////////////////////////////////////////////////////////////////////////////////////////
-(id) init
{ 
    
    
    if ((self = [super init]))
    {
        
      
    return self;
}
    return NULL;
}
-(void)GetCurrentLocalVersion
{
    DbAccssor * dbaccessor= [[DbAccssor alloc]init];
    
    localVersion= dbaccessor.GetContentVersion;
    
}

SplashView * CallerController;


int serverVersion;

-(void) ProcessDownload
{
    
    progressAlert.message=@"Decompressing";
    
    
        NSArray *paths = NSSearchPathForDirectoriesInDomains
        (NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [paths objectAtIndex:0];
        NSString *    magazineContentPath = [documentsDir stringByAppendingPathComponent:@"PAMagazine"];
        
           
        [self DecompressFile:destination:magazineContentPath];
        
        NSFileManager * fm =[NSFileManager defaultManager];
        
      
        
        if ([fm fileExistsAtPath:destination]) {
            [fm removeItemAtPath:destination error:nil];
            
        }
        
        
        
        
        
        
        
        
        
    
    
    [progressAlert dismissWithClickedButtonIndex:0 animated:YES];
    
     
    [self ShowUpdatingSplash];
    [self performSelector:@selector(DoUpdate) withObject:Nil afterDelay:1.0];
    
    
    
    
    
    
    
    
    
    
    
    
  
    
}

 -(void)CheckForNewVersion
    {
     
      
        
        MKNetworkEngine* engine = [[MKNetworkEngine alloc]
                                   initWithHostName:ServerBaseUrl customHeaderFields:nil];
        
        
         MKNetworkOperation* op = [engine
                                  operationWithPath:ServerCheckVersionUrl params:Nil
                                  httpMethod:@"GET" ssl:NO];
        
         [op onCompletion:^(MKNetworkOperation *completedOperation) {
            
             
             
             
                     //synchronous code
                     NSString *lversion = completedOperation.readonlyResponse.allHeaderFields[@"LastPAVersion"];
                   serverVersion=[lversion intValue];
        [self GetServerUpdate];

             
             
        } onError:^(NSError *error) {
            [self requestFailed];
        }];
        
         [engine enqueueOperation: op];
        
        
        
        
        
     
    }





UIProgressView *theProgressView;

-(void)FinishRequest
{
    [CallerController FinishLoading];
    
}

-(void)GetServerUpdate
{
    
    
    [self HideUpdatingSplash];
    if (serverVersion==0 || localVersion==serverVersion) {
        
        [self FinishRequest];
        return;
        
    }
    int updateVersion=localVersion+1;
  
    
    
    
    progressAlert = [[UIAlertView alloc] initWithTitle:@"Downloading"  message: @"Please wait..." delegate: self cancelButtonTitle: nil otherButtonTitles: nil];
    theProgressView = [[UIProgressView alloc] initWithFrame:CGRectMake(20.0f, 100.0f, 220.0f, 9.0f)];
    
    [progressAlert addSubview:theProgressView];
    
    
    [theProgressView setProgressViewStyle: UIProgressViewStyleBar];
    
    
    
    
    
    
    
    
    
    
    
   [progressAlert show];
    
   
    
    
    
    
    
    
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    NSString *tempPath = [documentsDir stringByAppendingPathComponent:@"Temp"];
    
    BOOL isDir;
    
    BOOL success;
    
    if (![fileManager fileExistsAtPath: tempPath isDirectory:&isDir])
    {
        success =  [fileManager createDirectoryAtPath:tempPath withIntermediateDirectories:YES attributes:Nil error:&error];
        
        
    }
    
    
    
    
    destination = [tempPath stringByAppendingPathComponent:@"pamagazine.zip"];
  
    NSString  * downloadLink = [NSString stringWithFormat:ServerDownloadUpdateFileUrl, updateVersion];

    MKNetworkEngine* engine = [[MKNetworkEngine alloc]
                               initWithHostName:ServerBaseUrl customHeaderFields:nil];
    
    
    MKNetworkOperation* op = [engine
                              operationWithPath:downloadLink params:Nil
                              httpMethod:@"GET" ssl:NO];
    
    
    
    
    
   
         [op addDownloadStream:[NSOutputStream outputStreamToFileAtPath:destination append:YES]];
    
    
     [op onCompletion:^(MKNetworkOperation *completedOperation) {
        
         [self ProcessDownload];
        
        
         
        
        
    } onError:^(NSError *error) {
        [self requestFailed];
    }];
    
    
    
    [op onDownloadProgressChanged:^(double progress) {
        theProgressView.progress=progress;
    }];
    
    
     [engine enqueueOperation: op];
    
    
    
    

}


int localVersion;
-(void) DoUpdate
{
 	
[self GetCurrentLocalVersion];
[self CheckForNewVersion];
}






NSString * destination ;

UIAlertView *progressAlert;
 


UIAlertView *alertSplash;

-(void)ShowUpdatingSplash{
    alertSplash = [[UIAlertView alloc] init];
    [alertSplash setTitle:@"Checking for new updates"];
    [alertSplash setMessage:@"Please wait."];
    UIActivityIndicatorView * indicator =[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.center=CGPointMake(alertSplash.bounds.size.width+150, alertSplash.bounds.size.height+100);
    [indicator startAnimating];
    [alertSplash addSubview:indicator];
    
    [alertSplash show];
    
    
}






-(void)HideUpdatingSplash{
   
    [alertSplash dismissWithClickedButtonIndex:0 animated:YES];
    alertSplash.hidden=TRUE;
     alertSplash=NULL;
    
}




 -(BOOL) CheckForInitialUpdate:(SplashView *) caller


{
    CallerController=caller;
    
    
    [self ShowUpdatingSplash];
    
    [self performSelector:@selector(DoUpdate) withObject:Nil afterDelay:1.0];
    
    return TRUE;
}










 





    


- (void)requestFailed
{  [progressAlert dismissWithClickedButtonIndex:0 animated:YES];
    
    
    UIAlertView *alert = [[UIAlertView alloc] init];
    [alert setTitle:@"Error"];
    [alert setMessage:@"An error occurred while downloading file, please make sure your iPad is connected to the Internet click and try again."];
    [alert setDelegate:self];
    [alert addButtonWithTitle:@"Try Again"];
    
    [alert setTag:1];
    
    [alert show];
    
    
    
    
}    



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    
    
    
    if (alertView.tag==1) {
        
        if (buttonIndex==0) {
            
            [self ShowUpdatingSplash];
             [self performSelector:@selector(DoUpdate) withObject:Nil afterDelay:1.0];
            
            return;
            
        }
    //    [self FinishCurrentRequest];
        
   //     return;
    } 
    
    
    
    
    if (buttonIndex==0) {
         [self DoUpdate];
        return;
    }
    else
    {
        
     //   [self FinishCurrentRequest];
        
    }
}


-(BOOL) DecompressFile:(NSString*)sourceFilePath:(NSString*)destinationPath
{
    
    @try {
        ZipArchive* za = [[ZipArchive alloc] init];
        if( [za UnzipOpenFile:sourceFilePath] )
        {
            BOOL ret = [za UnzipFileTo:destinationPath overWrite:YES];
            
            [za UnzipCloseFile];
            if( NO==ret )
            {
                return FALSE;
            }
        }
        
        return TRUE;
    }
    @catch (NSException *exception) {
      
        return FALSE;
    }
    @finally {
        
    }
}





















 


 

@end

