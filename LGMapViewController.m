//
//  LGMapViewController.m
//  wanxiangerweima
//
//  Created by LG on 13-4-7.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "LGMapViewController.h"
#import "LJLCodeCreateViewController.h"
#import "SBJSON.h"
#import <CoreLocation/CoreLocation.h>
#import "ASIHTTPRequest.h"

@implementation LGMapViewController

@synthesize mapView         = _mapView;
@synthesize searchView      = _searchView;
@synthesize searchTextField = _searchTextField;
@synthesize currentlocation = _currentlocation;
//@synthesize reverseGeocoder = _reverseGeocoder;
@synthesize address = _address,latStr = _latStr,lngStr = _lngStr;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.searchView.alpha = 0;
	
	self.mapView.mapType=MKMapTypeStandard;
    self.mapView.delegate=self;
    self.mapView.showsUserLocation=YES;
}

#pragma mark -
#pragma mark MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
	static NSString *annotationIdentifier = @"AnnotationIdentifier";
	
	MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
	if (!annotationView) 
	{
		annotationView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationIdentifier] autorelease];
	}
	
	if (annotation == _mapView.userLocation) 
	{
		//self.reverseGeocoder =[[MKReverseGeocoder alloc] initWithCoordinate:_mapView.userLocation.coordinate];
//        self.myGeocoder = [[CLGeocoder alloc]init];
//		
//		//_reverseGeocoder.delegate = self;
//		
//		//[_reverseGeocoder start];
//        [self.myGeocoder ]
		//用户位置大头针标题
		_mapView.userLocation.title = @"我的位置";
		annotationView.animatesDrop = YES;
		annotationView.canShowCallout = YES;
		
		annotationView.pinColor = MKPinAnnotationColorGreen;
		UIButton *btn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
		annotationView.rightCalloutAccessoryView = btn;		
	}
	else {
		annotationView.canShowCallout = YES;
		
		annotationView.image = [UIImage imageNamed:@"arrest.png"];
		
		CGRect endFrame = annotationView.frame;
		annotationView.frame = CGRectMake(endFrame.origin.x, endFrame.origin.y - 230.0, endFrame.size.width, endFrame.size.height);
		
		[UIView beginAnimations:@"drop" context:nil];
		[UIView setAnimationDuration:0.25];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[annotationView setFrame:endFrame];
		[UIView commitAnimations];
	}

	
	return annotationView;
}


//- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error{  
//    NSLog(@"MKReverseGeocoder has failed.");  
//}  
//- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark{  
//	NSLog(@"%@,%@,%@",placemark.countryCode,placemark.locality,placemark.postalCode);
//	//placemark.country 国家  placemark.subAdministrativeArea 县 placemark.administrativeArea 州（省）
//	//placemark.countryCode 国家简称 placemark.locality城市（市） placemark.postalCode 邮编 placemark.thoroughfare 大道，路 placemark.subThoroughfare 大道编号
//    NSLog(@"当前地理信息为：%@,%@",placemark.country,placemark.subAdministrativeArea);
//	
//	self.address = placemark.thoroughfare;
//	[_reverseGeocoder cancel];
//}  


//当黑色视图右边的内容被点击的时候，调用这个方法
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
	[self showAddressMessage];
}
- (void) showAddressMessage
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"位置信息" message:@"\n\n\n\n\n" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	alert.frame = CGRectMake(0, 0, 100, 100);
	UILabel *lat = [[UILabel alloc] initWithFrame:CGRectMake(20, 50,140,30)];
	lat.text = [NSString stringWithFormat:@"纬度: %f",_mapView.userLocation.coordinate.latitude];
	lat.backgroundColor = [UIColor clearColor];
	lat.textColor = [UIColor whiteColor];
	[alert addSubview:lat];
	[lat release];
	UILabel *lng = [[UILabel alloc] initWithFrame:CGRectMake(20, 85, 140, 30)];
	lng.text = [NSString stringWithFormat:@"经度: %f",_mapView.userLocation.coordinate.longitude];
	lng.backgroundColor = [UIColor clearColor];
	lng.textColor = [UIColor whiteColor];
	[alert addSubview:lng];
	[lng release];
	UILabel *address = [[UILabel alloc] initWithFrame:CGRectMake(20, 120, 140, 30)];
	address.text = self.address;
	address.backgroundColor = [UIColor clearColor];
	address.textColor = [UIColor whiteColor];
	[alert addSubview:address];
	[address release];
	[alert show];
	[alert release];	
}

-(void) mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    self.currentlocation = userLocation;
    NSString *lat=[[NSString alloc] initWithFormat:@"%f",userLocation.coordinate.latitude];
    NSString *lng=[[NSString alloc] initWithFormat:@"%f",userLocation.coordinate.longitude];
	self.latStr = lat;
	self.lngStr = lng;
	NSLog(@"%@,%@",lat,lng);
    MKCoordinateSpan span;
    MKCoordinateRegion region;
	
    span.latitudeDelta=0.05;
    span.longitudeDelta=0.05;
    region.span=span;
    region.center=[userLocation coordinate];
	[self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
	
}

- (IBAction)dingwei
{
    MKCoordinateSpan span;
    MKCoordinateRegion region;

    span.latitudeDelta=0.05;
    span.longitudeDelta=0.05;
    region.span=span;
    region.center=[self.currentlocation coordinate];	
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.5];
	self.searchView.alpha = 0;
	[UIView commitAnimations];		
}

- (IBAction) Search
{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.5];
	self.searchView.alpha = 1;
	[UIView commitAnimations];
}

- (IBAction) startSearch
{
	[self.searchTextField resignFirstResponder];
	//输入空格无效
	NSString *str = [self.searchTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	

	if (![str isEqualToString:@""]) 
	{
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.5];
		self.searchView.alpha = 0;
		[UIView commitAnimations];	
		
		//  ios5（包括ios5）以后 用注释掉的方法
		CLGeocoder * geocode = [[CLGeocoder alloc]init];
        [geocode geocodeAddressString:str completionHandler:^(NSArray *placemarks, NSError *error) {
					CLPlacemark * mark = [placemarks objectAtIndex:0];
					MKPointAnnotation * an = [[MKPointAnnotation alloc]init];
					an.coordinate = mark.location.coordinate;
					[an setTitle:self.searchTextField.text];
                    if (_lastPoint != nil)
                    {
					  [self.mapView removeAnnotation:_lastPoint];
                    }
                    [self.mapView  addAnnotation:an];
            _lastPoint  = an;
            
            MKCoordinateSpan span;
             MKCoordinateRegion region;

             span.latitudeDelta=0.05;
             span.longitudeDelta=0.05;
             region.span=span;
             region.center = an.coordinate;
             [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];

					[geocode autorelease];
            }
		 ];
		//*/
		
//		NSString *seachStr = [self.searchTextField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//		ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[ NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?address=%@&sensor=true",seachStr]]];
//		
//		[request setCompletionBlock:^
//		 {
//			// NSLog(@"%@",request.responseString);
//
//			 NSString *Search = request.responseString;
//			 //NSLog(@"%@",Search);
//			 SBJSON *json = [[SBJSON alloc] init];
//			 NSDictionary *dic = [json objectWithString:Search error:nil];
//			 NSString *ok = [dic objectForKey:@"status"];
//			 NSLog(@"%@",ok);
//			 
//			 if ([ok isEqualToString:@"OK"]) 
//			 {
//				 NSArray *array = [dic objectForKey:@"results"];
//				 NSDictionary *weizhi = [array objectAtIndex:0];
//				 NSDictionary *jingweidu =[weizhi objectForKey:@"geometry"];
//				 NSDictionary *location = [jingweidu objectForKey:@"location"];
//				 NSString *lat = [location objectForKey:@"lat"];
//				 NSString *lng = [location objectForKey:@"lng"];
//				 
//				 self.latStr = lat;
//				 self.lngStr = lng;
//				 
//				 CLLocationCoordinate2D coordinate;
//				 coordinate.latitude = [lat floatValue];
//				 coordinate.longitude = [lng floatValue];
//			
//				 MKPointAnnotation *ann = [[MKPointAnnotation alloc] init];
//				 ann.coordinate = coordinate;
//				 [ann setTitle:self.searchTextField.text];
//				 if (_lastPoint != nil) 
//				 {
//					 [self.mapView removeAnnotation:_lastPoint];
//				 }
//				
//				 [self.mapView addAnnotation:ann];
//				 _lastPoint = ann;
//				 
//				 MKCoordinateSpan span;
//				 MKCoordinateRegion region;
//				 
//				 span.latitudeDelta=0.05;
//				 span.longitudeDelta=0.05;
//				 region.span=span;
//				 region.center = coordinate;	
//				 [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
//			 }
			 
		// }];
//		[request setFailedBlock:^
//		 {
//			 NSString *error = [NSString stringWithFormat:@"%@",request.error];
//			 //NSLog(@"%@",error);
//			 if( ([error rangeOfString:@"Code=1"].length) != 0 )
//			 {
//				 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"搜索失败请检查\n搜索关键字并重新搜索" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//				 [alertView show];
//				 [alertView release];
//			 }
//			 else 
//			 {
//				 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请求超时\n检查网络并重新搜索" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//				 [alertView show];
//				 [alertView release];
//			 }
//		 }];
//		
//		request.timeOutSeconds = TIMEOUTSECONDS; = 20;
//		[request startAsynchronous];
				
	}
}

- (IBAction) back
{
	[self.navigationController popViewControllerAnimated:YES];
}
- (IBAction) keyboard
{
	[self.searchTextField resignFirstResponder];
	[self startSearch];
}

- (IBAction) setting
{
	LJLCodeCreateViewController * codeCreateViewController = [[LJLCodeCreateViewController alloc] init];
    codeCreateViewController.urlString = [NSString stringWithFormat:@"%@/API/QR/QRmi.aspx?Type=8&zuobiao=%@,%@",SERVER_URL,self.latStr,self.lngStr];
    
	codeCreateViewController.contentStr  = [NSString stringWithFormat:@"%@,%@",self.latStr,self.lngStr];
	codeCreateViewController.codeType = 8;        
	[self.navigationController pushViewController:codeCreateViewController animated:YES];
	[codeCreateViewController release];
}


- (void)dealloc
{
	[_mapView release];
	[_searchView release];
	[_searchTextField release];
	[_currentlocation release];
	//[_reverseGeocoder release];
	[_address release];
	[_latStr release];
	[_lngStr release];
    [super dealloc];
}

@end
