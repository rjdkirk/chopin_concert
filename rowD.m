% First set - row D

load('hr_filter.mat');


% Load and split data
s1_d_data = h5read('eegsession_1122022.10.21_19.37.15.hdf5','/RawData/Samples' );
s1_d_trigTimes = h5read('eegsession_1122022.10.21_19.37.15.hdf5','/AsynchronData/Time' );
s1_d_trigValues= h5read('eegsession_1122022.10.21_19.37.15.hdf5','/AsynchronData/Value' );


% Sort/check trigger times

% Take out single values
% s1_d_trigTimesadj = s1_d_trigTimes(1:4:16);

% Change to seconds
s1_d_trigTimes_s = s1_d_trigTimes./256;

% Calculate differences
s1_d_trigTimes_diff = diff(s1_d_trigTimes_s);


% Song start/end times

d_song1_s = s1_d_trigTimes(2) + 465*256;
d_song1_e = d_song1_s + 163*256;
d_song2_s = d_song1_e + 5*256;
d_song2_e = d_song2_s + 272*256;
d_song3_s = s1_d_trigTimes(3) + 63*256;
d_song3_e = d_song3_s + 603*256;
d_song4_s = s1_d_trigTimes(4) + 59*256;
d_song4_e = d_song4_s + 416*256;
d_song5_s = s1_d_trigTimes(5) + 68*256;
d_song5_e = d_song5_s + 159*256;
d_song6_s = d_song5_e + 17*256;
d_song6_e = d_song6_s + 545*256;


% Before and after 30e (first two and last two together)
d_song1_b = d_song1_s - 30*256;
d_song2_a = d_song2_e + 30*256;
d_song3_b = d_song3_s - 30*256;
d_song3_a = d_song3_e + 30*256;
d_song4_b = d_song4_s - 30*256;
d_song4_a = d_song4_e + 30*256;
d_song5_b = d_song5_s - 30*256;
d_song6_a = d_song6_e + (length(s1_d_data) - d_song6_e);


% HR filter by participant

filt_d5_hr = filtfilt(Num,Den,double(s1_d_data(8,:)));
filt_d6_hr = filtfilt(Num,Den,double(s1_d_data(24,:)));
filt_d7_hr = filtfilt(Num,Den,double(s1_d_data(40,:)));
filt_d8_hr = filtfilt(Num,Den,double(s1_d_data(56,:)));
filt_d9_hr = filtfilt(Num,Den,double(s1_d_data(16,:)));


%% Loop through the data and separate by data type and time

eeg_index = [1, 17, 33, 49, 9];
gsr_index = [25, 29, 41, 45, 47];
hr_index = [8, 24, 40, 56, 16];


% Times
eeg_s1_d = zeros(5,7, length(d_song1_s:d_song2_e));
eeg_s2_d = zeros(5,7, length(d_song3_s:d_song3_e));
eeg_s3_d = zeros(5,7, length(d_song4_s:d_song4_e));
eeg_s4_d = zeros(5,7, length(d_song5_s:d_song6_e));

hr_s1_d = zeros(5, length(d_song1_s:d_song2_e));
hr_s2_d = zeros(5, length(d_song3_s:d_song3_e));
hr_s3_d = zeros(5, length(d_song4_s:d_song4_e));
hr_s4_d = zeros(5, length(d_song5_s:d_song6_e));

gsr_s1_d = zeros(5, length(d_song1_s:d_song2_e));
gsr_s2_d = zeros(5, length(d_song3_s:d_song3_e));
gsr_s3_d = zeros(5, length(d_song4_s:d_song4_e));
gsr_s4_d = zeros(5, length(d_song5_s:d_song6_e));


%% Separate for loops for each song
% Separate each song, for each physiology, participants by rows.

% First piece
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_d_data(a:b, d_song1_s:d_song2_e);
    eeg_s1_d(i, :, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_d_data(gsr_i, d_song1_s:d_song2_e);
    gsr_s1_d(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_d_data(hr_i, d_song1_s:d_song2_e)));
    hr_s1_d(i, :) = reshape(hr, 1, []);
end

% Second
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_d_data(a:b, d_song3_s:d_song3_e);
    eeg_s2_d(i, :, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_d_data(gsr_i, d_song3_s:d_song3_e);
    gsr_s2_d(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_d_data(hr_i, d_song3_s:d_song3_e)));
    hr_s2_d(i, :) = reshape(hr, 1, []);
end

% Third
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_d_data(a:b, d_song4_s:d_song4_e);
    eeg_s3_d(i, :, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_d_data(gsr_i, d_song4_s:d_song4_e);
    gsr_s3_d(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_d_data(hr_i, d_song4_s:d_song4_e)));
    hr_s3_d(i, :) = reshape(hr, 1, []);
end

% Fourth
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_d_data(a:b,d_song5_s:d_song6_e);
    eeg_s4_d(i, :, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_d_data(gsr_i, d_song5_s:d_song6_e);
    gsr_s4_d(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_d_data(hr_i,d_song5_s:d_song6_e)));
    hr_s4_d(i, :) = reshape(hr, 1, []);
end

%% 30s before each piece

% Times
eeg_s1b_d = zeros(5,7, length(d_song1_b:d_song1_s));
eeg_s2b_d = zeros(5,7, length(d_song3_b:d_song3_s));
eeg_s3b_d = zeros(5,7, length(d_song4_b:d_song4_s));
eeg_s4b_d = zeros(5,7, length(d_song5_b:d_song5_s));

hr_s1b_d = zeros(5, length(d_song1_b:d_song1_s));
hr_s2b_d = zeros(5, length(d_song3_b:d_song3_s));
hr_s3b_d = zeros(5, length(d_song4_b:d_song4_s));
hr_s4b_d = zeros(5, length(d_song5_b:d_song5_s));

gsr_s1b_d = zeros(5, length(d_song1_b:d_song1_s));
gsr_s2b_d = zeros(5, length(d_song3_b:d_song3_s));
gsr_s3b_d = zeros(5, length(d_song4_b:d_song4_s));
gsr_s4b_d = zeros(5, length(d_song5_b:d_song5_s));


%% 

% First piece
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_d_data(a:b, d_song1_b:d_song1_s);
    eeg_s1b_d(i, :, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_d_data(gsr_i, d_song1_b:d_song1_s);
    gsr_s1b_d(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_d_data(hr_i, d_song1_b:d_song1_s)));
    hr_s1b_d(i, :) = reshape(hr, 1, []);
end

% Second
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_d_data(a:b, d_song3_b:d_song3_s);
    eeg_s2b_d(i, :, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_d_data(gsr_i, d_song3_b:d_song3_s);
    gsr_s2b_d(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_d_data(hr_i, d_song3_b:d_song3_s)));
    hr_s2b_d(i, :) = reshape(hr, 1, []);
end

% Third
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_d_data(a:b, d_song4_b:d_song4_s);
    eeg_s3b_d(i, :, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_d_data(gsr_i, d_song4_b:d_song4_s);
    gsr_s3b_d(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_d_data(hr_i, d_song4_b:d_song4_s)));
    hr_s3b_d(i, :) = reshape(hr, 1, []);
end

% Fourth
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_d_data(a:b,d_song5_b:d_song5_s);
    eeg_s4b_d(i, :, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_d_data(gsr_i, d_song5_b:d_song5_s);
    gsr_s4b_d(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_d_data(hr_i,d_song5_b:d_song5_s)));
    hr_s4b_d(i, :) = reshape(hr, 1, []);
end

%% 30s after

% Times
eeg_s1a_d = zeros(5,7, length(d_song2_e:d_song2_a));
eeg_s2a_d = zeros(5,7, length(d_song3_e:d_song3_a));
eeg_s3a_d = zeros(5,7, length(d_song4_e:d_song4_a));
eeg_s4a_d = zeros(5,7, length(d_song6_e:d_song6_a));

hr_s1a_d = zeros(5, length(d_song2_e:d_song2_a));
hr_s2a_d = zeros(5, length(d_song3_e:d_song3_a));
hr_s3a_d = zeros(5, length(d_song4_e:d_song4_a));
hr_s4a_d = zeros(5, length(d_song6_e:d_song6_a));

gsr_s1a_d = zeros(5, length(d_song2_e:d_song2_a));
gsr_s2a_d = zeros(5, length(d_song3_e:d_song3_a));
gsr_s3a_d = zeros(5, length(d_song4_e:d_song4_a));
gsr_s4a_d = zeros(5, length(d_song6_e:d_song6_a));


%% 

% First piece
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_d_data(a:b, d_song2_e:d_song2_a);
    eeg_s1a_d(i, :, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_d_data(gsr_i, d_song2_e:d_song2_a);
    gsr_s1a_d(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_d_data(hr_i, d_song2_e:d_song2_a)));
    hr_s1a_d(i, :) = reshape(hr, 1, []);
end

% Second
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_d_data(a:b, d_song3_e:d_song3_a);
    eeg_s2a_d(i, :, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_d_data(gsr_i, d_song3_e:d_song3_a);
    gsr_s2a_d(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_d_data(hr_i, d_song3_e:d_song3_a)));
    hr_s2a_d(i, :) = reshape(hr, 1, []);
end

% Third
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_d_data(a:b, d_song4_e:d_song4_a);
    eeg_s3a_d(i, :, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_d_data(gsr_i, d_song4_e:d_song4_a);
    gsr_s3a_d(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_d_data(hr_i, d_song4_e:d_song4_a)));
    hr_s3a_d(i, :) = reshape(hr, 1, []);
end

% Fourth
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_d_data(a:b,d_song6_e:d_song6_a);
    eeg_s4a_d(i, :, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_d_data(gsr_i, d_song6_e:d_song6_a);
    gsr_s4a_d(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_d_data(hr_i,d_song6_e:d_song6_a)));
    hr_s4a_d(i, :) = reshape(hr, 1, []);
end


%% 




