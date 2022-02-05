% Samuel C. Perez
% Program performs DCT based image compression to reduce file size of input
% image
function varargout = DCT_Compress(varargin)
% SIGDISC_PROJECT MATLAB code for DCT_Compress.fig
%      SIGDISC_PROJECT, by itself, creates a new SIGDISC_PROJECT or raises the existing
%      singleton*.
%
%      H = SIGDISC_PROJECT returns the handle to a new SIGDISC_PROJECT or the handle to
%      the existing singleton*.
%
%      SIGDISC_PROJECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIGDISC_PROJECT.M with the given input arguments.
%
%      SIGDISC_PROJECT('Property','Value',...) creates a new SIGDISC_PROJECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DCT_Compress_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DCT_Compress_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DCT_Compress

% Last Modified by GUIDE v2.5 01-May-2020 16:58:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DCT_Compress_OpeningFcn, ...
                   'gui_OutputFcn',  @DCT_Compress_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before DCT_Compress is made visible.
function DCT_Compress_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DCT_Compress (see VARARGIN)

% Choose default command line output for DCT_Compress
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DCT_Compress wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DCT_Compress_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global file_name; % declare file name as a global variable
file_name=uigetfile({'*.bmp;*.jpg;*.png;*.tiff;';'*.*'},'Select your Image');
fileinfo = dir(file_name);



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
w = waitbar(0,'Getting ready to compress, please standby')
global file_name;
if(~ischar(file_name)) % Checks if image file is valid or not
   errordlg('Kindly select a VALID image format (JPG, PNG, TIFF, BMP)');
else
    inputImage = imread(file_name); % If valid, proceed with compression
    s = dir(file_name);         
    SIZE = s.bytes;  % obtain size of image    
    waitbar(0.10,w,'File name is valid, proceeding with DCT, hang tight!')
    pause(2)

% First Layer
I = inputImage(:,:,1);
%imwrite(inputImage,'OriginalImage.jpg'); % Writes image file onto folder of program
I = im2double(I);
waitbar(0.15,w,'Applying DCT to the first layer')
T = dctmtx(8);
waitbar(0.20,w,'Block processing the first layer...')
B = blkproc(I,[8 8],'P1*x*P2',T,T');
maskMatrix = [1   1   1   1   0   0   0   0
        1   1   1   0   0   0   0   0
        1   1   0   0   0   0   0   0
        1   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0];
B2 = blkproc(B,[8 8],'P1.*x',maskMatrix);
I2 = blkproc(B2,[8 8],'P1*x*P2',T',T); % Inverse DCT
waitbar(0.30,w,'Alright! Finished Processing for first layer')
pause(2)

% Second Layer
I = inputImage(:,:,2);
I = im2double(I);
waitbar(0.40,w,'Applying DCT to second layer')
T = dctmtx(8);
waitbar(0.50,w,'Block processing the second layer...')
B = blkproc(I,[8 8],'P1*x*P2',T,T');
maskMatrix = [1   1   1   1   0   0   0   0
        1   1   1   0   0   0   0   0
        1   1   0   0   0   0   0   0
        1   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0];
B2 = blkproc(B,[8 8],'P1.*x',maskMatrix);
I3 = blkproc(B2,[8 8],'P1*x*P2',T',T); % Inverse DCT
waitbar(0.55,w,'Alright! Finished Processing for second layer')
pause(2)

% Third Layer
I = inputImage(:,:,3);
I = im2double(I);
waitbar(0.60,w,'Applying DCT to third layer')
T = dctmtx(8);
waitbar(0.70,w,'Block processing the third layer...')
B = blkproc(I,[8 8],'P1*x*P2',T,T');
maskMatrix = [1   1   1   1   0   0   0   0
        1   1   1   0   0   0   0   0
        1   1   0   0   0   0   0   0
        1   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0];
B2 = blkproc(B,[8 8],'P1.*x',maskMatrix);
I4 = blkproc(B2,[8 8],'P1*x*P2',T',T);% Inverse DCT
waitbar(0.80,w,'Alright! Finished Processing for third layer')
pause(2)

% Concatenate layers
waitbar(0.90,w,'Almost there! Superimposing the layers')
L(:,:,:) = cat(3,I2, I3, I4);
pause(2)
waitbar(0.95,w,'Success! Writing image file onto root directory')
imwrite(L,'Output.jpg'); % Writes image file onto folder of program
pause(2)
fileinfo1 = dir('Output.jpg');
SIZE2 = fileinfo1.bytes; % obtain size of image


% SNR and Compression Ratio Calculations
clc

% For Compressed Image
sourceImage=inputImage;
sourceImage=double(sourceImage(:));
ima1=max(sourceImage(:));
imi1=min(sourceImage(:));
ims1=std(sourceImage(:));
snrSource=10*log((ima1-imi1)./ims1);

outputImage=imread('Output.jpg');
outputImage=double(outputImage(:));
ima=max(outputImage(:));
imi=min(outputImage(:));
ims=std(outputImage(:));
snrOutput=10*log((ima-imi)./ims);
perror = 100*(abs(snrSource-snrOutput))/snrSource;

fileID = fopen('Image_Details.txt','w'); % Write to Text File
fprintf(fileID,'Source Image SNR: %.2f',10*log((ima1-imi1)./ims1));
fprintf(fileID,'\nCompressed Image SNR: %.2f',10*log((ima-imi)./ims));
fprintf(fileID,'\nPercent Error: %.2f %%', perror);
fprintf(fileID,'\nCompression Ratio: %.2f %%',(SIZE/SIZE2)*100);

waitbar(1,w,'Done! Check the folder for your compressed image')
pause(5)
close(w);

end
