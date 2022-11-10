% First set - row E

load('hr_filter.mat');


% Load and split data
s1_e_data = h5read('eegsession_1132022.10.21_19.47.57.hdf5','/RawData/Samples' );
s1_e_trigTimes = h5read('eegsession_1132022.10.21_19.47.57.hdf5','/AsynchronData/Time' );
s1_e_trigValues= h5read('eegsession_1132022.10.21_19.47.57.hdf5','/AsynchronData/Value' );


% Sort/check trigger times

% Take out single values
% s1_d_trigTimesadj = s1_d_trigTimes(1:4:16);

% Change to seconds
s1_e_trigTimes_s = s1_e_trigTimes./256;

% Calculate differences
s1_e_trigTimes_diff = diff(s1_e_trigTimes_s);


% Song start/end times

e_song1_s = s1_e_trigTimes(1) + 465*256;
e_song1_e = e_song1_s + 163*256;
e_song2_s = e_song1_e + 5*256;
e_song2_e = e_song2_s + 272*256;
e_song3_s = s1_e_trigTimes(2) + 63*256;
e_song3_e = e_song3_s + 603*256;
e_song4_s = s1_e_trigTimes(3) + 59*256;
e_song4_e = e_song4_s + 416*256;
e_song5_s = s1_e_trigTimes(4) + 68*256;
e_song5_e = e_song5_s + 159*256;
e_song6_s = e_song5_e + 17*256;
e_song6_e = e_song6_s + 545*256;


% Before and after 30e (first two and last two together)
e_song1_b = e_song1_s - 30*256;
e_song2_a = e_song2_e + 30*256;
e_song3_b = e_song3_s - 30*256;
e_song3_a = e_song3_e + 30*256;
e_song4_b = e_song4_s - 30*256;
e_song4_a = e_song4_e + 30*256;
e_song5_b = e_song5_s - 30*256;
e_song6_a = e_song6_e + (length(s1_e_data) - e_song6_e);


% % HR filter by participant

filt_e5_hr = filtfilt(Num,Den,double(s1_e_data(8,:)));
filt_e6_hr = filtfilt(Num,Den,double(s1_e_data(24,:)));
filt_e7_hr = filtfilt(Num,Den,double(s1_e_data(40,:)));
filt_e8_hr = filtfilt(Num,Den,double(s1_e_data(56,:)));
filt_e9_hr = filtfilt(Num,Den,double(s1_e_data(16,:)));


%% Loop through the data and separate by data type and time

eeg_index = [1, 17, 33, 49, 9];
gsr_index = [25, 29, 41, 45, 47];
hr_index = [8, 24, 40, 56, 16];


% Times
eeg_s1_e = zeros(5,7, length(e_song1_s:e_song2_e));
eeg_s2_e = zeros(5,7, length(e_song3_s:e_song3_e));
eeg_s3_e = zeros(5,7, length(e_song4_s:e_song4_e));
eeg_s4_e = zeros(5,7, length(e_song5_s:e_song6_e));

hr_s1_e = zeros(5, length(e_song1_s:e_song2_e));
hr_s2_e = zeros(5, length(e_song3_s:e_song3_e));
hr_s3_e = zeros(5, length(e_song4_s:e_song4_e));
hr_s4_e = zeros(5, length(e_song5_s:e_song6_e));

gsr_s1_e = zeros(5, length(e_song1_s:e_song2_e));
gsr_s2_e = zeros(5, length(e_song3_s:e_song3_e));
gsr_s3_e = zeros(5, length(e_song4_s:e_song4_e));
gsr_s4_e = zeros(5, length(e_song5_s:e_song6_e));


%% Separate each song, for each physiology, participants by rows.

% First piece
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_e_data(a:b, e_song1_s:e_song2_e);
    eeg_s1_e(i, :, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_e_data(gsr_i, e_song1_s:e_song2_e);
    gsr_s1_e(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_e_data(hr_i, e_song1_s:e_song2_e)));
    hr_s1_e(i, :) = reshape(hr, 1, []);
end

% Second
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_e_data(a:b, e_song3_s:e_song3_e);
    eeg_s2_e(i, :, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_e_data(gsr_i, e_song3_s:e_song3_e);
    gsr_s2_e(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_e_data(hr_i, e_song3_s:e_song3_e)));
    hr_s2_e(i, :) = reshape(hr, 1, []);
end

% Third
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_e_data(a:b, e_song4_s:e_song4_e);
    eeg_s3_e(i, :, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_e_data(gsr_i, e_song4_s:e_song4_e);
    gsr_s3_e(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_e_data(hr_i, e_song4_s:e_song4_e)));
    hr_s3_e(i, :) = reshape(hr, 1, []);
end

% Fourth
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_e_data(a:b,e_song5_s:e_song6_e);
    eeg_s4_e(i, :, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_e_data(gsr_i, e_song5_s:e_song6_e);
    gsr_s4_e(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_e_data(hr_i,e_song5_s:e_song6_e)));
    hr_s4_e(i, :) = reshape(hr, 1, []);
end

%% 30s before each piece

% Times
eeg_s1b_e = zeros(5,7, length(e_song1_b:e_song1_s));
eeg_s2b_e = zeros(5,7, length(e_song3_b:e_song3_s));
eeg_s3b_e = zeros(5,7, length(e_song4_b:e_song4_s));
eeg_s4b_e = zeros(5,7, length(e_song5_b:e_song5_s));

hr_s1b_e = zeros(5, length(e_song1_b:e_song1_s));
hr_s2b_e = zeros(5, length(e_song3_b:e_song3_s));
hr_s3b_e = zeros(5, length(e_song4_b:e_song4_s));
hr_s4b_e = zeros(5, length(e_song5_b:e_song5_s));

gsr_s1b_e = zeros(5, length(e_song1_b:e_song1_s));
gsr_s2b_e = zeros(5, length(e_song3_b:e_song3_s));
gsr_s3b_e = zeros(5, length(e_song4_b:e_song4_s));
gsr_s4b_e = zeros(5, length(e_song5_b:e_song5_s));


%% 

% First piece
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_e_data(a:b, e_song1_b:e_song1_s);
    eeg_s1b_e(i, :, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_e_data(gsr_i, e_song1_b:e_song1_s);
    gsr_s1b_e(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_e_data(hr_i, e_song1_b:e_song1_s)));
    hr_s1b_e(i, :) = reshape(hr, 1, []);
end

% Second
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_e_data(a:b, e_song3_b:e_song3_s);
    eeg_s2b_e(i, :, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_e_data(gsr_i, e_song3_b:e_song3_s);
    gsr_s2b_e(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_e_data(hr_i, e_song3_b:e_song3_s)));
    hr_s2b_e(i, :) = reshape(hr, 1, []);
end

% Third
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_e_data(a:b, e_song4_b:e_song4_s);
    eeg_s3b_e(i, :, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_e_data(gsr_i, e_song4_b:e_song4_s);
    gsr_s3b_e(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_e_data(hr_i, e_song4_b:e_song4_s)));
    hr_s3b_e(i, :) = reshape(hr, 1, []);
end

% Fourth
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_e_data(a:b,e_song5_b:e_song5_s);
    eeg_s4b_e(i, :, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_e_data(gsr_i, e_song5_b:e_song5_s);
    gsr_s4b_e(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_e_data(hr_i,e_song5_b:e_song5_s)));
    hr_s4b_e(i, :) = reshape(hr, 1, []);
end

%% 30s after

% Times
eeg_s1a_e = zeros(5,7, length(e_song2_e:e_song2_a));
eeg_s2a_e = zeros(5,7, length(e_song3_e:e_song3_a));
eeg_s3a_e = zeros(5,7, length(e_song4_e:e_song4_a));
eeg_s4a_e = zeros(5,7, length(e_song6_e:e_song6_a));

hr_s1a_e = zeros(5, length(e_song2_e:e_song2_a));
hr_s2a_e = zeros(5, length(e_song3_e:e_song3_a));
hr_s3a_e = zeros(5, length(e_song4_e:e_song4_a));
hr_s4a_e = zeros(5, length(e_song6_e:e_song6_a));

gsr_s1a_e = zeros(5, length(e_song2_e:e_song2_a));
gsr_s2a_e = zeros(5, length(e_song3_e:e_song3_a));
gsr_s3a_e = zeros(5, length(e_song4_e:e_song4_a));
gsr_s4a_e = zeros(5, length(e_song6_e:e_song6_a));


%% 

% First piece
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_e_data(a:b, e_song2_e:e_song2_a);
    eeg_s1a_e(i, :, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_e_data(gsr_i, e_song2_e:e_song2_a);
    gsr_s1a_e(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_e_data(hr_i, e_song2_e:e_song2_a)));
    hr_s1a_e(i, :) = reshape(hr, 1, []);
end

% Second
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_e_data(a:b, e_song3_e:e_song3_a);
    eeg_s2a_e(i, :, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_e_data(gsr_i, e_song3_e:e_song3_a);
    gsr_s2a_e(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_e_data(hr_i, e_song3_e:e_song3_a)));
    hr_s2a_e(i, :) = reshape(hr, 1, []);
end

% Third
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_e_data(a:b, e_song4_e:e_song4_a);
    eeg_s3a_e(i, :, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_e_data(gsr_i, e_song4_e:e_song4_a);
    gsr_s3a_e(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_e_data(hr_i, e_song4_e:e_song4_a)));
    hr_s3a_e(i, :) = reshape(hr, 1, []);
end

% Fourth
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_e_data(a:b,e_song6_e:e_song6_a);
    eeg_s4a_e(i, :, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_e_data(gsr_i, e_song6_e:e_song6_a);
    gsr_s4a_e(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_e_data(hr_i,e_song6_e:e_song6_a)));
    hr_s4a_e(i, :) = reshape(hr, 1, []);
end


%% 




