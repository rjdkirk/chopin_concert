% First set - row F

load('hr_filter.mat');


% Load and split data
s1_f_data = h5read('eegsession_1142022.10.21_19.36.42.hdf5','/RawData/Samples' );
s1_f_trigTimes = h5read('eegsession_1142022.10.21_19.36.42.hdf5','/AsynchronData/Time' );
s1_f_trigValues= h5read('eegsession_1142022.10.21_19.36.42.hdf5','/AsynchronData/Value' );


% Sort/check trigger times

% Take out single values
% s1_d_trigTimesadj = s1_d_trigTimes(1:4:16);

% Change to seconds
s1_f_trigTimes_s = s1_f_trigTimes./256;

% Calculate differences
s1_f_trigTimes_diff = diff(s1_f_trigTimes_s);


% Song start/end times

f_song1_s = s1_f_trigTimes(2) + 465*256;
f_song1_e = f_song1_s + 163*256;
f_song2_s = f_song1_e + 5*256;
f_song2_e = f_song2_s + 272*256;
f_song3_s = s1_f_trigTimes(3) + 63*256;
f_song3_e = f_song3_s + 603*256;
f_song4_s = s1_f_trigTimes(4) + 59*256;
f_song4_e = f_song4_s + 416*256;
f_song5_s = s1_f_trigTimes(5) + 68*256;
f_song5_e = f_song5_s + 159*256;
f_song6_s = f_song5_e + 17*256;
f_song6_e = f_song6_s + 545*256;


% Before and after 30e (first two and last two together)
f_song1_b = f_song1_s - 30*256;
f_song2_a = f_song2_e + 30*256;
f_song3_b = f_song3_s - 30*256;
f_song3_a = f_song3_e + 30*256;
f_song4_b = f_song4_s - 30*256;
f_song4_a = f_song4_e + 30*256;
f_song5_b = f_song5_s - 30*256;
f_song6_a = f_song6_e + 30*256;


% HR filter by participant

filt_f5_hr = filtfilt(Num,Den,double(s1_f_data(8,:)));
filt_f6_hr = filtfilt(Num,Den,double(s1_f_data(24,:)));
filt_f8_hr = filtfilt(Num,Den,double(s1_f_data(40,:)));
filt_f9_hr = filtfilt(Num,Den,double(s1_f_data(56,:)));
filt_f10_hr = filtfilt(Num,Den,double(s1_f_data(16,:)));

%% Loop through the data and separate by data type and time

eeg_index = [1, 17, 33, 49, 9];
gsr_index = [25, 29, 41, 45, 47];
hr_index = [8, 24, 40, 56, 16];


% Times
eeg_s1_f = zeros(5,7, length(f_song1_s:f_song2_e));
eeg_s2_f = zeros(5,7, length(f_song3_s:f_song3_e));
eeg_s3_f = zeros(5,7, length(f_song4_s:f_song4_e));
eeg_s4_f = zeros(5,7, length(f_song5_s:f_song6_e));

hr_s1_f = zeros(5, length(f_song1_s:f_song2_e));
hr_s2_f = zeros(5, length(f_song3_s:f_song3_e));
hr_s3_f = zeros(5, length(f_song4_s:f_song4_e));
hr_s4_f = zeros(5, length(f_song5_s:f_song6_e));

gsr_s1_f = zeros(5, length(f_song1_s:f_song2_e));
gsr_s2_f = zeros(5, length(f_song3_s:f_song3_e));
gsr_s3_f = zeros(5, length(f_song4_s:f_song4_e));
gsr_s4_f = zeros(5, length(f_song5_s:f_song6_e));


%% Separate for loops for each song
% Separate each song, for each physiology, participants by rows.

% First piece
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_f_data(a:b, f_song1_s:f_song2_e);
    eeg_s1_f(i, :, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_f_data(gsr_i, f_song1_s:f_song2_e);
    gsr_s1_f(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_f_data(hr_i, f_song1_s:f_song2_e)));
    hr_s1_f(i, :) = reshape(hr, 1, []);
end

% Second
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_f_data(a:b, f_song3_s:f_song3_e);
    eeg_s2_f(i, :, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_f_data(gsr_i, f_song3_s:f_song3_e);
    gsr_s2_f(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_f_data(hr_i, f_song3_s:f_song3_e)));
    hr_s2_f(i, :) = reshape(hr, 1, []);
end

% Third
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_f_data(a:b, f_song4_s:f_song4_e);
    eeg_s3_f(i, :, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_f_data(gsr_i, f_song4_s:f_song4_e);
    gsr_s3_f(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_f_data(hr_i, f_song4_s:f_song4_e)));
    hr_s3_f(i, :) = reshape(hr, 1, []);
end

% Fourth
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_f_data(a:b,f_song5_s:f_song6_e);
    eeg_s4_f(i, :, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_f_data(gsr_i, f_song5_s:f_song6_e);
    gsr_s4_f(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_f_data(hr_i,f_song5_s:f_song6_e)));
    hr_s4_f(i, :) = reshape(hr, 1, []);
end

%% 30s before each piece

% Times
eeg_s1b_f = zeros(5,7, length(f_song1_b:f_song1_s));
eeg_s2b_f = zeros(5,7, length(f_song3_b:f_song3_s));
eeg_s3b_f = zeros(5,7, length(f_song4_b:f_song4_s));
eeg_s4b_f = zeros(5,7, length(f_song5_b:f_song5_s));

hr_s1b_f = zeros(5, length(f_song1_b:f_song1_s));
hr_s2b_f = zeros(5, length(f_song3_b:f_song3_s));
hr_s3b_f = zeros(5, length(f_song4_b:f_song4_s));
hr_s4b_f = zeros(5, length(f_song5_b:f_song5_s));

gsr_s1b_f = zeros(5, length(f_song1_b:f_song1_s));
gsr_s2b_f = zeros(5, length(f_song3_b:f_song3_s));
gsr_s3b_f = zeros(5, length(f_song4_b:f_song4_s));
gsr_s4b_f = zeros(5, length(f_song5_b:f_song5_s));


%% 

% First piece
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_f_data(a:b, f_song1_b:f_song1_s);
    eeg_s1b_f(i, :, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_f_data(gsr_i, f_song1_b:f_song1_s);
    gsr_s1b_f(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_f_data(hr_i, f_song1_b:f_song1_s)));
    hr_s1b_f(i, :) = reshape(hr, 1, []);
end

% Second
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_f_data(a:b, f_song3_b:f_song3_s);
    eeg_s2b_f(i, :, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_f_data(gsr_i, f_song3_b:f_song3_s);
    gsr_s2b_f(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_f_data(hr_i, f_song3_b:f_song3_s)));
    hr_s2b_f(i, :) = reshape(hr, 1, []);
end

% Third
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_f_data(a:b, f_song4_b:f_song4_s);
    eeg_s3b_f(i, :, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_f_data(gsr_i, f_song4_b:f_song4_s);
    gsr_s3b_f(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_f_data(hr_i, f_song4_b:f_song4_s)));
    hr_s3b_f(i, :) = reshape(hr, 1, []);
end

% Fourth
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_f_data(a:b,f_song5_b:f_song5_s);
    eeg_s4b_f(i, :, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_f_data(gsr_i, f_song5_b:f_song5_s);
    gsr_s4b_f(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_f_data(hr_i,f_song5_b:f_song5_s)));
    hr_s4b_f(i, :) = reshape(hr, 1, []);
end

%% 30s after

% Times
eeg_s1a_f = zeros(5,7, length(f_song2_e:f_song2_a));
eeg_s2a_f = zeros(5,7, length(f_song3_e:f_song3_a));
eeg_s3a_f = zeros(5,7, length(f_song4_e:f_song4_a));
eeg_s4a_f = zeros(5,7, length(f_song6_e:f_song6_a));

hr_s1a_f = zeros(5, length(f_song2_e:f_song2_a));
hr_s2a_f = zeros(5, length(f_song3_e:f_song3_a));
hr_s3a_f = zeros(5, length(f_song4_e:f_song4_a));
hr_s4a_f = zeros(5, length(f_song6_e:f_song6_a));

gsr_s1a_f = zeros(5, length(f_song2_e:f_song2_a));
gsr_s2a_f = zeros(5, length(f_song3_e:f_song3_a));
gsr_s3a_f = zeros(5, length(f_song4_e:f_song4_a));
gsr_s4a_f = zeros(5, length(f_song6_e:f_song6_a));


%% 

% First piece
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_f_data(a:b, f_song2_e:f_song2_a);
    eeg_s1a_f(i, :, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_f_data(gsr_i, f_song2_e:f_song2_a);
    gsr_s1a_f(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_f_data(hr_i, f_song2_e:f_song2_a)));
    hr_s1a_f(i, :) = reshape(hr, 1, []);
end

% Second
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_f_data(a:b, f_song3_e:f_song3_a);
    eeg_s2a_f(i, :, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_f_data(gsr_i, f_song3_e:f_song3_a);
    gsr_s2a_f(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_f_data(hr_i, f_song3_e:f_song3_a)));
    hr_s2a_f(i, :) = reshape(hr, 1, []);
end

% Third
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_f_data(a:b, f_song4_e:f_song4_a);
    eeg_s3a_f(i, :, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_f_data(gsr_i, f_song4_e:f_song4_a);
    gsr_s3a_f(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_f_data(hr_i, f_song4_e:f_song4_a)));
    hr_s3a_f(i, :) = reshape(hr, 1, []);
end

% Fourth
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_f_data(a:b,f_song6_e:f_song6_a);
    eeg_s4a_f(i, :, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_f_data(gsr_i, f_song6_e:f_song6_a);
    gsr_s4a_f(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_f_data(hr_i,f_song6_e:f_song6_a)));
    hr_s4a_f(i, :) = reshape(hr, 1, []);
end


%% 




