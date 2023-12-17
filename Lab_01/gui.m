function varargout = gui(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.

function gui_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);




% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


% --- Executes on button press in Import_image.
function Import_image_Callback(hObject, eventdata, handles)
    % hObject    handle to the button that was pressed
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Prompt the user to select an image file
    [fileName, filePath] = uigetfile({'*.png;*.jpg;*.jpeg;*.bmp', 'Image Files (*.png, *.jpg, *.jpeg, *.bmp)'; ...
                                      '*.*', 'All Files (*.*)'}, ...
                                      'Select an image file');

    % Check if the user selected a file or canceled the operation
    if isequal(fileName, 0)
        % User canceled the operation
        return;
    end

    % Construct the full file path
    fullFilePath = fullfile(filePath, fileName);

    try
        % Read the image
        image = imread(fullFilePath);

        % Display the image in a specified axes 
        axes(handles.original); 
        imshow(image);
        title('Imported Image');

        % Store the image data in the handles structure for future use
        handles.importedImage = image;

        % Update handles structure
        guidata(hObject, handles);
        

    catch exception
    % Display the error message
    errordlg(['Error reading the image file: ' exception.message], 'Image Import Error', 'modal');
    end
% --- Executes on button press in gray_image.
function gray_image_Callback(hObject, eventdata, handles)
    if ~isfield(handles, 'importedImage') || isempty(handles.importedImage)
        errordlg('Please import an image first.', 'Image Not Imported', 'modal');
        return;
    end

    try
        % Call Rgb2Gray function to convert the imported image to grayscale
        grayImage = Rgb2Gray(handles.importedImage,2);

        % Display the grayscale image in axes2 (replace 'axes2' with your actual axes tag)
        axes(handles.axes2);
        imshow(grayImage);
        title('Grayscale Image');

        % Store the grayscale image data in handles for future use
        handles.grayImage = grayImage;

        % Update handles structure
        guidata(hObject, handles);

    catch exception
        % Display the error message
        errordlg(['Error converting image to grayscale: ' exception.message], 'Conversion Error', 'modal');
    end

% --- Executes on button press in binary_image.
function binary_image_Callback(hObject, eventdata, handles)
if ~isfield(handles, 'importedImage') || isempty(handles.importedImage)
        errordlg('Please import an image first.', 'Image Not Imported', 'modal');
        return;
    end

    try
        % Call binary function to convert the imported image to grayscale
        binaryImage = RGB2Binary(handles.importedImage,80);

        % Display the binary image in axes2 (replace 'axes2' with your actual axes tag)
        axes(handles.axes2);
        imshow(binaryImage);
        title('Binary Image');

        % Store the binaryimage image data in handles for future use
        handles.binaryimage = binaryImage;

        % Update handles structure
        guidata(hObject, handles);

    catch exception
        % Display the error message
        errordlg(['Error converting image to grayscale: ' exception.message], 'Conversion Error', 'modal');
    end

% --- Executes on button press in negative.
function negative_Callback(hObject, eventdata, handles)
if ~isfield(handles, 'importedImage') || isempty(handles.importedImage)
        errordlg('Please import an image first.', 'Image Not Imported', 'modal');
        return;
end

    try
        % Call binary function to convert the imported image to grayscale
        negativeImage = negative_tranform(handles.importedImage);

        % Display the binary image in axes2 (replace 'axes2' with your actual axes tag)
        axes(handles.axes2);
        imshow(negativeImage);
        title('Complement Image');

        % Store the binaryimage image data in handles for future use
        handles.negativeImage = negativeImage;

        % Update handles structure
        guidata(hObject, handles);

    catch exception
        % Display the error message
        errordlg(['Error converting image to grayscale: ' exception.message], 'Conversion Error', 'modal');
    end

% --- Executes on button press in fourier.
function fourier_Callback(hObject, eventdata, handles)
if ~isfield(handles, 'importedImage') || isempty(handles.importedImage)
        errordlg('Please import an image first.', 'Image Not Imported', 'modal');
        return;
    end

    try
        % Call binary function to convert the imported image to grayscale
        Fourierimage = FourierTransformation(handles.importedImage);

        % Display the binary image in axes2 (replace 'axes2' with your actual axes tag)
        axes(handles.axes2);
        imshow(Fourierimage);
        title('Frequency Domain');

        % Store the binaryimage image data in handles for future use
        handles.Fourierimage = Fourierimage;

        % Update handles structure
        guidata(hObject, handles);

    catch exception
        % Display the error message
        errordlg(['Error converting image to grayscale: ' exception.message], 'Conversion Error', 'modal');
    end


% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
closereq();


% --- Executes on button press in Retrieve.
function Retrieve_Callback(hObject, eventdata, handles)
if ~isfield(handles, 'importedImage') || isempty(handles.importedImage)
        errordlg('Please import an image first.', 'Image Not Imported', 'modal');
        return;
end

    try
        % Call binary function to convert the imported image to grayscale
        image = handles.importedImage;

        % Display the binary image in axes2 (replace 'axes2' with your actual axes tag)
        axes(handles.axes2);
        imshow(image);
        title('Original Domain');

        % Store the binaryimage image data in handles for future use

        % Update handles structure
        guidata(hObject, handles);

    catch exception
        % Display the error message
        errordlg(['Error : ' exception.message], 'Conversion Error', 'modal');
    end
% --- Executes on button press in Inverse_Log.
function Inverse_Log_Callback(hObject, eventdata, handles)


% --- Executes on button press in Log.
function Log_Callback(hObject, eventdata, handles)
if ~isfield(handles, 'importedImage') || isempty(handles.importedImage)
        errordlg('Please import an image first.', 'Image Not Imported', 'modal');
        return;
    end

    try
        % Call binary function to convert the imported image to grayscale
        log_image = LogTransform(handles.importedImage,handles.c);

        % Display the binary image in axes2 (replace 'axes2' with your actual axes tag)
        axes(handles.axes2);
        imshow(log_image);
        title('log image');

        % Store the binaryimage image data in handles for future use
        handles.log_image = log_image;

        % Update handles structure
        guidata(hObject, handles);

    catch exception
        % Display the error message
        errordlg(['Error converting image to grayscale: ' exception.message], 'Conversion Error', 'modal');
    end


brightness_text_box_Callback
function brightness_text_box_Callback(hObject, eventdata, handles)

% Get the value from the textbox
test = get(hObject, 'String');

% Convert the string to a double
bright_dark = str2double(test);

% Check if the conversion was successful
if isnan(bright_dark)
    errordlg('Invalid value for c. Please enter a numeric value.', 'Invalid Input', 'modal');
    return;
end

% Update handles structure with the new value of c
handles.bright_dark = bright_dark;

% Update handles structure
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function tranformation_textbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tranformation_textbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tranformation_textbox_Callback(hObject, eventdata, handles)
% Get the value from the textbox
c_str = get(hObject, 'String');

% Convert the string to a double
c = str2double(c_str);

% Check if the conversion was successful
if isnan(c)
    errordlg('Invalid value for c. Please enter a numeric value.', 'Invalid Input', 'modal');
    return;
end

% Update handles structure with the new value of c
handles.c = c;

% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function brightness_text_box_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Add.
function Add_Callback(hObject, eventdata, handles)
if ~isfield(handles, 'importedImage') || isempty(handles.importedImage)
        errordlg('Please import an image first.', 'Image Not Imported', 'modal');
        return;
end

    try
        % Call binary function to convert the imported image to grayscale
        Bright_and_Dark = Brightness_Darkness(handles.importedImage,handles.bright_dark,1);

        % Display the binary image in axes2 (replace 'axes2' with your actual axes tag)
        axes(handles.axes2);
        imshow(Bright_and_Dark);
        title('Bright | Dark Image');

        % Store the binaryimage image data in handles for future use
        handles.Bright_and_Dark = Bright_and_Dark;

        % Update handles structure
        guidata(hObject, handles);

    catch exception
        % Display the error message
        errordlg(['Error converting image to grayscale: ' exception.message], 'Conversion Error', 'modal');
    end


% --- Executes on button press in Multiply.
function Multiply_Callback(hObject, eventdata, handles)
if ~isfield(handles, 'importedImage') || isempty(handles.importedImage)
        errordlg('Please import an image first.', 'Image Not Imported', 'modal');
        return;
end

    try
        % Call binary function to convert the imported image to grayscale
        Bright_and_Dark = Brightness_Darkness(handles.importedImage,handles.bright_dark,2);

        % Display the binary image in axes2 (replace 'axes2' with your actual axes tag)
        axes(handles.axes2);
        imshow(Bright_and_Dark);
        title('Bright | Dark Image');

        % Store the binaryimage image data in handles for future use
        handles.Bright_and_Dark = Bright_and_Dark;

        % Update handles structure
        guidata(hObject, handles);

    catch exception
        % Display the error message
        errordlg(['Error converting image to grayscale: ' exception.message], 'Conversion Error', 'modal');
    end
% --- Executes on button press in Substract.
function Substract_Callback(hObject, eventdata, handles)
if ~isfield(handles, 'importedImage') || isempty(handles.importedImage)
        errordlg('Please import an image first.', 'Image Not Imported', 'modal');
        return;
end

    try
        % Call binary function to convert the imported image to grayscale
        Bright_and_Dark = Brightness_Darkness(handles.importedImage,handles.bright_dark,3);

        % Display the binary image in axes2 (replace 'axes2' with your actual axes tag)
        axes(handles.axes2);
        imshow(Bright_and_Dark);
        title('Bright | Dark Image');

        % Store the binaryimage image data in handles for future use
        handles.Bright_and_Dark = Bright_and_Dark;

        % Update handles structure
        guidata(hObject, handles);

    catch exception
        % Display the error message
        errordlg(['Error converting image to grayscale: ' exception.message], 'Conversion Error', 'modal');
    end



% --- Executes on button press in Divide.
function Divide_Callback(hObject, eventdata, handles)
if ~isfield(handles, 'importedImage') || isempty(handles.importedImage)
        errordlg('Please import an image first.', 'Image Not Imported', 'modal');
        return;
end

    try
        % Call binary function to convert the imported image to grayscale
        Bright_and_Dark = Brightness_Darkness(handles.importedImage,handles.bright_dark,4);

        % Display the binary image in axes2 (replace 'axes2' with your actual axes tag)
        axes(handles.axes2);
        imshow(Bright_and_Dark);
        title('Bright | Dark Image');

        % Store the binaryimage image data in handles for future use
        handles.Bright_and_Dark = Bright_and_Dark;

        % Update handles structure
        guidata(hObject, handles);

    catch exception
        % Display the error message
        errordlg(['Error converting image to grayscale: ' exception.message], 'Conversion Error', 'modal');
    end

% --- Executes on button press in Powerfunction.
function Powerfunction_Callback(hObject, eventdata, handles)
if ~isfield(handles, 'importedImage') || isempty(handles.importedImage)
        errordlg('Please import an image first.', 'Image Not Imported', 'modal');
        return;
end

    try
        % Call binary function to convert the imported image to grayscale
        gamma_image = Gamma_equation(handles.importedImage,handles.c);

        % Display the binary image in axes2 (replace 'axes2' with your actual axes tag)
        axes(handles.axes2);
        imshow(gamma_image);
        title('Gamma Image');

        % Store the binaryimage image data in handles for future use
        handles.gamma_image = gamma_image;

        % Update handles structure
        guidata(hObject, handles);

    catch exception
        % Display the error message
        errordlg(['Error converting image to Gamma Image: ' exception.message], 'Conversion Error', 'modal');
    end
