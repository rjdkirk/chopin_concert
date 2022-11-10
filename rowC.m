% First set - row C

% Dan's hr filter
load('hr_filter.mat');

% Load and split data
s1_c_data = h5read('eegsession_1112022.10.21_19.36.41.hdf5','/RawData/Samples' );
s1_c_trigTimes = h5read('eegsession_1112022.10.21_19.36.41.hdf5','/AsynchronData/Time' );
s1_c_trigValues= h5read('eegsession_1112022.10.21_19.36.41.hdf5','/AsynchronData/Value' );


% Sort/check trigger times

% Take out from duplicate values
s1_c_trigTimesadj = s1_c_trigTimes(1:4:28);

% Change to seconds
s1_c_trigTimes_s = s1_c_trigTimesadj./256;

% Calculate differences, to check
s1_c_trigTimes_diff = diff(s1_c_trigTimes_s);


% Song start/end times

% Times for all splits, but songs 1+2 and 5+6 will be grouped together, as
% they were performed at the concert.
c_song1_s = s1_c_trigTimesadj(2) + 465*256;
c_song1_e = c_song1_s + 163*256;
c_song2_s = c_song1_e + 5*256;
c_song2_e = c_song2_s + 272*256;
c_song3_s = s1_c_trigTimesadj(3) + 63*256;
c_song3_e = c_song3_s + 603*256;
c_song4_s = s1_c_trigTimesadj(4) + 59*256;
c_song4_e = c_song4_s + 416*256;
c_song5_s = s1_c_trigTimesadj(5) + 68*256;
c_song5_e = c_song5_s + 159*256;
c_song6_s = c_song5_e + 17*256;
c_song6_e = c_song6_s + 545*256;

% Before and after 30e (first two and last two together)
c_song1_b = c_song1_s - 30*256;
c_song2_a = c_song2_e + 30*256;
c_song3_b = c_song3_s - 30*256;
c_song3_a = c_song3_e + 30*256;
c_song4_b = c_song4_s - 30*256;
c_song4_a = c_song4_e + 30*256;
c_song5_b = c_song5_s - 30*256;
c_song6_a = c_song6_e + 30*256;


% HR filter by participant

filt_seat5c_hr = filtfilt(Num,Den,double(s1_c_data(8,:)));
filt_seat6c_hr = filtfilt(Num,Den,double(s1_c_data(24,:)));
filt_seat7c_hr = filtfilt(Num,Den,double(s1_c_data(40,:)));
filt_seat8c_hr = filtfilt(Num,Den,double(s1_c_data(56,:)));
filt_seat9c_hr = filtfilt(Num,Den,double(s1_c_data(16,:)));


%% Loop through the data and separate by data type and time

eeg_index = [1, 17, 33, 49, 9];
gsr_index = [25, 29, 41, 45, 47];
hr_index = [8, 24, 40, 56, 16];


% Song/piece list: 
%   1. c_song1_s:c_song2_e
%       before: c_song1_b:c_song1_s
%       after: c_song2_e:c_song2_a
%   2. c_song3_s:c_song3_e
%       before: c_song3_b:c_song3_s
%       after: c_song3_e:c_song3_a
%   3. c_song4_s:c_song4_e
%       before: c_song4_b:c_song4_s
%       after: c_song4_e:c_song4_a
%   4. c_song5_s:c_song6_e
%       before: c_song5_b:c_song5_s
%       after: c_song6_e:c_song6_a


% Times
eeg_s1_c = zeros(5,7, length(c_song1_s:c_song2_e));
eeg_s2_c = zeros(5,7, length(c_song3_s:c_song3_e));
eeg_s3_c = zeros(5,7, length(c_song4_s:c_song4_e));
eeg_s4_c = zeros(5,7, length(c_song5_s:c_song6_e));

hr_s1_c = zeros(5, length(c_song1_s:c_song2_e));
hr_s2_c = zeros(5, length(c_song3_s:c_song3_e));
hr_s3_c = zeros(5, length(c_song4_s:c_song4_e));
hr_s4_c = zeros(5, length(c_song5_s:c_song6_e));

gsr_s1_c = zeros(5, length(c_song1_s:c_song2_e));
gsr_s2_c = zeros(5, length(c_song3_s:c_song3_e));
gsr_s3_c = zeros(5, length(c_song4_s:c_song4_e));
gsr_s4_c = zeros(5, length(c_song5_s:c_song6_e));


%% Separate for loops for each song
% Separate each song, for each physiology, participants by rows.

% First piece
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_c_data(a:b, c_song1_s:c_song2_e);
    eeg_s1_c(i, :, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_c_data(gsr_i, c_song1_s:c_song2_e);
    gsr_s1_c(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_c_data(hr_i, c_song1_s:c_song2_e)));
    hr_s1_c(i, :) = reshape(hr, 1, []);
end

% Second
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_c_data(a:b, c_song3_s:c_song3_e);
%    eeg_s2_c(i, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_c_data(gsr_i, c_song3_s:c_song3_e);
    gsr_s2_c(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_c_data(hr_i, c_song3_s:c_song3_e)));
    hr_s2_c(i, :) = reshape(hr, 1, []);
end

% Third
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_c_data(a:b, c_song4_s:c_song4_e);
%    eeg_s3_c(i, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_c_data(gsr_i, c_song4_s:c_song4_e);
    gsr_s3_c(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_c_data(hr_i, c_song4_s:c_song4_e)));
    hr_s3_c(i, :) = reshape(hr, 1, []);
end

% Fourth
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_c_data(a:b,c_song5_s:c_song6_e);
%    eeg_s4_c(i, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_c_data(gsr_i, c_song5_s:c_song6_e);
    gsr_s4_c(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_c_data(hr_i,c_song5_s:c_song6_e)));
    hr_s4_c(i, :) = reshape(hr, 1, []);
end

%% 30s before each piece

% Times
eeg_s1b_c = zeros(5,7, length(c_song1_b:c_song1_s));
eeg_s2b_c = zeros(5,7, length(c_song3_b:c_song3_s));
eeg_s3b_c = zeros(5,7, length(c_song4_b:c_song4_s));
eeg_s4b_c = zeros(5,7, length(c_song5_b:c_song5_s));

hr_s1b_c = zeros(5, length(c_song1_b:c_song1_s));
hr_s2b_c = zeros(5, length(c_song3_b:c_song3_s));
hr_s3b_c = zeros(5, length(c_song4_b:c_song4_s));
hr_s4b_c = zeros(5, length(c_song5_b:c_song5_s));

gsr_s1b_c = zeros(5, length(c_song1_b:c_song1_s));
gsr_s2b_c = zeros(5, length(c_song3_b:c_song3_s));
gsr_s3b_c = zeros(5, length(c_song4_b:c_song4_s));
gsr_s4b_c = zeros(5, length(c_song5_b:c_song5_s));


%% 

% First piece
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_c_data(a:b, c_song1_b:c_song1_s);
    eeg_s1b_c(i, :, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_c_data(gsr_i, c_song1_b:c_song1_s);
    gsr_s1b_c(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_c_data(hr_i, c_song1_b:c_song1_s)));
    hr_s1b_c(i, :) = reshape(hr, 1, []);
end

% Second
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_c_data(a:b, c_song3_b:c_song3_s);
    eeg_s2b_c(i, :, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_c_data(gsr_i, c_song3_b:c_song3_s);
    gsr_s2b_c(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_c_data(hr_i, c_song3_b:c_song3_s)));
    hr_s2b_c(i, :) = reshape(hr, 1, []);
end

% Third
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_c_data(a:b, c_song4_b:c_song4_s);
    eeg_s3b_c(i, :, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_c_data(gsr_i, c_song4_b:c_song4_s);
    gsr_s3b_c(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_c_data(hr_i, c_song4_b:c_song4_s)));
    hr_s3b_c(i, :) = reshape(hr, 1, []);
end

% Fourth
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_c_data(a:b,c_song5_b:c_song5_s);
    eeg_s4b_c(i, :, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_c_data(gsr_i, c_song5_b:c_song5_s);
    gsr_s4b_c(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_c_data(hr_i,c_song5_b:c_song5_s)));
    hr_s4b_c(i, :) = reshape(hr, 1, []);
end

%% 30s after

% Times
eeg_s1a_c = zeros(5,7, length(c_song2_e:c_song2_a));
eeg_s2a_c = zeros(5,7, length(c_song3_e:c_song3_a));
eeg_s3a_c = zeros(5,7, length(c_song4_e:c_song4_a));
eeg_s4a_c = zeros(5,7, length(c_song6_e:c_song6_a));

hr_s1a_c = zeros(5, length(c_song2_e:c_song2_a));
hr_s2a_c = zeros(5, length(c_song3_e:c_song3_a));
hr_s3a_c = zeros(5, length(c_song4_e:c_song4_a));
hr_s4a_c = zeros(5, length(c_song6_e:c_song6_a));

gsr_s1a_c = zeros(5, length(c_song2_e:c_song2_a));
gsr_s2a_c = zeros(5, length(c_song3_e:c_song3_a));
gsr_s3a_c = zeros(5, length(c_song4_e:c_song4_a));
gsr_s4a_c = zeros(5, length(c_song6_e:c_song6_a));


%% 

% First piece
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_c_data(a:b, c_song2_e:c_song2_a);
    eeg_s1a_c(i, :, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_c_data(gsr_i, c_song2_e:c_song2_a);
    gsr_s1a_c(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_c_data(hr_i, c_song2_e:c_song2_a)));
    hr_s1a_c(i, :) = reshape(hr, 1, []);
end

% Second
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_c_data(a:b, c_song3_e:c_song3_a);
    eeg_s2a_c(i, :, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_c_data(gsr_i, c_song3_e:c_song3_a);
    gsr_s2a_c(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_c_data(hr_i, c_song3_e:c_song3_a)));
    hr_s2a_c(i, :) = reshape(hr, 1, []);
end

% Third
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_c_data(a:b, c_song4_e:c_song4_a);
    eeg_s3a_c(i, :, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_c_data(gsr_i, c_song4_e:c_song4_a);
    gsr_s3a_c(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_c_data(hr_i, c_song4_e:c_song4_a)));
    hr_s3a_c(i, :) = reshape(hr, 1, []);
end

% Fourth
for i = 1:5
    a = eeg_index(i);
    b = a + 6; % 7 eeg channels
    eeg = s1_c_data(a:b,c_song6_e:c_song6_a);
    eeg_s4a_c(i, :, :) = reshape(eeg, 1, 7, []);
    
    gsr_i = gsr_index(i);
    gsr = s1_c_data(gsr_i, c_song6_e:c_song6_a);
    gsr_s4a_c(i, :) = reshape(gsr, 1, []);
    
    hr_i = hr_index(i);
    hr = filtfilt(Num,Den,double(s1_c_data(hr_i,c_song6_e:c_song6_a)));
    hr_s4a_c(i, :) = reshape(hr, 1, []);
end


%% 


