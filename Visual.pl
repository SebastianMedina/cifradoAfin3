#INCLUDES
use strict;
use warnings;
use Tk; 

#GLOBAL VARS
#MAIN WINDOW
my $MainWdw = MainWindow->new(-title => 'MIKE');
#GLOBAL WINDOWS
my $logWdw = undef;
$MainWdw -> bind ( '<Configure>' => sub{    
				my $xe = $MainWdw -> XEvent;  
				$MainWdw -> maxsize( $xe -> w, $xe -> h ); 
				$MainWdw -> minsize( $xe -> w, $xe -> h );});
				
# 'X' BUTTON 
$MainWdw -> protocol ('WM_DELETE_WINDOW', sub { ExitFunction(); }); 

#TEXT AREA
my $MainTxtArea = $MainWdw -> Frame();
my $MainTxt = $MainTxtArea -> Scrolled            ( "Text",     
															-scrollbars => 
									'oe',
									
															-width => 80,
															-height => 20,
															-background
	=> 'white',
															-foreground 
	=> 'black'
												 );
#BUTTON
my $btn = $MainWdw -> Button (-text => 'Go!', -command => sub {
					#Funcion ACA
		}
	); 
	#GEOMETRY
	$MainTxtArea -> grid(-row => 1,-column => 1,-columnspan => 3);
	$MainTxt -> grid(-row => 1,-column => 1,-columnspan => 3);
	$TranslateTxt -> grid(-row => 2,-column => 1,-columnspan => 3);
	$btn -> grid (-row => 3, -column => 1, -columnspan => 1, -sticky => 'e'); 
	MainLoop(); sub ExitFunction{      
		exit;
		}; 										 
	