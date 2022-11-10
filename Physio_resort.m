% Combine participant variables into single arrays for each physiology,
% rows = participant, column = segment


eeg_s1 = cat(1, eeg_s1_c, eeg_s1_d, eeg_s1_e, eeg_s1_f);
eeg_s2 = cat(1, eeg_s2_c, eeg_s2_d, eeg_s2_e, eeg_s2_f);
eeg_s3 = cat(1, eeg_s3_c, eeg_s3_d, eeg_s3_e, eeg_s3_f);
eeg_s4 = cat(1, eeg_s4_c, eeg_s4_d, eeg_s4_e, eeg_s4_f);

gsr_s1 = cat(1, gsr_s1_c, gsr_s1_d, gsr_s1_e, gsr_s1_f);
gsr_s2 = cat(1, gsr_s2_c, gsr_s2_d, gsr_s2_e, gsr_s2_f);
gsr_s3 = cat(1, gsr_s3_c, gsr_s3_d, gsr_s3_e, gsr_s3_f);
gsr_s4 = cat(1, gsr_s4_c, gsr_s4_d, gsr_s4_e, gsr_s4_f);

hr_s1 = cat(1, hr_s1_c, hr_s1_d, hr_s1_e, hr_s1_f);
hr_s2 = cat(1, hr_s2_c, hr_s2_d, hr_s2_e, hr_s2_f);
hr_s3 = cat(1, hr_s3_c, hr_s3_d, hr_s3_e, hr_s3_f);
hr_s4 = cat(1, hr_s4_c, hr_s4_d, hr_s4_e, hr_s4_f);


%% Before

eeg_s1b = cat(1, eeg_s1b_c, eeg_s1b_d, eeg_s1b_e, eeg_s1b_f);
eeg_s2b = cat(1, eeg_s2b_c, eeg_s2b_d, eeg_s2b_e, eeg_s2b_f);
eeg_s3b = cat(1, eeg_s3b_c, eeg_s3b_d, eeg_s3b_e, eeg_s3b_f);
eeg_s4b = cat(1, eeg_s4b_c, eeg_s4b_d, eeg_s4b_e, eeg_s4b_f);

gsr_s1b = cat(1, gsr_s1b_c, gsr_s1b_d, gsr_s1b_e, gsr_s1b_f);
gsr_s2b = cat(1, gsr_s2b_c, gsr_s2b_d, gsr_s2b_e, gsr_s2b_f);
gsr_s3b = cat(1, gsr_s3b_c, gsr_s3b_d, gsr_s3b_e, gsr_s3b_f);
gsr_s4b = cat(1, gsr_s4b_c, gsr_s4b_d, gsr_s4b_e, gsr_s4b_f);

hr_s1b = cat(1, hr_s1b_c, hr_s1b_d, hr_s1b_e, hr_s1b_f);
hr_s2b = cat(1, hr_s2b_c, hr_s2b_d, hr_s2b_e, hr_s2b_f);
hr_s3b = cat(1, hr_s3b_c, hr_s3b_d, hr_s3b_e, hr_s3b_f);
hr_s4b = cat(1, hr_s4b_c, hr_s4b_d, hr_s4b_e, hr_s4b_f);


%% After

eeg_s1a = cat(1, eeg_s1a_c, eeg_s1a_d, eeg_s1a_e, eeg_s1a_f);
eeg_s2a = cat(1, eeg_s2a_c, eeg_s2a_d, eeg_s2a_e, eeg_s2a_f);
eeg_s3a = cat(1, eeg_s3a_c, eeg_s3a_d, eeg_s3a_e, eeg_s3a_f);
% eeg_s4a = cat(1, eeg_s4a_c, eeg_s4a_d, eeg_s4a_e, eeg_s4a_f);

gsr_s1a = cat(1, gsr_s1a_c, gsr_s1a_d, gsr_s1a_e, gsr_s1a_f);
gsr_s2a = cat(1, gsr_s2a_c, gsr_s2a_d, gsr_s2a_e, gsr_s2a_f);
gsr_s3a = cat(1, gsr_s3a_c, gsr_s3a_d, gsr_s3a_e, gsr_s3a_f);
% gsr_s4a = cat(1, gsr_s4a_c, gsr_s4a_d, gsr_s4a_e, gsr_s4a_f);

hr_s1a = cat(1, hr_s1a_c, hr_s1a_d, hr_s1a_e, hr_s1a_f);
hr_s2a = cat(1, hr_s2a_c, hr_s2a_d, hr_s2a_e, hr_s2a_f);
hr_s3a = cat(1, hr_s3a_c, hr_s3a_d, hr_s3a_e, hr_s3a_f);
% hr_s4a = cat(1, hr_s4a_c, hr_s4a_d, hr_s4a_e, hr_s4a_f);


%% Arrange by piece order, with before and after

eeg_full = cat(3, eeg_s1b, eeg_s1, eeg_s1a, ...
    eeg_s2b, eeg_s2, eeg_s2a, ...
    eeg_s3b, eeg_s3, eeg_s3a, ...
    eeg_s4b, eeg_s4);

gsr_full = cat(2, gsr_s1b, gsr_s1, gsr_s1a, ...
    gsr_s2b, gsr_s2, gsr_s2a, ...
    gsr_s3b, gsr_s3, gsr_s3a, ...
    gsr_s4b, gsr_s4);

hr_full = cat(2, hr_s1b, hr_s1, hr_s1a, ...
    hr_s2b, hr_s2, hr_s2a, ...
    hr_s3b, hr_s3, hr_s3a, ...
    hr_s4b, hr_s4);
