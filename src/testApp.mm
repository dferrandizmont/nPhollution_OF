#include "testApp.h"

//--------------------------------------------------------------
void testApp::setup(){	
    ofBackground(0);
    
    
    //ofSetOrientation(OF_ORIENTATION_90_RIGHT);
	
    camera = NULL;
    doOnce = false;
    
    imgPos.x=ofGetWidth()/2;
	imgPos.y=ofGetHeight()/2;
	
	photo.loadImage("images/instructions.jpg");
    boto.loadImage("images/boto.jpg");
    
    alphaRand = ofRandom(70,128);
   
  
    //for some reason on the iphone simulator 256 doesn't work - it comes in as 512!
	//so we do 512 - otherwise we crash
	initialBufferSize = 512;
	sampleRate = 44100;
	drawCounter = 0;
	bufferCounter = 0;
    amplitude=0;
	
	buffer = new float[initialBufferSize];
	memset(buffer, 0, initialBufferSize * sizeof(float));
    
	ofSoundStreamSetup(0, 1, this, sampleRate, initialBufferSize, 1);
    
    audioInLeft.resize(512,0); //Declarar la memoria para audioinleft, cambia el tamaño a 256 floats que inicia a 0
    audioInRight.resize(512,0);
    ofSoundStreamStart();
    
}

//--------------------------------------------------------------
void testApp::update(){
    if(camera) {
        if(camera->imageUpdated){
            
            doOnce = true;
            int cameraW = camera->width;
            int cameraH = camera->height;
            unsigned const char * cameraPixels = camera->pixels;
            
            image.setFromPixels(cameraPixels, cameraW, cameraH, OF_IMAGE_COLOR_ALPHA);
            
            imgPos.x = ofGetWidth()/2;
            imgPos.y = ofGetHeight()/2;
            
            camera->close();
            delete camera;
            camera = NULL;
            doOnce = false;
             
        }
    }
    
    //Calling image.update() to apply changes
	image.update();

}

//--------------------------------------------------------------
void testApp::draw(){
    
    if (!camera) {
        photo.draw(0,0);
           }
    
    //multipliquem l'amplitut per 1000 pq te un valor massa baix.
    valorAmplitude = amplitude * 1000;
    ColorAmplitude = amplitude * 100;
    ColorFrequency = frequency / 100;
    
    //Draw two images without color modulation
	//(but using alpha channel by default)
	ofSetColor( 255, 255, 255, 255 );
	image.draw( 0, 0 );
    
    //Mescla de colors
  	
    if (amplitude >= 0.003) {
        
        if (frequency < 1500){
            ofSetColor(ColorFrequency * 18, 150, 150, alphaRand);
        }
        
        if (frequency > 1500 && frequency < 2500){
            ofSetColor(150, ColorFrequency * 18, 150, alphaRand);
        }
        
        if (frequency > 2500){
            ofSetColor(150, 150, ColorFrequency * 18, alphaRand);
        }


   //Editar imatge
    
        
    image.draw(valorAmplitude, 0 );
    
    //ofSetColor(0, ColorFrequency * 20, 0);
    image.draw( valorAmplitude * 5, 0 );
    
    //ofSetColor(ColorAmplitude * ofRandom(15), ofRandom(60), ofRandom(8, 15));
    image.draw( valorAmplitude * 8, 0 );

   // ofSetColor(ofRandom(20,25), ofRandom(10, 15), ColorAmplitude * ofRandom(10));
    image.draw( 0, valorAmplitude * 2 );
   // ofSetColor(ColorAmplitude * ofRandom(4, 10), ofRandom(50), ofRandom(20));
    image.draw( 0, valorAmplitude * 4 );
    
   // ofSetColor(ofRandom(8, 15), ColorAmplitude * ofRandom(10, 15), ofRandom(40));
    image.draw( ofGetHeight(), valorAmplitude * (- 2) );
    //ofSetColor(ofRandom(8, 15), ofRandom(40), ColorAmplitude * ofRandom(2, 10));
    image.draw( ofGetHeight(), valorAmplitude * (- 4) );
    
        //ofSetColor(ColorAmplitude * ofRandom(10), ofRandom(50), ofRandom(60));
    image.draw( valorAmplitude * (- 5), ofGetWidth() );
    
   // ofSetColor(ofRandom(8, 15), ofRandom(50), ColorAmplitude * ofRandom(20));
     image.draw( valorAmplitude * (- 8), ofGetWidth() );

 
    }
}

//--------------------------------------------------------------
void testApp::exit() {
}


//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs & touch){
    
       if(touch.id == 0){
               
                    if(!camera) {
                        camera = new ofxiOSImagePicker();
                        camera->setMaxDimension(MAX(ofGetWidth(), ofGetHeight())); // max the photo taken at the size of the screen.
                        camera->openCamera();
//                      camera->showCameraOverlay();
                    }
        
		imgPos.x=ofGetWidth()/2;
		imgPos.y=ofGetHeight()/2;
	}
  }






//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void testApp::audioIn(float * input, int bufferSize, int nChannels){
   
    //cout << "ampli "<< amplitude << " damia retard" << endl;
   // cout << "frequency "<< frequency << " damia retard" << endl;
        
    if (doOnce == true){
        
        float accum=0;
        int signChange=0;
        for (int i=0; i<bufferSize; i++){
            audioInLeft[i]=input[i*nChannels];
            accum += abs(input[i*nChannels]);
            if (i>0 && (audioInLeft[i-1]*audioInLeft[i])<=0){
                signChange++;
            }
            
            audioInRight[i]=input[i*nChannels+1];
        }
        
        amplitude=accum/512.;
        frequency=signChange/float(512./44100.);
    }

}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs & touch){	
    
}

//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void testApp::touchCancelled(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void testApp::lostFocus() {
    
}

//--------------------------------------------------------------
void testApp::gotFocus() {
    
}

//--------------------------------------------------------------
void testApp::gotMemoryWarning() {
    
}

//--------------------------------------------------------------
void testApp::deviceOrientationChanged(int newOrientation){
    
}
