#pragma once

#include "ofMain.h"
#include "ofxiOS.h"
#include "ofxiOSExtras.h"

class testApp : public ofxiOSApp{
	
    public:
        void setup();
        void update();
        void draw();
        void exit();
	
        void touchDown(ofTouchEventArgs & touch);
        void touchMoved(ofTouchEventArgs & touch);
        void touchUp(ofTouchEventArgs & touch);
        void touchDoubleTap(ofTouchEventArgs & touch);
        void touchCancelled(ofTouchEventArgs & touch);
	
        void lostFocus();
        void gotFocus();
        void gotMemoryWarning();
        void deviceOrientationChanged(int newOrientation);
        void audioIn(float * input, int bufferSize, int nChannels);
    
        int	initialBufferSize;
        int	sampleRate;
        float * buffer;
    
	
        ofxiOSImagePicker * camera;
        ofImage	photo;
        ofPoint imgPos;
        ofImage image;
        ofImage boto;
    
    
        //SOUND
    
        vector<float>audioInLeft;
        vector<float>audioInRight;
    
        float amplitude;
        float frequency;
	
        ofSoundPlayer sound;
    
        vector <float> left;
        vector <float> right;
        vector <float> volHistory;
    
        int 	bufferCounter;
        int 	drawCounter;
    
        float smoothedVol;
        float scaledVol;
    
        ofSoundStream soundStream;
    
        bool doOnce; 
    
        float valorAmplitude;
        float ColorAmplitude;
        float ColorFrequency;
    
    
        float alphaRand;
    
        };

