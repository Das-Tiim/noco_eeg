
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                        MAIN SCRIPT                                  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
%%%              correcting error in one file (nr08)                    %%%
%%%           done only once after eeglab preprocessing                 %%%

% for subject nr08 (scheinbar) in tria 221 & 222 problems with EEG (data not completely recorded)
% --> in psychophysics data these trials: valid == 0
% directly in N8 Ordner

% clear all
% cd("../N8")
% EL2LE('nr_s_08_sdapa_1437.mat')
% load('NOCO_nr_s_08_sdapa_1437.mat');
% trial(221).valid = 0;
% trial(222).valid = 0;
% save 'D:\Dokumente\Uni\Vorlesungen\Master_Neurobiologie\WiSe22\Masterarbeit NoCoLab\Matlab\Göttingen_Studie\Psycho\NOCO_nr_s_08_sdapa_1437.mat'
% 
% clear all
% EL2LE('08_sdapa.mat')
% load('NOCO_08_sdapa.mat');
% trial(221).valid = 0;
% trial(222).valid = 0;
% save D:\Dokumente\Uni\Vorlesungen\Master_Neurobiologie\WiSe22\Masterarbeit NoCoLab\Matlab\Göttingen_Studie\Psycho\NOCO_8_sdapa.mat

% clear all

% in EEG Daten halbe trial: fields 1329 - 1333



%%      OUTLIERS INCLUDING CRITERIA (at the moment hb)
% 0 if hb should be excluded, 1 if included (should stay 0)
IncAll = 1;
if IncAll == 1
    Nsub = 21; % overall number of subjects
else
    Nsub = 17;
end

% decides whether plot windows are opened or not
% --> entire file creates probably >100 figures if not commented out, so if
% it is run for the first time to get all variables should be set off
% anyway figures are saved just not shown
% --> if you need figures in an analysis you need to manually set it on
% again !
set(0,'DefaultFigureVisible','off');
%set(0,'DefaultFigureVisible','on');

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --------------------- 1. Psychophysics -------------------------------- %

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cd("../Psycho") % Psychophysics folder


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% ------------------ 1.0 extracting PSE, JND ------------------------ %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% ------------------------ probitanalyse -------------------------------- %
% cells for motor-auditory, auditory-only
% used probitanalyse to analyse file and compute 25%, 50%, 75% thresholds
% manually copied into cell for each subject and condition

% motor-auditory condition (sound)
psychoMA{1,1} = 'subject';
psychoMA{1,2} = 'ls02';
psychoMA{1,3} = 'lw03';
psychoMA{1,4} = 'jb04';
psychoMA{1,5} = 'mn05';
psychoMA{1,6} = 're06';
psychoMA{1,7} = 'ev07';
psychoMA{1,8} = 'nr08';
psychoMA{1,9} = 'sw13';
psychoMA{1,10} = 'lf14';
psychoMA{1,11} = 'lk15';
psychoMA{1,12} = 'sp16';
psychoMA{1,13} = 'hr17';
psychoMA{1,14} = 'sd19';
psychoMA{1,15} = 'nro20';
psychoMA{1,16} = 'lb21';
psychoMA{1,17} = 'jg22';
psychoMA{1,18} = 'al23';

if IncAll == 1
    psychoMA{1,19} = 'fs25';
    psychoMA{1,20} = 'am26';
    psychoMA{1,21} = 'lsc27';
    psychoMA{1,22} = 'rg28';
end

psychoMA{2,1} = '25% threshold [threshold, SD, chi2, df, p]';
% 1. Zeile: all SOAs, 2. Zeile: SOA 0, 3. Zeile SOA 50, 4. Zeile: SOA 200, 5. Zeile: SOA 600
psychoMA{2,2} = [73.2205, NaN, 0.026, 4, 0.00009;...
    73.2916, NaN, 0.002, 4, 0.00000; 73.3529, NaN, 0.000, 4, 0.00000;...
    73.1968, NaN, 0.086, 4, 0.00090; 73.0055, NaN, 0.039, 4, 0.00019];
psychoMA{2,3} = [73.512, NaN, 0.049, 4, 0.00030;...
    73.6149, NaN, 0.015, 4, 0.00003; 73.6369, NaN, 0.010, 4, 0.00001;
    73.5611, NaN, 0.054, 4, 0.00036; 73.2916, NaN, 0.002, 4, 0.00000];
psychoMA{2,4} = [73.8767, NaN, 0.047, 4, 0.00027;...
    73.7047, NaN, 0.089, 4, 0.00096; 73.9375, NaN, 0.012, 4, 0.00002;...
    74.2203, NaN, 0.017, 4, 0.00003; 73.5837, NaN, 0.014, 4, 0.00002];
psychoMA{2,5} = [73.6596, NaN, 0.035, 4, 0.00015;...
    73.9905, NaN, 0.008, 4, 0.00001; 74.0662, NaN, 0.042, 4, 0.00022;...
    73.716, NaN, 0.09, 4, 0.00042; 73.2207, NaN, 0.057, 4, 0.00040];
psychoMA{2,6} = [72.9172, NaN, 0.077, 4, 0.00072;...
    73.5042, NaN, 0.003, 4, 0.00000; 73.2961, NaN, 0.300, 4, 0.01019;...
    73.1769, NaN, 0.120, 4, 0.00173; 72.2435, NaN, 0.001, 4, 0.00000];
psychoMA{2,7} = [73.2174, NaN, 0.256, 4, 0.00751;...
    73.1053, NaN, 0.009, 4, 0.00001; 73.4517, NaN, 0.059, 4, 0.00043;...
    73.3883, NaN, 0.319, 4, 0.01144; 73.2147, NaN, 0.078, 4, 0.00074];
psychoMA{2,8} = [73.2644, NaN, 0.022, 4, 0.00006;...
    73.2666, NaN, 0.000, 4, 0.00000; 73.2426, NaN, 0.051, 4, 0.00032;...
    73.3703, NaN, 0.004, 4, 0.00000; 73.1964, NaN, 0.000, 4, 0.00000];
psychoMA{2,9} = [73.5274, NaN, 0.040, 4, 0.00020;...
    73.8101, NaN, 0.029, 4, 0.00011; 73.9033, NaN, 0.000, 4, 0.00000;...
    73.9238, NaN, 0.000, 4, 0.00000; 72.9898, NaN, 0.008, 4, 0.00001];
psychoMA{2,10} = [73.3544, NaN, 0.087, 4, 0.00092;...
    73.4016, NaN, 0.045, 4, 0.00025; 73.2237, NaN, 0.000, 4, 0.00000;...
    73.3663, NaN, 0.115, 4, 0.00158; 73.4445, NaN, 0.006, 4, 0.00000];
psychoMA{2,11} = [73.9624, NaN, 0.019, 4, 0.00005;...
    74.1009, NaN, 0.000, 4, 0.00000; 74.0713, NaN, 0.018, 4, 0.00004;...
    73.951, NaN, 0.023, 4, 0.00007; 73.675, NaN, 0.001, 4, 0.00000];
psychoMA{2,12} = [73.6544, NaN, 0.033, 4, 0.00014;...
    73.863, NaN, 0.000, 4, 0.00000; 73.6389, NaN, 0.048, 4, 0.00028;...
    73.8533, NaN, 0.018, 4, 0.00004; 73.9238, NaN, 0.000, 4 , 0.00000];
psychoMA{2,13} = [72.5284, NaN, 0.104,4,0.00130;...
    72.6417, NaN, 0.048, 4, 0.00028; 72.7764, NaN, 0.109, 4, 0.00142;...
    73.0332, NaN, 0.033, 4, 0.00014; 71.6367, 2.225, 0.200, 4, 0.00469];
psychoMA{2,14} = [73.9673, NaN, 0.009, 4, 0.00001; ...
    73.7356, NaN, 0.029, 4, 0.00011; 73.9876, NaN, 0.041, 4, 0.00020;...
    74.0699, NaN, 0.033, 4, 0.00013; 74.0713, NaN, 0.000, 4, 0.00000];
psychoMA{2,15} = [73.051, NaN, 0.084, 4, 0.00085;...
    73.3387, NaN, 0.022, 4, 0.00006; 73.8505, NaN, 0.156, 4, 0.00287;...
    72.906, NaN, 0.009, 4, 0.00001; 72.2924, NaN, 0.004, 4, 0.00000];
psychoMA{2,16} = [73.4906, NaN, 0.106, 4, 0.00136;...
    73.4293, NaN, 0.063, 4, 0.00048; 73.513, NaN, 0.090, 4, 0.00098;...
    73.6002, NaN, 0.017, 4, 0.00004; 73.5267, NaN, 0.135, 4, 0.00218];
psychoMA{2,17} = [72.9448, NaN, 0.182, 4, 0.00391;...
    72.8063, NaN, 0.396, 4, 0.01721; 73.0038, NaN, 0.169, 4, 0.00339;...
    73.0948, NaN, 0.024, 4, 0.00007; 72.8412, NaN, 0.043, 4, 0.00022];
psychoMA{2,18} = [74.0477, NaN, 0.008, 4, 0.00001;...
    74.0193, NaN, 0.000, 4, 0.00000; 74.0866, NaN, 0.000, 4, 0.00000;...
    74.1069, NaN, 0.033, 4, 0.00014; 73.9703, NaN, 0.000, 4, 0.00000];

if IncAll == 1
    psychoMA{2,19} = [73.5614; 73.5614; 73.9238; 73.8101; 73.2534];
    psychoMA{2,20} = [73.4257; 73.8101; 73.9033; 73.4309; 73.0848];
    psychoMA{2,21} = [73.1747; 73.4309; 73.1964; 72.9698; 73.3164];
    psychoMA{2,22} = [73.3452; 73.2817; 73.254; 73.2436; 73.5497];
end


psychoMA{3,1} = '50% threshold [threshold, SD, chi2, df, p]';
psychoMA{3,2} = [73.6641, 0.93539, 0.026, 4, 0.00009;...
    73.7175, 0.86861, 0.002, 4, 0.00000; 73.6408, 0.69053, 0.000, 4, 0.00000;...
    73.6541, 0.89813, 0.086, 4, 0.00090; 73.6386, 1.071, 0.039, 4, 0.00021];
psychoMA{3,3} = [73.9784, 0.93542, 0.049, 4, 0.00030;
    73.9721, 0.78021, 0.015, 4, 0.00003; 74.2537, 1.0645, 0.010, 4, 0.00001;...
    74.015, 0.93474, 0.054, 4, 0.00036; 73.7175, 0.86861, 0.002, 4, 0.00000];
psychoMA{3,4} = [74.4705, 1.0713, 0.047, 4, 0.00027;...
    74.2991, 0.92093, 0.089, 4, 0.00096; 74.4831, 0.97042, 0.012, 4, 0.00002;...
    74.5705, 0.68254, 0.017, 4, 0.00003; 74.498, 1.2318, 0.014, 4, 0.00002];
psychoMA{3,5} = [74.2725, 1.0376, 0.035, 4, 0.00015;...
    74.5007, 0.90953, 0.008, 4, 0.00001; 74.6637, 0.92517, 0.042, 4, 0.00022;...
    74.2419, 1.0247, 0.059, 4, 0.00042; 73.6555, 0.80251, 0.057, 4, 0.00040];
psychoMA{3,6} = [73.5584, 1.0984, 0.077, 4, 0.00072;...
    73.887, 0.82675, 0.003, 4, 0.00000; 74.0771, 1.2079, 0.300, 4, 0.01019;...
    73.7378, 1.1713, 0.120, 4, 0.00173; 72.6523, 0.58091, 0.001, 4, 0.00000];
psychoMA{3,7} = [73.8172, 1.0169, 0.256, 4, 0.00751;...
    73.5848, 0.90651, 0.009, 4, 0.00001; 74.2472, 1.1296, 0.059, 4, 0.00043;...
    73.7063, 0.64005, 0.319, 4, 0.01144; 73.8755, 1.0808, 0.078, 4, 0.00074];
psychoMA{3,8} = [73.635, 0.79294, 0.022, 4, 0.00006;...
    73.4939, 0.60108, 0.000, 4, 0.00000; 73.7259, 0.96485, 0.051, 4, 0.00032;...
    73.9054, 1.0042, 0.004, 4, 0.00000; 73.5, 0.69927, 0.000, 4, 0.00000];
psychoMA{3,9} = [73.9288, 0.85488, 0.040, 4, 0.00020;...
    74.105, 0.72691, 0.029, 4, 0.00011; 73.9893, 0.20682, 0.000, 4, 0.00000;...
    74.0108, 0.20893, 0.000, 4, 0.00000; 73.5, 0.90919, 0.008, 4, 0.00001];
psychoMA{3,10} = [73.7256, 0.79436, 0.087, 4, 0.00092;...
    73.7766, 0.85926, 0.045, 4, 0.00025; 73.5689, 0.76089, .000, 4, 0.00000;...
    73.7044, 0.6358, 0.115, 4, 0.00158; 73.8621, 0.89368, 0.006, 4, 0.00000];
psychoMA{3,11} = [74.3584, 0.84222, 0.019, 4, 0.00005;...
    74.5, 0.81123, 0.000, 4, 0.00000; 74.3595, 0.62843, 0.018, 4, 0.00004;...
    74.3549, 0.88465, 0.023, 4, 0.00007; 74.18, 0.97673, 0.001, 4, 0.00000];
psychoMA{3,12} = [73.9483, 0.64207, 0.033, 4, 0.00014;...
    73.9466, 0.20661, 0.000, 4, 0.00000; 74.1153, 0.8772, 0.048,4, 0.00028;...
    73.9599, 0.2387, 0.018, 4, 0.00004; 74.0108, 0.20893, 0.000, 4, 0.00000];
psychoMA{3,13} = [73.187, 1.0033, 0.10, 4, 0.00130;...
    73.3073, 1.0083, 0.048, 4, 0.00028; 73.2102, 0.84507, 0.109, 4, 0.00142;...
    73.1673, 0.36006, 0.033, 4, 0.00014; 72.8423, 1.1714, 0.200, 4, 0.00469];
psychoMA{3,14} = [74.3748, 0.86387, 0.009, 4, 0.00001;...
    74.2643, 0.96663, 0.029, 4, 0.00011; 74.4999, 0.96887, 0.041, 4, 0.00020;...
    74.3596, 0.75004, 0.033, 4, 0.00013; 74.3592, 0.69065, 0.000, 4, 0.00000];
psychoMA{3,15} = [73.7905, 1.1927, 0.084, 4, 0.001;...
    74.0101, 1.0974, 0.022, 4, 0.00006; 74.2223, 1.0223, 0.156, 4, 0.00287;...
    73.4999, 1.0452, 0.009, 4, 0.00001; 73.3508, 1.2336, 0.004, 4, 0.00000];
psychoMA{3,16} = [74.0022, 1.0066, 0.106, 4, 0.00136;...
    74.0864, 1.1037, 0.063, 4, 0.00048; 73.9064, 0.71563, 0.090, 4, 0.00098;...
    73.8951, 0.6388, 0.017, 4, 0.00004; 74.0827, 1.0997, 0.135, 4, 0.00218];
psychoMA{3,17} = [73.5766, 1.0082, 0.182, 4, 0.00391;...
    73.7122, 1.3891, 0.396, 4, 0.01721; 73.7191, 0.89775, 0.169, 4, 0.00339;...
    73.5648, 0.958, 0.024, 4, 0.00007; 73.444, 0.93321, 0.043, 4, 0.00022];
psychoMA{3,18} = [74.1576, 0.30587, 0.008, 4, 0.00001;...
    74.0974, 0.2068, 0.000, 4, 0.00000; 74.1572, 0.21444, 0.000, 4, 0.00000;...
    74.1942, 0.31035, 0.033, 4, 0.00014; 74.0525, 0.20324, 0.000, 4, 0.00000];

if IncAll == 1
    psychoMA{3,19} = [73.9393; 73.9393; 74.0108; 74.105; 73.6403];
    psychoMA{3,20} = [73.8227; 74.105; 73.9893; 73.7772; 73.4326];
    psychoMA{3,21} = [73.5; 73.7772; 73.5; 73.0533; 73.5747];
    psychoMA{3,22} = [73.9019; 73.8158; 73.8808; 73.8501; 74.0159];
end


psychoMA{4,1} = '75% threshold [threshold, SD, chi2, df, p]';
psychoMA{4,2} = [74.1078, NaN, 0.026, 4, 0.00009;...
    74.1434, NaN, 0.002, 4, 0.00000; 73.9287, NaN, 0.000, 4, 0.00000;...
    74.1114, NaN, 0.086, 4, 0.00097; 74.2718, NaN, 0.039, 4, 0.00021];
psychoMA{4,3} = [74.4448, NaN, 0.049, 4, 0.00030;...
    74.3293, NaN, 0.015, 4, 0.00003; 74.8704, NaN, 0.010, 4, 0.00001;...
    74.4689, NaN, 0.054, 4, 0.00036; 74.1434, NaN, 0.002, 4, 0.00000];
psychoMA{4,4} = [75.0643, NaN, 0.047, 4, 0.00027;...
    74.8936, NaN, 0.089, 4, 0.00096; 75.0286, NaN, 0.012, 4, 0.00002;...
    74.9207, NaN, 0.017, 4, 0.00003; 75.4124, NaN, 0.014, 4, 0.00002];
psychoMA{4,5} = [74.8853, NaN, 0.035, 4, 0.00015;...
    75.0108, NaN, 0.008, 4, 0.00001; 75.2612, NaN, 0.042, 4, 0.00022;...
    74.7678, NaN, 0.059, 4, 0.00042; 74.0903, NaN, 0.057, 4, 0.00040];
psychoMA{4,6} = [74.1995, NaN, 0.077, 4, 0.00072;...
    74.2698, NaN, 0.003, 4, 0.00000; 74.8581, NaN, 0.300, 4, 0.01019;...
    74.2986, NaN, 0.120, 4, 0.00173; 73.0611, NaN, 0.001, 4, 0.00000];
psychoMA{4,7} = [74.4169, NaN, 0.256, 4, 0.00751;...
    74.0643, NaN, 0.009, 4, 0.00001; 75.0428, NaN, 0.059, 4, 0.00043;...
    74.0243, NaN, 0.319, 4, 0.01144; 74.5362, NaN, 0.078, 4, 0.00074];
psychoMA{4,8} = [74.0056, NaN, 0.022, 4, 0.00006;...
    73.7213, NaN, 0.000, 4, 0.00000; 74.2092, NaN, 0.051, 4, 0.00032;...
    74.4405, NaN, 0.004, 4, 0.00000; 73.8036, NaN, 0.000, 4, 0.00000];
psychoMA{4,9} = [74.3301, NaN, 0.040, 4, 0.00020;...
    74.3998, NaN, 0.0029, 4, 0.00011; 74.0754, NaN, 0.000, 4, 0.00000;...
    74.0977, NaN, 0.000, 4, 0.00000; 74.0102, NaN, 0.008, 4, 0.00001];
psychoMA{4,10} = [74.0967, NaN, 0.087, 4, 0.00092;...
    74.1516, NaN, 0.045, 4, 0.00025; 73.9142, NaN, 0.000, 4, 0.00000;...
    74.0426, NaN, 0.115, 4, 0.00158; 74.2797, NaN, 0.006, 4, 0.00000];
psychoMA{4,11} = [74.7544, NaN, 0.019, 4, 0.00005; ...
    74.8992, NaN, 0.000, 4, 0.00000; 74.6477, NaN, 0.018, 4, 0.00004;...
    74.7588, NaN, 0.023, 4, 0.00007; 74.685, NaN, 0.001, 4, 0.00000];
psychoMA{4,12} = [74.2422, NaN, 0.033, 4, 0.00014;...
    74.0302, NaN, 0.000, 4, 0.00000; 74.5916, NaN, 0.048, 4, 0.000;...
    74.0666, NaN, 0.018, 4, 0.00004; 74.0977, NaN, 0.000, 4, 0.00000];
psychoMA{4,13} = [73.8456, NaN, 0.104, 4, 0.00130; 73.973, NaN, 0.048, 4, 0.00028;...
    73.973, NaN, 0.048, 4, 0.00028; 73.644, NaN, 0.109, 4, 0.00142;...
    73.3013, NaN, 0.033, 4, 0.00014; 74.0478, 2.225, 0.200, 4, 0.00469];
psychoMA{4,14} = [74.7823, NaN, 0.009, 4, 0.00001;...
    74.7931, NaN, 0.029, 4, 0.00011; 75.0123, NaN, 0.041, 4, 0.00020;...
    74.6494, NaN, 0.033, 4, 0.00013; 74.6471, NaN, 0.000, 4, 0.00000];
psychoMA{4,15} = [74.5299, NaN, 0.084, 4, 0.00085;...
    74.6814, NaN, 0.022, 4, 0.00006; 74.5942, NaN, 0.156, 4, 0.00287;...
    74.0939, NaN, 0.009, 4, 0.00001; 74.4092, NaN, 0.004, 4, 0.00000];
psychoMA{4,16} = [74.5138, NaN, 0.106, 4, 0.00136;...
    74.7436, NaN, 0.063, 4, 0.00048; 74.2998, NaN, 0.090, 4, 0.00098;...
    74.1899, NaN, 0.017, 4, 0.00004; 74.6386, NaN, 0.135, 4, 0.00218];
psychoMA{4,17} = [74.2084, NaN, 0.182, 4, 0.00391;...
    74.6181, NaN, 0.396, 4, 0.01721; 74.4343, NaN, 0.169, 4, 0.00339;...
    74.0349, NaN, 0.024, 4, 0.00007; 74.0468, NaN, 0.043, 4, 0.00022];
psychoMA{4,18} = [74.2674, NaN, 0.008, 4, 0.00001;...
    74.1754, NaN, 0.000, 4, 0.00000; 74.2278, NaN, 0.000, 4, 0.00000;...
    74.2815, NaN, 0.033, 4, 0.00014; 74.1348, NaN, 0.000, 4, 0.00000];

if IncAll == 1
    psychoMA{4,19} = [74.3172; 74.3172; 74.0977; 74.3998; 74.0272];
    psychoMA{4,20} = [74.2197; 74.3998; 74.0754; 74.1236; 73.7804];
    psychoMA{4,21} = [73.8254; 74.1236; 73.8036; 73.1368; 73.833];
    psychoMA{4,22} = [74.4586; 74.3499; 74.5075; 74.4566; 74.4821];
end


% data for (probably) excluded subjects
% if IncAll == 1
%     psychoMA{1,19} = 'hb10';
% %     psychoMA{1,17} = 'jo18';
%     % 25%
%     psychoMA{2,19} = [73.4135, NaN, 0.226, 4, 0.00590;...
%         73.0532, NaN, 0.02, 4, 0.00009; 73.9172, NaN, 0.523, 4, 0.02877;...
%         73.4879, NaN, 0.015, 4, 0.00003; 73.1961, NaN, 0.197, 4, 0.00455];
% %     psychoMA{2,17} = [73.306, 1.7163, 0.157, 4, 0.00293;...
% %         74.0409, 2.1129, 0.213, 4, 0.00527; 73.0862, 2.1536, 0.341, 4, 0.013;...
% %         71.7192, 2.3211, 0.090, 4, 0.00097; 73.9894, 3.1956, 0.451, 4, 0.02191];
%     % 50%
%     psychoMA{3,19} = [74.4033, 1.2967, 0.226, 4, 0.00590;...
%         74.1331, 1.3306, 0.027, 4, 0.00009; 74.7753, 1.32, 0.523, 4, 0.02877;...
%         74.3593, 1.2121, 0.015, 4, 0.00003; 74.2534, 1.3058, 0.197, 4, 0.00455];
% %     psychoMA{3,17} = [76.8587, 1.3356, 0.157, 4, 0.00293;...
% %         77.5519, 1.6221, 0.213, 4, 0.005; 75.5374, 1.5792, 0.341, 4, 0.01302;...
% %         77.7983, 1.8224, 0.090, 4, 0.00097; 78.4963, 2.416, 0.451, 4, 0.02191];
%     % 75%
%     psychoMA{4,19} = [75.3931, NaN, 0.226, 4, 0.00590;
%         75.2129, NaN, 0.027, 4, 0.00009; 75.6335, NaN, 0.523, 4, 0.02877;...
%         75.2307, NaN, 0.015, 4, 0.00003; 75.3107, NaN, 0.197, 4, 0.00455];
% %     psychoMA{4,17} = [80.4114, 1.7163, 0.157, 4, 0.00293;...
% %         81.0628, 2.1129, 0.213, 4, 0.005; 77.9886, 2.1536, 0.31, 4, 0.013;...
% %         83.8774, 2.3211, 0.090, 4, 0.00097; 83.0032, 3.1956, 0.451, 4, 0.022];
% end


%%%             auditory only condition (No Press [np])                 %%%
psychoA{1,1} = 'subject';
psychoA{1,2} = 'ls02';
psychoA{1,3} = 'lw03';
psychoA{1,4} = 'jb04';
psychoA{1,5} = 'mn05';
psychoA{1,6} = 're06';
psychoA{1,7} = 'ev07';
psychoA{1,8} = 'nr08';
psychoA{1,9} = 'sw13';
psychoA{1,10} = 'lf14';
psychoA{1,11} = 'lk15';
psychoA{1,12} = 'sp16';
psychoA{1,13} = 'hr17';
psychoA{1,14} = 'sd19';
psychoA{1,15} = 'nro20';
psychoA{1,16} = 'lb21';
psychoA{1,17} = 'jg22';
psychoA{1,18} = 'al23';

if IncAll == 1
    psychoA{1,19} = 'fs25';
    psychoA{1,20} = 'am26';
    psychoA{1,21} = 'lsc27';
    psychoA{1,22} = 'rg28';
end


psychoA{2,1} = '25% threshold [threshold, SD, chi2, df, p]';
% 1. Zeile: all SOAs (nur 1000)
psychoA{2,2} = [71.1942, 1.9385, 0.357, 4, 0.01413];
psychoA{2,3} = [72.9097, NaN, 0.104, 4, 0.00131];
psychoA{2,4} = [72.7865, NaN, 0.004, 4, 0.00000];
psychoA{2,5} = [74.2203, NaN, 0.017, 4, 0.00003];
psychoA{2,6} = [72.8748, NaN, 0.067, 4, 0.00055];
psychoA{2,7} = [73.5576, NaN, 0.057, 4, 0.00040];
psychoA{2,8} = [73.4663, NaN, 0.005, 4, 0.00000];
psychoA{2,9} = [73.863, NaN, 0.000, 4, 0.00000];
psychoA{2,10} = [72.9642, NaN, 0.086, 4, 0.00089];
psychoA{2,11} = [73.7446, NaN, 0.013, 4, 0.00002];
psychoA{2,12} = [73.3218, NaN, 0.027, 4, 0.00009];
psychoA{2,13} = [73.0214, NaN, 0.006, 4, 0.00000];
psychoA{2,14} = [73.4487, NaN, 0.238, 4, 0.00654];
psychoA{2,15} = [73.0716, NaN, 0.018, 4, 0.00004];
psychoA{2,16} = [72.772, NaN, 0.092, 4, 0.00103];
psychoA{2,17} = [72.1658, NaN, 0.024, 4, 0.00007];
psychoA{2,18} = [73.6827, NaN, 0.008, 4, 0.00001];


if IncAll == 1
    psychoA{2,19} = [73.716];
    psychoA{2,20} = [73.3804];
    psychoA{2,21} = [73.84];
    psychoA{2,22} = [73.2534];
end

psychoA{3,1} = '50% threshold [threshold, SD, chi2, df, p]';
psychoA{3,2} = [72.4443, 1.1557, 0.357, 4, 0.0143];
psychoA{3,3} = [73.3445, 0.9481, 0.104, 4, 0.00131];
psychoA{3,4} = [73.4992, 1.0805, 0.004, 4, 0.00000];
psychoA{3,5} = [74.5705, 0.68219, 0.017, 4, 0.00003];
psychoA{3,6} = [73.2244, 0.62689, 0.067, 4, 0.00055];
psychoA{3,7} = [73.9386, 0.82838, 0.057, 4, 0.00040];
psychoA{3,8} = [74.1052, 1.0735, 0.005, 4, 0.00000];
psychoA{3,9} = [73.9466, 0.20661, 0.000, 4, 0.00000];
psychoA{3,10} = [73.4354, 0.75704, 0.086, 4, 0.00089];
psychoA{3,11} = [74.1991, 0.90622, 0.013, 4, 0.00002];
psychoA{3,12} = [73.9829, 1.094, 0.027, 4, 0.00009];
psychoA{3,13} = [73.5182, 0.90294, 0.006, 4, 0.00000];
psychoA{3,14} = [74.0656, 1.1025, 0.238, 4, 0.00654];
psychoA{3,15} = [73.3593, 0.60982, 0.018, 4, 0.00004];
psychoA{3,16} = [73.7087, 1.264, 0.092, 4, 0.00103];
psychoA{3,17} = [72.9415, 0.90033, 0.024, 4, 0.00007];
psychoA{3,18} = [74.0607, 0.82348, 0.008, 4, 0.00001];

if IncAll == 1
    psychoA{3,19} = [74.2419];
    psychoA{3,20} = [73.7057];
    psychoA{3,21} = [73.9232];
    psychoA{3,22} = [73.6403];
end

psychoA{4,1} = '75% threshold [threshold, SD, chi2, df, p]';
psychoA{4,2} = [73.6944, 1.9385, 0.357, 4, 0.01413];
psychoA{4,3} = [73.7792, NaN, 0.104, 4, 0.00131];
psychoA{4,4} = [74.212, NaN, 0.004,4, 0.00000];
psychoA{4,5} = [74.9207, NaN, 0.017, 4, 0.00003];
psychoA{4,6} = [73.574, NaN, 0.067, 4, 0.00055];
psychoA{4,7} = [74.3196, NaN, 0.057, 4, 0.00040];
psychoA{4,8} = [74.7442, NaN, 0.005, 4, 0.00000];
psychoA{4,9} = [74.0302, NaN, 0.000, 4, 0.00000];
psychoA{4,10} = [73.9066, NaN, 0.086, 4, 0.00089];
psychoA{4,11} = [74.6536, NaN, 0.013, 4, 0.00002];
psychoA{4,12} = [74.6441, NaN, 0.027, 4, 0.00009];
psychoA{4,13} = [74.015, NaN, 0.006, 4, 0.00000];
psychoA{4,14} = [74.6824, NaN, 0.238, 4, 0.00654];
psychoA{4,15} = [73.6472, NaN, 0.018, 4, 0.00004];

psychoA{4,16} = [74.6454, NaN, 0.092, 4, 0.00103];
psychoA{4,17} = [73.7172, NaN, 0.024, 4, 0.00007];
psychoA{4,18} = [74.4386, NaN, 0.008, 4, 0.00001];

if IncAll == 1
    psychoA{4,19} = [74.7678];
    psychoA{4,20} = [74.0309];
    psychoA{4,21} = [74.0064];
    psychoA{4,22} = [74.0272];
end


% % excluded subjects
% if IncAll == 1
%     psychoA{1,19} = 'hb10';% nein
% %     psychoA{1,17} = 'jo18';% nein
%     psychoA{2,19} = [73.8489, NaN, 0.043, 4, 0.00023];
% %     psychoA{2,17} = [71.8792, NaN, 0.174, 4, 0.00359];
%     psychoA{3,19} = [74.3476, 0.99305, 0.043, 4, 0.00023];
% %     psychoA{3,17} = [72.8886, 1.0943, 0.174, 4, 0.00359]; 
%     psychoA{4,19} = [74.8463, NaN, 0.043, 4, 0.00023];
% %     psychoA{4,17} = [73.8981, NaN, 0.174, 4, 0.00359];
% end

% JND
psychoMA{5,1} = 'JND (all, 0, 50, 200, 600)';
for c = 2:length(psychoMA)
    jndAll = (psychoMA{4,c}(1,1) - psychoMA{2,c}(1,1))/2;
    jnd0 = (psychoMA{4,c}(2,1) - psychoMA{2,c}(2,1))/2;
    jnd50 = (psychoMA{4,c}(3,1) - psychoMA{2,c}(3,1))/2;
    jnd200 = (psychoMA{4,c}(4,1) - psychoMA{2,c}(4,1))/2;
    jnd600 = (psychoMA{4,c}(5,1) - psychoMA{2,c}(5,1))/2;
    psychoMA{5,c} = [jndAll, jnd0, jnd50, jnd200, jnd600];
end

psychoA{5,1} = 'JND (all SOAs, 1000)';
for c = 2:length(psychoA)
    jnd1000 = (psychoA{4,c}(1,1) - psychoA{2,c}(1,1))/2;
    psychoA{5,c} = jnd1000;
end

% error trials
psychoMA{6,1} = 'Error trials';
if IncAll == 1
    num = [2:8,13:17,19:23,25:28];
else
    num = [2:8,13:17,19:23];
end

for s = 1:length([psychoMA(1,1:end)])-1
    load(['NOCO_' num2str(num(s)) '_sdapa.mat']);
    es = find([trial.valid] == 0);
    psychoMA{6,s+1} = es;
end

psychoA{6,1} = 'Error trials';

for s = 1:length([psychoMA(1,1:end)])-1
    load(['NOCO_' num2str(num(s)) '_npdapa.mat']);
    ep = find([trial.valid] == 0);
    psychoA{6,s+1} = ep;
end


%%%                 cell with original psychophysics file               %%%
subjects = psychoMA(1,1:end);
subjects{2,1} = 'original MA data';
subjects{2,2} = load("NOCO_ls_s_02_sdapa_1057.mat");
subjects{2,3} = load("NOCO_lw_s_03_sdapa_118.mat");
subjects{2,4} = load("NOCO_jb_s_04_sdapa_1053.mat");
subjects{2,5} = load("NOCO_mn_s_05_sdapa_1135.mat");
subjects{2,6} = load("NOCO_re_s_06_sdapa_1128.mat");
subjects{2,7} = load("NOCO_ev_s_07_sdapa_1644.mat");
subjects{2,8} = load("NOCO_nr_s_08_sdapa_1437.mat");
subjects{2,9} = load("NOCO_sw_s_13_sdapa_1126.mat");
subjects{2,10} = load("NOCO_lf_s_14_sdapa_1650.mat");
subjects{2,11} = load("NOCO_lk_s_15_sdapa_1319.mat");
subjects{2,12} = load("NOCO_sp_s_16_sdapa_1130.mat");
subjects{2,13} = load("NOCO_hr_s_17_sdapa_1821.mat");
subjects{2,14} = load("NOCO_sd_s_19_sdapa_1612.mat");
subjects{2,15} = load("NOCO_nro_s_20_sdapa_115.mat");
subjects{2,16} = load("NOCO_lb_s_21_sdapa_105.mat");
subjects{2,17} = load("NOCO_jg_s_22_sdapa_1035.mat");
subjects{2,18} = load("NOCO_al_s_23_sdapa_1147.mat");

subjects{3,1} = 'original A data';
subjects{3,2} = load("NOCO_ls_np_02_npdapa_1039.mat");
subjects{3,3} = load("NOCO_lw_np_03_npdapa_1052.mat");
subjects{3,4} = load("NOCO_jb_np_04_npdapa_1033.mat");
subjects{3,5} = load("NOCO_mn_np_05_npdapa_1214.mat");
subjects{3,6} = load("NOCO_re_np_06_npdapa_125.mat");
subjects{3,7} = load("NOCO_ev_np_07_npdapa_1720.mat");
subjects{3,8} = load("NOCO_nr_np_08_npdapa_1520.mat");
subjects{3,9} = load("NOCO_sw_np_13_npdapa_1219.mat");
subjects{3,10} = load("NOCO_lf_np_14_npdapa_1628.mat");
subjects{3,11} = load("NOCO_lk_np_15_npdapa_142.mat");
subjects{3,12} = load("NOCO_sp_np_16_npdapa_1116.mat");
subjects{3,13} = load("NOCO_hr_np_17_npdapa_1913.mat");
subjects{3,14} = load("NOCO_sd_np_19_npdapa_1656.mat");
subjects{3,15} = load("NOCO_nro_np_20_npdapa_1047.mat");
subjects{3,16} = load("NOCO_lb_np_21_npdapa_1041.mat");
subjects{3,17} = load("NOCO_jg_np_22_npdapa_1027.mat");
subjects{3,18} = load("NOCO_al_np_23_npdapa_1227.mat");

if IncAll == 1
    subjects{2,19} = load("NOCO_25_sdapa.mat");
    subjects{2,20} = load("NOCO_26_sdapa.mat");
    subjects{2,21} = load("NOCO_27_sdapa.mat");
    subjects{2,22} = load("NOCO_28_sdapa.mat");
    subjects{3,19} = load("NOCO_25_npdapa.mat");
    subjects{3,20} = load("NOCO_26_npdapa.mat");
    subjects{3,21} = load("NOCO_27_npdapa.mat");
    subjects{3,22} = load("NOCO_28_npdapa.mat");
end

% if IncAll == 1
%     subjects{1,16} = 'hb10';
%     subjects{2,16} = load("NOCO_10_sdapa.mat");
%     subjects{3,16} = load("NOCO_10_npdapa.mat");
%     subjects{1,17} = 'jo18';
%     subjects{2,17} = load("NOCO_jo_s_18_sdapa_1548.mat");
%     subjects{3,17} = load("NOCO_jo_np_18_npdapa_1529.mat");
% end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% --------- Probandendaten (Alter, Händigkeit, gender) -------------- %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% demographic data of subjects: age, handedness, gender

subjects{4,1} = 'age';
subjects{5,1} = 'hand';
subjects{6,1} = 'gender';
for sb = 1:Nsub
    subjects{4,sb+1} = subjects{2,sb+1}.mainvar.age;
    subjects{5,sb+1} = subjects{2,sb+1}.mainvar.hand;
    subjects{6,sb+1} = subjects{2,sb+1}.mainvar.gender;
end

% age
min([subjects{4,2:end}]) % 21
max([subjects{4,2:end}]) % 51
mean([subjects{4,2:end}]) % 26.9412 +GP: 26.6667
median([subjects{4,2:end}]) % 25 +GP: 25
std([subjects{4,2:end}]) % 6.6659 +GP: 6.0277

% # right-handend
sum(strcmp(subjects(5,2:end),'r')) % 17, +GP: 21

% # males
sum(strcmp(subjects(6,2:end),'m')) % 4; +GP: 5



%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%               1.1 psychometric curves for each subject              %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% red: external (auditory only), blue: self: motor-auditory (only SOA 0)
% for loop through subjects --> everyone gets own figure

clear answers
clear tone2

dBSPL = [72, 73, 74, 75, 76]; % different intensity levels
if IncAll == 1
    names = [2:8, 13:17, 19:23, 25:28];
else
    names = [2:8,13:17,19:23,25]; % subject number
end

for sb = 18:Nsub
    clear data
    [data{1,2:3}] = deal('MA', 'A');
    
    % raw data
    data{2,1} = 'raw data';
    data{2,2} = load(['NOCO_' num2str(names(sb)) '_sdapa.mat']);
    data{2,3} = load(['NOCO_' num2str(names(sb)) '_npdapa.mat']);
    
    % loudness answer: 1 = 1. tone louder, 2 = 2. tone louder
    [data{3,1:3}] = deal('answer', data{2,2}.mainvar.data.respComp(data{2,2}.mainvar.data.SOA == 0),...
        data{2,3}.mainvar.data.respComp);

    % intensity of second tone ("tone2")
    [data{4,1:3}] = deal('dBSPL 2.tone', [data{2,2}.trial(data{2,2}.mainvar.data.SOA == 0).level], [data{2,3}.trial.level]);
    
    % how often that tone was played
    data{5,1} = '# of that 2.tone played';
    data{5,2} = [sum([data{4,2}]==72),sum([data{4,2}]==73),sum([data{4,2}]==74),...
        sum([data{4,2}]==75),sum([data{4,2}]==76)];
    data{5,3} = [sum([data{4,3}]==72),sum([data{4,3}]==73),sum([data{4,3}]==74),...
        sum([data{4,3}]==75),sum([data{4,3}]==76)];
    

    % number how often 2.tone with that loudness was judged louder (5
    % entries for 5 dBSPL)
    [data{6,1:3}] = deal('# of that 2.tone judged louder', zeros(1,5), zeros(1,5));
    
    for con = 2:3
        for t1 = 1:length(data{4,con})
            if data{3,con}(t1) == 2 % 2. Ton judged louder
                if data{4,con}(t1) == 72
                    data{6,con}(1) = data{6,con}(1) + 1;
                elseif data{4,con}(t1) == 73
                    data{6,con}(2) = data{6,con}(2) + 1;
                elseif data{4,con}(t1) == 74
                    data{6,con}(3) = data{6,con}(3) + 1;
                elseif data{4,con}(t1) == 75
                    data{6,con}(4) = data{6,con}(4) + 1;
                elseif data{4,con}(t1) == 76
                    data{6,con}(5) = data{6,con}(5) + 1;
                end
            end
        end
    end
    
    % proportion of 2.tone louder
    [data{7,1:3}] = deal('louder2proportion', data{6,2}./data{5,2}, data{6,3}./data{5,3});
    
    % normal cumulative distribution
    % dBSPL = independent variable
    MA_xMin = min([data{4,2}]);
    MA_xMax = max([data{4,2}]);
    MA_xtones = MA_xMin-1:((MA_xMax-MA_xMin)/200):MA_xMax+1;
    MA_xpos = psychoMA{3,sb+1}(2); % PSE, nur SOA 0
    MA_sigma = psychoMA{5,sb+1}(2)*1.4851; % JND, nur SOA 0

    A_xMin = min([data{4,3}]);
    A_xMax = max([data{4,3}]);
    A_xtones = MA_xMin-1:((MA_xMax-MA_xMin)/200):MA_xMax+1;
    A_xpos = psychoA{3,sb+1}(1);
    A_sigma = psychoA{5,sb+1}(1)*1.4851;

    MA_dist = cdf('Normal', MA_xtones, MA_xpos, MA_sigma);
    A_dist = cdf('Normal', A_xtones, A_xpos, A_sigma);

    figure
    hold on
    plot(A_xtones, A_dist, 'Color', [255/255, 50/255, 50/255], 'LineWidth', 2) % distribution auditory-only
    scatter(dBSPL, data{7,3}, 'MarkerEdgeColor', [255/255, 50/255, 50/255],'LineWidth', 1) % measurements A
    plot(MA_xtones, MA_dist, 'Color', [21/255, 45/255, 255/255],'LineWidth', 2) % distribution MA
    scatter(dBSPL, data{7,2}, 'MarkerEdgeColor', [21/255, 45/255, 255/255],'LineWidth', 1) % measurements MA
   
    % indicator lines PSE
    if A_xpos > MA_xpos
        plot([70, A_xpos],[0.5, 0.5], 'Color', [153/255, 153/255, 153/255], 'LineStyle','--')
    elseif MA_xpos > A_xpos
        plot([70, MA_xpos],[0.5, 0.5], 'Color', [153/255, 153/255, 153/255], 'LineStyle','--')
    end
    plot([A_xpos, A_xpos],[0, 0.5], 'Color', [255/255, 50/255, 50/255],'LineStyle','--')
    plot([MA_xpos, MA_xpos],[0, 0.5], 'Color', [21/255, 45/255, 255/255], 'LineStyle','--')
    
    % figure properties
    ylim([0 1])
    xlim([71.5, 76.5])
    xticks(72:76)
    xlabel('intensity of 2. tone [dB SPL]')
    ylabel('proportion of 2. tone > 1. tone')
    %legend({'Auditory-Only', 'measured data', 'Motor-Auditory', 'measured data'}, 'LineWidth', 1, 'FontSize',10, 'Location','southeast')
    ttl = ['psychometric curve for subject ' num2str(names(sb))];
    title(ttl)
    legend({'Auditory-Only', 'measured data', 'Motor-Auditory', 'measured data'}, 'LineWidth', 1, 'FontSize',10, 'Location','southeast')
    ax = gca;
    ax.LineWidth = 1.5;
    ax.FontWeight = 'bold';
    ax.FontSize = 10;

    % save figure in Figures folder
    cd("../Figures")
    saveas(gcf, [ttl '.png'])
    cd("../Psycho")
    
    psych.(['s' num2str(sb)]) = data;

%%%            test curves for goodness of fit (Chi² test)              %%%

    disp(sb)
    bins = 72:76;
    foundma = data{7,2}; % actual proportions
    founda = data{7,3};
    expma = MA_dist(find(MA_xtones == 72 | MA_xtones == 73 | MA_xtones == 74 | MA_xtones == 75 | MA_xtones == 76)); % proportions calculated by fit
    expa = A_dist(find(A_xtones == 72 | A_xtones == 73 | A_xtones ==74 | A_xtones ==75 | A_xtones ==76));
    [hm,pm,statm] = chi2gof(bins,'Frequency', foundma, 'Expected', expma)
    [ha,pa,stata] = chi2gof(bins,'Frequency', founda, 'Expected', expa)
end
% H0 = distribution fits data
% p >0.05, h = 0 --> das was wir wollen

% axes: 1.5




%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   ----------------------- 1.2 PSE, JND -------------------------------  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ----------- PSE, JND between conditions (MA vs. A) ------------------ %%%

% extract PSE, JND overall, for each SOA, for A from Psycho_MA/Psycho_A
PSE_MA = zeros(1,Nsub); % for each subject overall PSE
PSE0_MA = zeros(1,Nsub); % for each subject PSE at SOA 0
PSE50_MA = zeros(1,Nsub); % for each subject PSE at SOA 50
PSE200_MA = zeros(1,Nsub); % for each subject PSE at SOA 200
PSE600_MA = zeros(1,Nsub); % for each subject PSE at SOA 600
PSE_A = zeros(1,Nsub); % for each subject PSE in auditory-only

JND_MA = zeros(1, Nsub); % for each subject overall JND
JND_A = zeros(1, Nsub); % for each subject JND in auditory-only
JND0_MA = zeros(1, Nsub); % for each subject JND at SOA 0
JND50_MA = zeros(1, Nsub); % for each subject JND at SOA 50
JND200_MA = zeros(1, Nsub); % for each subject JND at SOA 200
JND600_MA = zeros(1, Nsub); % for each subject JND at SOA 600

for s = 1:length(PSE_MA)
    PSE_MA(1, s) = psychoMA{3,s+1}(1,1);
    PSE_A(1, s) = psychoA{3,s+1}(1,1);

    PSE0_MA(1, s) = psychoMA{3,s+1}(2,1);
    PSE50_MA(1, s) = psychoMA{3,s+1}(3,1);
    PSE200_MA(1, s) = psychoMA{3,s+1}(4,1);
    PSE600_MA(1, s) = psychoMA{3,s+1}(5,1);

    JND_MA(1, s) = psychoMA{5,s+1}(1,1);
    JND_A(1, s) = psychoA{5,s+1}(1,1);

    JND0_MA(1, s) = psychoMA{5,s+1}(1,2);
    JND50_MA(1, s) = psychoMA{5,s+1}(1,3);
    JND200_MA(1, s) = psychoMA{5,s+1}(1,4);
    JND600_MA(1, s) = psychoMA{5,s+1}(1,5);
end



%%%%% -------------- SOA 0 vs. auditory-only ----------------------- %%%%%%

% Hypothese:
%   - own tone (MA) to be attenuated 
%   --> PSE lower for SOA 0 than for Auditory-only


%   ---------- KORREKTUR NACH MASSON & LOFTUS 2003 ----------------
%   --> Varianz von einzelnen Probanden rausgerechnet
%   - Subject Mean: MW innerhalb Probanden über SOA 0 und auditory-only
%   - Grand Mean: MW über Subject Mean

% --> data corrected for inter subject variance (some people in general
% higher / lower values than other, but we are interested in relative
% difference between conditions)

com_0A = psychoMA(1,1:end);
com_0A{14,1} = 'JND';

% subject means
com_0A{2,1} = 'SM';
com_0A{15,1} = 'SM';
for sb = 1: size(com_0A,2)-1 % -1, weil erste Spalte nur Titel
    com_0A{2,sb+1} = mean([PSE0_MA(sb), PSE_A(sb)]); % PSE
    com_0A{15,sb+1} = mean([JND0_MA(sb), JND_A(sb)]); % JND
end

% grand mean
com_0A{3,1} = 'GM'; % PSE
com_0A{3,2} = mean([com_0A{2,2:end}]);
com_0A{16,1} = 'GM'; % JND
com_0A{16,2} = mean([com_0A{15,2:end}]);

% mean difference
com_0A{4,1} = 'SM - GM';
com_0A{17,1} = 'SM - GM';
for sb = 2: size(com_0A,2)
    com_0A{4,sb} = com_0A{2,sb} - com_0A{3,2}; % PSE
    com_0A{17,sb} = com_0A{15,sb} - com_0A{16,2}; % JND
end

% corrected single measurements
com_0A{5,1} = 'Corr SOA 0'; % PSE
com_0A{6,1} = 'Corr A';
com_0A{18,1} = 'Corr SOA 0'; % JND
com_0A{19,1} = 'Corr A';
for sb = 1:size(com_0A,2)-1
    com_0A{5,sb+1} = PSE0_MA(sb) - com_0A{4,sb+1};
    com_0A{6,sb+1} = PSE_A(sb) - com_0A{4,sb+1};

    com_0A{18,sb+1} = JND0_MA(sb) - com_0A{17,sb+1};
    com_0A{19,sb+1} = JND_A(sb) - com_0A{17,sb+1};
end

% mean, SD, SEM for each condition
% PSE
com_0A{7,1} = 'SOA 0 (Mean, SD, SEM)';
com_0A{8,1} = 'A (Mean, SD, SEM)';

com_0A{7,2} = mean([com_0A{5,2:end}]);
com_0A{8,2} = mean([com_0A{6,2:end}]);

com_0A{7,3} = std([com_0A{5,2:end}]);
com_0A{8,3} = std([com_0A{6,2:end}]);

com_0A{7,4} = std([com_0A{5,2:end}])/sqrt(length([com_0A{5,2:end}]));
com_0A{8,4} = std([com_0A{6,2:end}])/sqrt(length([com_0A{6,2:end}]));

% JND
com_0A{20,1} = 'SOA 0 (Mean, SD, SEM)';
com_0A{21,1} = 'A (Mean, SD, SEM)';

com_0A{20,2} = mean([com_0A{18,2:end}]);
com_0A{21,2} = mean([com_0A{19,2:end}]);

com_0A{20,3} = std([com_0A{18,2:end}]);
com_0A{21,3} = std([com_0A{19,2:end}]);

com_0A{20,4} = std([com_0A{18,2:end}])/sqrt(length([com_0A{18,2:end}]));
com_0A{21,4} = std([com_0A{19,2:end}])/sqrt(length([com_0A{19,2:end}]));


% Shapiro-Wilk Test auf Normalverteilung (alpha = 0.01), Paardifferenz wird
% getestet (pro subject differenz zwischen bedingungen, die testen)
% bei ANOVA müssen residuals danach getestet werden
[H,shap,~] = swtest([PSE0_MA - PSE_A], 0.01); % p = 0.9964 --> normalverteilt, t-test
[H,shap,~] = swtest([JND0_MA - JND_A], 0.01); % p = 0.2939 --> normalverteilt, t-test

% t-test
% PSE
com_0A{10,1} = 't-tests';
com_0A{10,2} = 'h';
com_0A{10,3} = 'p';
com_0A{10,4} = 'stats';
com_0A{11,1} = 'MA < A (left)';
com_0A{12,1} = 'MA > A (right)';
[com_0A{11,2}, com_0A{11,3}, ~, com_0A{11,4}] = ttest(PSE0_MA, PSE_A, 'Tail', 'left');
[com_0A{12,2}, com_0A{12,3}, ~, com_0A{12,4}] = ttest(PSE0_MA, PSE_A, 'Tail', 'right');
d = [PSE0_MA - PSE_A];
[h,p] = ttest(d,0,'Tail','right') % hier Differenz direkt gegen 0 getestet, bei 2 Eingaben würde ttest auch erst Differenz bilden
[h,p,~,stats] = ttest(PSE0_MA, PSE_A) % p = 0.024, tstat = 2.49, df = 16


% JND
com_0A{23,1} = 't-tests';
com_0A{23,2} = 'h';
com_0A{23,3} = 'p';
com_0A{23,4} = 'stats';
com_0A{24,1} = 'MA < A (left)';
com_0A{25,1} = 'MA > A (right)';
[com_0A{24,2}, com_0A{24,3}, ~, com_0A{24,4}] = ttest(JND0_MA, JND_A, 'Tail', 'left');
[com_0A{25,2}, com_0A{25,3}, ~, com_0A{25,4}] = ttest(JND0_MA, JND_A, 'Tail', 'right');
[h,p, ~, stats] = ttest(JND0_MA, JND_A) % p = 0.21, tstat = -1.299, df = 16

[com_0A{27,1:2}] = deal('signtest both', signtest(JND0_MA, JND_A));
[com_0A{28,1:2}] = deal('signtest left', signtest(JND0_MA, JND_A, 'Tail','right'));

% sign rank test (Wilcoxon) statt signtest --> sehr wahrscheinlich
% sensitiver
p = signrank(JND0_MA, JND_A) % 0.41


%%% --------------------------- figures ------------------------------- %%%
% PSE
figure()
hold on
rectangle('Position', [0.5, (com_0A{8,2} - com_0A{8,4}), 1, (com_0A{8,4} + com_0A{8,4})], 'FaceColor',  [255/255, 50/255, 50/255], 'EdgeColor', 'none')% SEM Kasten für A
plot([0.5, 1.5], [com_0A{8,2}, com_0A{8,2}], 'k', 'LineWidth',1) % mean SOA A
rectangle('Position', [2.5, (com_0A{7,2} - com_0A{7,4}), 1, (com_0A{7,4} + com_0A{7,4})], 'FaceColor', [21/255, 45/255, 255/255], 'EdgeColor', 'none') % SEM Kasten für SOA 0
plot([2.5, 3.5], [com_0A{7,2}, com_0A{7,2}], 'k', 'LineWidth',1) % mean SOA 0

xlim([0, 4])
ylim([73.5, 74.5])
ylabel('mean PSE [db SPL]')
xticks([1, 3])
xticklabels({'Auditory-Only', 'Motor-Auditory (SOA 0)'})
xlabel('condition')
%title('comparison of PSE between conditions')

cd('../Figures')
saveas(gcf, 'PSE_MAvsA_notitle.png')


% JND
figure()
hold on
rectangle('Position', [0.5, (com_0A{21,2} - com_0A{21,4}), 1, (com_0A{21,4} + com_0A{21,4})], 'FaceColor', [255/255, 50/255, 50/255], 'EdgeColor', 'none') % SEM Kasten für A
plot([0.5, 1.5], [com_0A{21,2}, com_0A{21,2}], 'k','LineWidth',1) % mean A
rectangle('Position', [2.5, (com_0A{20,2} - com_0A{20,4}), 1, (com_0A{20,4} + com_0A{20,4})], 'FaceColor', [21/255,45/255,255/255], 'EdgeColor', 'none') % SEM Kasten für SOA 0
plot([2.5, 3.5], [com_0A{20,2}, com_0A{20,2}], 'k','LineWidth',1) % mean SOA 0
xlim([0, 4])
ylim([0, 1])
ylabel('mean JND')
xticks([1, 3])
xticklabels({'Auditory-Only', 'Motor-Auditory (SOA 0)'})
xlabel('condition')
%title('comparison of JND between conditions')

saveas(gcf, 'JND_MAvsA_notitle.png')
cd('../Psycho')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  --------  Mean psychometric function across all subjects  ------   %%%
% normal cumulative distribution
% dBSPL = independent variable
MA_xMin = 72;
MA_xMax = 76;
MA_xtones = MA_xMin-1:((MA_xMax-MA_xMin)/200):MA_xMax+1;
MA_xpos = com_0A{7,2}; % PSE, nur SOA 0
MA_sigma = com_0A{20,2}*1.4851; % JND, nur SOA 0

A_xMin = 72;
A_xMax = 76;
A_xtones = MA_xMin-1:((MA_xMax-MA_xMin)/200):MA_xMax+1;
A_xpos = com_0A{8,2};
A_sigma = com_0A{21,2}*1.4851;

MA_dist = cdf('Normal', MA_xtones, MA_xpos, MA_sigma);
A_dist = cdf('Normal', A_xtones, A_xpos, A_sigma);

totalcount = zeros(2,5);
totallouder = zeros(2,5);
for sb = 1:Nsub
    for int = 1:5
        totalcount(1,int) = totalcount(1,int) + psych.(['s' num2str(sb)]){5,2}(int);
        totalcount(2,int) = totalcount(2,int) + psych.(['s' num2str(sb)]){5,3}(int);
        totallouder(1,int) = totallouder(1,int) + psych.(['s' num2str(sb)]){6,2}(int);
        totallouder(2,int) = totallouder(2,int) + psych.(['s' num2str(sb)]){6,3}(int);
    end
end
totalprops = totallouder./totalcount;

figure
hold on
plot(A_xtones, A_dist, 'Color', [255/255, 50/255, 50/255],'LineWidth', 2) % distribution auditory-only
scatter(dBSPL, totalprops(2,:), 'MarkerEdgeColor', [255/255, 50/255, 50/255],'LineWidth',1) % measurements A
plot(MA_xtones, MA_dist, 'Color', [21/255, 45/255, 255/255], 'LineWidth', 2) % distribution MA
scatter(dBSPL, totalprops(1,:), 'MarkerEdgeColor', [21/255, 45/255, 255/255],'LineWidth',1) % measurements MA

% indicator lines PSE
if A_xpos > MA_xpos
    plot([70, A_xpos],[0.5, 0.5], 'Color', [153/255, 153/255, 153/255],  'LineStyle','--')
elseif MA_xpos > A_xpos
    plot([70, MA_xpos],[0.5, 0.5], 'Color', [153/255, 153/255, 153/255], 'LineStyle','--')
end
plot([A_xpos, A_xpos],[0, 0.5], 'Color', [255/255, 50/255, 50/255],'LineStyle','--')
plot([MA_xpos, MA_xpos],[0, 0.5], 'Color', [21/255, 45/255, 255/255], 'LineStyle','--')
    
% figure properties
ylim([0 1])
xlim([71.5, 76.5])
xticks(72:76)
xlabel('intensity of 2. tone [dB SPL]')
ylabel('proportion of 2. tone > 1. tone')
%legend({'Auditory-Only', 'measured data', 'Motor-Auditory', 'measured data'}, 'Location','southeast')
title('mean psychometric curve for all subjects')
legend({'Auditory-Only', 'measured data', 'Motor-Auditory', 'measured data'}, 'LineWidth', 1, 'FontSize',10, 'Location','southeast')
ax = gca;
ax.LineWidth = 1.5;
ax.FontWeight = 'bold';
ax.FontSize = 10;
saveas(gcf, 'psychometric_function_AllSubjects.png')




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  --------- SOAs untereinander vergleichen (figure 5)  ------------  %%%

% Hypothese:
%   - less attenuation with longer delays
%   --> the shorter SOA, the lower PSE

% - pro subject 1 PSE for each SOA
% - Subject Mean: 1 PSE per subject over all SOAs

% - repeated measures Anova (SOA Faktor, PSE Variable)
% - post-hoc t-tests (not evaluated/used yet, because no correction for
% repeated measures)

com_SOAs = psychoMA(1,:);
com_SOAs{2,1} = 'PSE';
com_SOAs{29,1} = 'JND';

% subject mean
com_SOAs{3,1} = 'SM';
com_SOAs{30,1} = 'SM';
for sb = 1: size(com_SOAs, 2)-1
    com_SOAs{3,sb+1} = mean([PSE0_MA(sb), PSE50_MA(sb), PSE200_MA(sb), PSE600_MA(sb)]);
    com_SOAs{30,sb+1} = mean([JND0_MA(sb), JND50_MA(sb), JND200_MA(sb), JND600_MA(sb)]);
end


% grand mean
com_SOAs{4,1} = 'GM';
com_SOAs{4,2} = mean([com_SOAs{3,2:end}]);

com_SOAs{31,1} = 'GM';
com_SOAs{31,2} = mean([com_SOAs{30,2:end}]);


% mean difference (SM - GM)
com_SOAs{5,1} = 'SM - GM';
com_SOAs{32,1} = 'SM - GM';
for sb = 2: size(com_SOAs, 2)
    com_SOAs{5,sb} = com_SOAs{3, sb} - com_SOAs{4,2};
    com_SOAs{32,sb} = com_SOAs{30, sb} - com_SOAs{31,2};
end


% corrected measurements for each subject and each SOA
[com_SOAs{6:9,1}] = deal('corr SOA 0', 'corr SOA 50', 'corr SOA 200', 'corr SOA 600');
[com_SOAs{33:36,1}] = deal('corr SOA 0', 'corr SOA 50', 'corr SOA 200', 'corr SOA 600');

for sb = 1: size(com_SOAs, 2)-1
    com_SOAs{6,sb+1} = PSE0_MA(sb) - com_SOAs{5,sb+1};
    com_SOAs{7,sb+1} = PSE50_MA(sb) - com_SOAs{5,sb+1};
    com_SOAs{8,sb+1} = PSE200_MA(sb) - com_SOAs{5,sb+1};
    com_SOAs{9,sb+1} = PSE600_MA(sb) - com_SOAs{5,sb+1};

    com_SOAs{33,sb+1} = JND0_MA(sb) - com_SOAs{32,sb+1};
    com_SOAs{34,sb+1} = JND50_MA(sb) - com_SOAs{32,sb+1};
    com_SOAs{35,sb+1} = JND200_MA(sb) - com_SOAs{32,sb+1};
    com_SOAs{36,sb+1} = JND600_MA(sb) - com_SOAs{32,sb+1};
end


% mean, STD, SEM for each SOA
[com_SOAs{10,2:4}] = deal('Mean', 'SD', 'SEM');
[com_SOAs{11:14,1}] = deal('SOA 0', 'SOA 50', 'SOA 200', 'SOA 600');

[com_SOAs{37,2:4}] = deal('Mean', 'SD', 'SEM');
[com_SOAs{38:41,1}] = deal('SOA 0', 'SOA 50', 'SOA 200', 'SOA 600');

% mean
[com_SOAs{11:14, 2}] = deal(mean([com_SOAs{6, 2:end}]), mean([com_SOAs{7, 2:end}]), ...
    mean([com_SOAs{8, 2:end}]), mean([com_SOAs{9, 2:end}]));
[com_SOAs{38:41, 2}] = deal(mean([com_SOAs{33, 2:end}]), mean([com_SOAs{34, 2:end}]), ...
    mean([com_SOAs{35, 2:end}]), mean([com_SOAs{36, 2:end}]));

% sd
[com_SOAs{11:14, 3}] = deal(std([com_SOAs{6, 2:end}]), std([com_SOAs{7, 2:end}]), ...
    std([com_SOAs{8, 2:end}]), std([com_SOAs{9, 2:end}]));
[com_SOAs{38:41, 3}] = deal(std([com_SOAs{33, 2:end}]), std([com_SOAs{34, 2:end}]), ...
    std([com_SOAs{35, 2:end}]), std([com_SOAs{36, 2:end}]));

% sem
[com_SOAs{11:14, 4}] = deal(std([com_SOAs{6, 2:end}])/sqrt(length([com_SOAs{6, 2:end}])), ...
    std([com_SOAs{7, 2:end}])/sqrt(length([com_SOAs{7, 2:end}])), ...
    std([com_SOAs{8, 2:end}])/sqrt(length([com_SOAs{8, 2:end}])), ...
    std([com_SOAs{9, 2:end}])/sqrt(length([com_SOAs{9, 2:end}])));
[com_SOAs{38:41, 4}] = deal(std([com_SOAs{33, 2:end}])/sqrt(length([com_SOAs{33, 2:end}])), ...
    std([com_SOAs{34, 2:end}])/sqrt(length([com_SOAs{34, 2:end}])), ...
    std([com_SOAs{35, 2:end}])/sqrt(length([com_SOAs{35, 2:end}])), ...
    std([com_SOAs{36, 2:end}])/sqrt(length([com_SOAs{36, 2:end}])));


% one-way repeated measures Anova
% 1 Faktor = SOA, dependent variable = PSE (JND)
%          X - data matrix (Size of matrix must be n-by-3;dependent variable=column 1,
%              independent variable=column 2;subject=column 3). 
%      alpha - significance level (default = 0.05).

% Kruskal-Wallis mit standardisierten Werten

% Test auf Normalverteilung für jede condition (mit standardisierten
% Werten)
% PSE
[H, shap0, ~] = swtest([com_SOAs{6, 2:end}],0.01) % p = 0.81
[H, shap5, ~] = swtest([com_SOAs{7, 2:end}],0.01) % p = 0.11
[H, shap2, ~] = swtest([com_SOAs{8, 2:end}],0.01) % p = 0.47
[H, shap6, ~] = swtest([com_SOAs{9, 2:end}],0.01) % p = 0.03 -> n.s. da p>0.01
% -> normalverteilt -> ANOVA
% JND
[H, shap0, ~] = swtest([com_SOAs{33, 2:end}],0.01) % p = 0.36
[H, shap5, ~] = swtest([com_SOAs{34, 2:end}],0.01) % p = 0.98
[H, shap2, ~] = swtest([com_SOAs{35, 2:end}],0.01) % p = 0.46
[H, shap6, ~] = swtest([com_SOAs{36, 2:end}],0.01) % p = 0.13
% -> normalverteilt -> Anova

% one-way repeated measures ANOVA (script from Axel)
com_SOAs{16,1} = 'RANOVA';
com_SOAs{43,1} = 'RANOVA';

X_PSE = zeros((4*(size(com_SOAs,2)-1)),3);
X_PSE(:,1) = [PSE0_MA'; PSE50_MA'; PSE200_MA'; PSE600_MA']; % uncorrected measurements
X_PSE(:,2) = [ones(size(com_SOAs,2)-1,1); ones(size(com_SOAs,2)-1,1)*2; ones(size(com_SOAs,2)-1,1)*3; ones(size(com_SOAs,2)-1,1)*4]; % SOA
X_PSE(:,3) = [(1:Nsub)'; (1:Nsub)'; (1:Nsub)'; (1:Nsub)']; % subject, beginning with 1

X_JND = zeros((4*(size(com_SOAs,2)-1)),3);
X_JND(:,1) = [JND0_MA'; JND50_MA'; JND200_MA'; JND600_MA']; % uncorrected measurements
X_JND(:,2) = [ones(size(com_SOAs,2)-1,1); ones(size(com_SOAs,2)-1,1)*2; ones(size(com_SOAs,2)-1,1)*3; ones(size(com_SOAs,2)-1,1)*4]; % SOA
X_JND(:,3) = [(1:Nsub)'; (1:Nsub)'; (1:Nsub)'; (1:Nsub)']; % subject, beginning with 1

alpha = 0.05;

disp('PSE');
RMAOV1(X_PSE,alpha)

disp('JND');
RMAOV1(X_JND,alpha)

[com_SOAs{16,2:4}] = deal('df (IV, Error)', 'F', 'p'); % IV = independent variable
[com_SOAs{17,2:4}] = deal([3, 48], 6.381, 0.0010);

[com_SOAs{43,2:4}] = deal('df (IV, Error)', 'F', 'p'); % IV = independent variable
[com_SOAs{44,2:4}] = deal([3, 48], 2.557, 0.0661);


% post-hoc t-tests
% two-tailed paired-sampled t-tests
% PSE
[com_SOAs{19,1:4}] = deal('Post-hoc t-tests', 'h', 'p', 'stats (tstat, df, sd)');
[com_SOAs{20:25, 1}] = deal('0ms vs. 50ms','0ms vs. 200ms','0ms vs. 600ms','50ms vs. 200ms','50ms vs. 600ms','200ms vs. 600ms'); 
% 1) 0ms vs. 50ms
[com_SOAs{20,2}, com_SOAs{20,3}, ~, com_SOAs{20,4}] = ttest(PSE0_MA, PSE50_MA);
% 2) 0ms vs. 200ms
[com_SOAs{21,2}, com_SOAs{21,3}, ~, com_SOAs{21,4}] = ttest(PSE0_MA, PSE200_MA);
% 3) 0ms vs. 600ms
[com_SOAs{22,2}, com_SOAs{22,3}, ~, com_SOAs{22,4}] = ttest(PSE0_MA, PSE600_MA);
% 4) 50ms vs. 200ms
[com_SOAs{23,2}, com_SOAs{23,3}, ~, com_SOAs{23,4}] = ttest(PSE50_MA, PSE200_MA);
% 5) 50ms vs. 600ms
[com_SOAs{24,2}, com_SOAs{24,3}, ~, com_SOAs{24,4}] = ttest(PSE50_MA, PSE600_MA);
% 6) 200ms vs. 600ms
[com_SOAs{25,2}, com_SOAs{25,3}, ~, com_SOAs{25,4}] = ttest(PSE200_MA, PSE600_MA);

% Bonferroni-Korrektur für p-Wert: a = 0.05/(# Tests)
[com_SOAs{26,[1,3]}] = deal('Bonferroni-p', 0.05/6);

% linear regression (Test ob es linearen Zusammenhang gibt)
y = [];
x = [];
for sb = 1:Nsub
    y = vertcat(y, [com_SOAs{6:9,sb+1}]');
    x = vertcat(x, [[1:4]',ones(4,1)]);
end
[~, ~, ~, ~, stats] = regress(y,x)
% stats:
% R² = 0.1764, F = 14.13, p = 0.0004, error variance = 0.043

%%%% SPSS export
% rows = subjects, column = SOA, value = PSE
soapse = [PSE0_MA',PSE50_MA',PSE200_MA',PSE600_MA'];
varnames={'S0','S50','S200','S600'};
save4spss(soapse,varnames,'SOAvsPSE.dat')

% JND
[com_SOAs{46,1:4}] = deal('Post-hoc t-tests', 'h', 'p', 'stats (tstat, df, sd)');
[com_SOAs{47:52, 1}] = deal('0ms vs. 50ms','0ms vs. 200ms','0ms vs. 600ms','50ms vs. 200ms','50ms vs. 600ms','200ms vs. 600ms'); 
% 1) 0ms vs. 50ms
[com_SOAs{47,2}, com_SOAs{47,3}, ~, com_SOAs{47,4}] = ttest(JND0_MA, JND50_MA);
% 2) 0ms vs. 200ms
[com_SOAs{48,2}, com_SOAs{48,3}, ~, com_SOAs{48,4}] = ttest(JND0_MA, JND200_MA);
% 3) 0ms vs. 600ms
[com_SOAs{49,2}, com_SOAs{49,3}, ~, com_SOAs{49,4}] = ttest(JND0_MA, JND600_MA);
% 4) 50ms vs. 200ms
[com_SOAs{50,2}, com_SOAs{50,3}, ~, com_SOAs{50,4}] = ttest(JND50_MA, JND200_MA);
% 5) 50ms vs. 600ms
[com_SOAs{51,2}, com_SOAs{51,3}, ~, com_SOAs{51,4}] = ttest(JND50_MA, JND600_MA);
% 6) 200ms vs. 600ms
[com_SOAs{52,2}, com_SOAs{52,3}, ~, com_SOAs{52,4}] = ttest(JND200_MA, JND600_MA);

% Bonferroni-Korrektur für p-Wert: a = 0.05/(# Tests)
[com_SOAs{53,[1,3]}] = deal('Bonferroni-p', 0.05/6);


% figures
% PSE
figure()
hold on
rectangle('Position', [0.5, (com_SOAs{11,2}-com_SOAs{11,4}), 1, (com_SOAs{11,4}+com_SOAs{11,4})], 'FaceColor',[128/255,201/255,255/255], 'EdgeColor','none')
plot([0.5, 1.5], [com_SOAs{11,2}, com_SOAs{11,2}], 'k','LineWidth',1) % SOA 0
rectangle('Position', [2.5, (com_SOAs{12,2}-com_SOAs{12,4}), 1, (com_SOAs{12,4}+com_SOAs{12,4})], 'FaceColor',[128/255,201/255,255/255], 'EdgeColor','none')
plot([2.5, 3.5], [com_SOAs{12,2}, com_SOAs{12,2}], 'k','LineWidth',1) % SOA 50
rectangle('Position', [4.5, (com_SOAs{13,2}-com_SOAs{13,4}), 1, (com_SOAs{13,4}+com_SOAs{13,4})], 'FaceColor',[128/255,201/255,255/255], 'EdgeColor','none')
plot([4.5, 5.5], [com_SOAs{13,2}, com_SOAs{13,2}], 'k','LineWidth',1) % SOA 200
rectangle('Position', [6.5, (com_SOAs{14,2}-com_SOAs{14,4}), 1, (com_SOAs{14,4}+com_SOAs{14,4})], 'FaceColor',[128/255,201/255,255/255], 'EdgeColor','none')
plot([6.5, 7.5], [com_SOAs{14,2}, com_SOAs{14,2}], 'k','LineWidth',1) % SOA 600

ylim([73.5, 74.5])
ylabel('mean PSE [db SPL]')
xlim([0,8])
xticks([1, 3, 5, 7])
xticklabels({'0', '50', '200', '600'})
xlabel('SOA [ms]')
%title('PSE separated for SOAs')

cd('../Figures')
saveas(gcf, 'PSE_SOAs_notitle.png')

% JND
figure()
hold on
rectangle('Position', [0.5, (com_SOAs{38,2}-com_SOAs{38,4}), 1, (com_SOAs{38,4}+com_SOAs{38,4})], 'FaceColor',[128/255,201/255,255/255], 'EdgeColor','none')
plot([0.5, 1.5], [com_SOAs{38,2}, com_SOAs{38,2}], 'k','LineWidth',1) % SOA 0
rectangle('Position', [2.5, (com_SOAs{39,2}-com_SOAs{39,4}), 1, (com_SOAs{39,4}+com_SOAs{39,4})], 'FaceColor',[128/255,201/255,255/255], 'EdgeColor','none')
plot([2.5, 3.5], [com_SOAs{39,2}, com_SOAs{39,2}], 'k','LineWidth',1) % SOA 50
rectangle('Position', [4.5, (com_SOAs{40,2}-com_SOAs{40,4}), 1, (com_SOAs{40,4}+com_SOAs{40,4})], 'FaceColor',[128/255,201/255,255/255], 'EdgeColor','none')
plot([4.5, 5.5], [com_SOAs{40,2}, com_SOAs{40,2}], 'k','LineWidth',1) % SOA 200
rectangle('Position', [6.5, (com_SOAs{41,2}-com_SOAs{41,4}), 1, (com_SOAs{41,4}+com_SOAs{41,4})], 'FaceColor',[128/255,201/255,255/255], 'EdgeColor','none')
plot([6.5, 7.5], [com_SOAs{41,2}, com_SOAs{41,2}], 'k','LineWidth',1) % SOA 600

ylim([0, 1])
ylabel('mean JND')
xlim([0,8])
xticks([1, 3, 5, 7])
xticklabels({'0', '50', '200', '600'})
xlabel('SOA [ms]')
%title('JND separated for SOAs')

saveas(gcf, 'JND_SOAs_notitle.png')
cd('../Psycho')




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------- 1.3 comparison of agency rating for different SOAs ---------- %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1) agency ratings + SOAs for each trial from original data file
[agency_rating{1:3,1}] = deal('subjects', 'agency ratings', 'SOA');
for s = 2:Nsub+1
    agency_rating{1,s} = subjects{1,s};
    for t = 1:length(subjects{2,s}.trial)
        if subjects{2,s}.trial(t).valid == 1
            agency_rating{2,s} = horzcat(agency_rating{2,s}, subjects{2,s}.agency(t));
            agency_rating{3,s} = horzcat(agency_rating{3,s}, subjects{2,s}.mainvar.data.SOA(t));
        end
    end
end


% 2) agency ratings nach SOA sortieren und pro SOA innerhalb Proband
% mitteln
%   --> pro SOA und Proband 1 Agency Rating
[agency_rating{[4,6,8,10],1}] = deal('SOA 0', 'SOA 50', 'SOA 200', 'SOA 600');

for sb = 2: Nsub+1 % Länge subjects
    ag0 = [];
    ag50 = [];
    ag200 = [];
    ag600 = [];
    for n = 1:length(agency_rating{3,sb}) % Länge SOAs
        if agency_rating{3, sb}(n) == 0.0
            if (str2double(agency_rating{2,sb}{n})<0) | (str2double(agency_rating{2,sb}{n})>7)
                ag0 = horzcat(ag0, NaN);
            else
                ag0 = horzcat(ag0, str2double(agency_rating{2,sb}{n}));
            end
        elseif agency_rating{3, sb}(n) == 0.05
            if (str2double(agency_rating{2,sb}{n})<0) | (str2double(agency_rating{2,sb}{n})>7)
                ag50 = horzcat(ag50, NaN);
            else
                ag50 = horzcat(ag50, str2double(agency_rating{2,sb}(n)));
            end
        elseif agency_rating{3, sb}(n) == 0.2
            if (str2double(agency_rating{2,sb}{n})<0) | (str2double(agency_rating{2,sb}{n})>7)
                ag200 = horzcat(ag200, NaN);
            else
                ag200 = horzcat(ag200, str2double(agency_rating{2,sb}(n)));
            end
        elseif agency_rating{3, sb}(n) == 0.6
            if (str2double(agency_rating{2,sb}{n})<0) | (str2double(agency_rating{2,sb}{n})>7)
                ag600 = horzcat(ag600, NaN);
            else
                ag600 = horzcat(ag600, str2double(agency_rating{2,sb}(n)));
            end
        end
    end
    [agency_rating{[4,6,8,10],sb}] = deal(ag0, ag50, ag200, ag600);
    
    % chose median instead of mean because of data distribution (tested
    % below for loop)
    agency_rating{5,sb} = median([agency_rating{4,sb}], 'omitnan');
    agency_rating{7,sb} = median([agency_rating{6,sb}], 'omitnan');
    agency_rating{9,sb} = median([agency_rating{8,sb}], 'omitnan');
    agency_rating{11,sb} = median([agency_rating{10,sb}], 'omitnan');
end

% check for distribution
% Verteilung anschauen --> besser median innerhalb Proband rechnen, als
% mean am Anfang?
edges = 0.5:1:7.5;
figure('Position', [50, 50, 1400, 700])
hold on
for s = 1:size(subjects,2)-1
    subplot(4,size(subjects,2)-1,s) % SOA 1
    histogram(agency_rating{4,s+1}, edges)
    title(agency_rating{1,s+1})
   
    subplot(4,size(subjects,2)-1,s+(size(subjects,2)-1)) % SOA 50
    histogram(agency_rating{6,s+1}, edges)
    
    subplot(4,size(subjects,2)-1,s+(size(subjects,2)-1)*2) % SOA 200
    histogram(agency_rating{8,s+1}, edges)
    
    subplot(4,size(subjects,2)-1,s+(size(subjects,2)-1)*3) % SOA 600
    histogram(agency_rating{10,s+1},edges)  
end

subplot(4,size(subjects,2)-1,1)
ylabel(agency_rating{4,1})
subplot(4,size(subjects,2)-1,(size(subjects,2)-1)+1)
ylabel(agency_rating{6,1})
subplot(4,size(subjects,2)-1,(size(subjects,2)-1)*2+1)
ylabel(agency_rating{8,1})
subplot(4,size(subjects,2)-1,(size(subjects,2)-1)*3+1)
ylabel(agency_rating{10,1})

cd('../Figures')
saveas(gcf,'Rating_distribution.png')

% --> alles auf ersten Blick nicht wirklich normal verteilt --> mal mit
% Median ausprobieren


% 3) Varianz - Korrektur
% SM
agency_rating{13,1} = 'SM';
for sb = 2:Nsub+1 %size(agency_rating,2)
    agency_rating{13,sb} = mean([agency_rating{[5,7,9,11],sb}]);
end

% GM
agency_rating{14,1} = 'GM';
agency_rating{14,2} = mean([agency_rating{13, 2:end}]);

% mean difference
agency_rating{15,1} = 'SM - GM';
for sb = 2: size(agency_rating,2)
    agency_rating{15,sb} = agency_rating{13,sb} - agency_rating{14,2};
end

% korrigierte agency ratings (Ursprungs Mean Rating pro SOA - Diff)
[agency_rating{16:19,1}] = deal('corr SOA 0', 'corr SOA 50', 'corr SOA 200', 'corr SOA 600');

for sb = 2: size(agency_rating,2)
    agency_rating{16,sb} = agency_rating{5,sb} - agency_rating{15,sb};
    agency_rating{17,sb} = agency_rating{7,sb} - agency_rating{15,sb};
    agency_rating{18,sb} = agency_rating{9,sb} - agency_rating{15,sb};
    agency_rating{19,sb} = agency_rating{11,sb} - agency_rating{15,sb};
end

% mean, SD, SEM
[agency_rating{21, 2:4}] = deal('Mean', 'SD', 'SEM');
[agency_rating{22:25, 1}] = deal('SOA 0', 'SOA 50', 'SOA 200', 'SOA 600');
% mean
[agency_rating{22:25, 2}] = deal(mean([agency_rating{16, 2:end}]), mean([agency_rating{17, 2:end}]),...
    mean([agency_rating{18, 2:end}]), mean([agency_rating{19, 2:end}]));
% SD
[agency_rating{22:25, 3}] = deal(std([agency_rating{16, 2:end}]), std([agency_rating{17, 2:end}]),...
    std([agency_rating{18, 2:end}]), std([agency_rating{19, 2:end}]));
% SEM
[agency_rating{22:25, 4}] = deal(std([agency_rating{16, 2:end}])/sqrt(length([agency_rating{16, 2:end}])), ...
    std([agency_rating{17, 2:end}])/sqrt(length([agency_rating{17, 2:end}])),...
    std([agency_rating{18, 2:end}])/sqrt(length([agency_rating{18, 2:end}])),...
    std([agency_rating{19, 2:end}])/sqrt(length([agency_rating{19, 2:end}])));



% Test auf Normalverteilung (Shapiro-Wils auf korrigierte Daten)
[H,shap0,~] = swtest([agency_rating{16,2:end}], 0.01) % p = 0.4
[H,shap5,~] = swtest([agency_rating{17,2:end}], 0.01) % p = 0.002 -> s
[H,shap2,~] = swtest([agency_rating{18,2:end}], 0.01) % p = 0.003 -> s
[H,shap6,~] = swtest([agency_rating{19,2:end}], 0.01) % p = 0.55

% --> nicht normalverteilt (?) -> non-parametric test
% Kruskal-Wallis auf normierte Daten oder Friedman test auf nicht normierte
f = [[agency_rating{5,2:Nsub+1}]',[agency_rating{7,2:Nsub+1}]',[agency_rating{9,2:Nsub+1}]',[agency_rating{11,2:Nsub+1}]'];
[p, tbl, ~] = friedman(f,1)
agency_rating(39,1:4) = {'Friedman', 'df', 'Chi²', 'p'};
agency_rating(40,2:4) = {[3,48], 23.811, 0.000027};

k = [[agency_rating{16,2:Nsub+1}]',[agency_rating{17,2:Nsub+1}]',[agency_rating{18,2:Nsub+1}]',[agency_rating{19,2:Nsub+1}]'];
[p, tbl, ~] = kruskalwallis(k, [1,2,3,4], 'off')
agency_rating(41,1:4) = {'Kruskal', 'df', 'Chi²', 'p'};
agency_rating(42,2:4) = {[3,64], 30.24, 0.000001};


% % repeated-measures one-way Anova --> not used anymore because of
% % distributin
% % 1 Faktor = SOA, dependent variable = PSE (JND)
% %          X - data matrix (Size of matrix must be n-by-3;dependent variable=column 1,
% %              independent variable=column 2;subject=column 3). 
% %      alpha - significance level (default = 0.05).
% agency_rating{27,1} = 'Ranova';
% alpha = 0.05;
% 
% X_ag = zeros((size(agency_rating,2)-1)*4,3);
% X_ag(:,1) = [[agency_rating{5,2:end}]';[agency_rating{7,2:end}]';[agency_rating{9,2:end}]';[agency_rating{11,2:end}]'];
% X_ag(:,2) = [ones(length([agency_rating{5,2:end}]),1);ones(length([agency_rating{7,2:end}]),1)*2;ones(length([agency_rating{9,2:end}]),1)*3;ones(length([agency_rating{11,2:end}]),1)*4];
% X_ag(:,3) = [(1:Nsub)';(1:Nsub)';(1:Nsub)';(1:Nsub)'];
% 
% disp('Agency Rating')
% RMAOV1(X_ag,alpha)
% 
% [agency_rating{27,2:4}] = deal('df (IV, Error)', 'F', 'p'); % IV = indendent variable
% %[agency_rating{28,2:4}] = deal([3, 24], 4.490, 0.0123); MEAN AM ANFANG
% %[agency_rating{28,2:4}] = deal([3, 33], 4.236, 0.0122); % mit MEDIAN AM ANFANG, incl. hb (N12)
% [agency_rating{28,2:4}] = deal([3, 48], 12.092, 0.0000);
% 
% 
% % post-hoc paired-sampled two-way t-tests
% [agency_rating{30,1:4}] = deal('Post-hoc t-tests', 'h', 'p', 'stats (tstat, df, sd)');
% [agency_rating{31:36, 1}] = deal('0ms vs. 50ms','0ms vs. 200ms','0ms vs. 600ms','50ms vs. 200ms','50ms vs. 600ms','200ms vs. 600ms'); 
% 
% [agency_rating{31,2}, agency_rating{31,3}, ~, agency_rating{31,4}] = ttest([agency_rating{5, 2:end}], [agency_rating{7,2:end}]);
% [agency_rating{32,2}, agency_rating{32,3}, ~, agency_rating{32,4}] = ttest([agency_rating{5, 2:end}], [agency_rating{9,2:end}]);
% [agency_rating{33,2}, agency_rating{33,3}, ~, agency_rating{33,4}] = ttest([agency_rating{5, 2:end}], [agency_rating{11,2:end}]);
% [agency_rating{34,2}, agency_rating{34,3}, ~, agency_rating{34,4}] = ttest([agency_rating{7, 2:end}], [agency_rating{9,2:end}]);
% [agency_rating{35,2}, agency_rating{35,3}, ~, agency_rating{35,4}] = ttest([agency_rating{7, 2:end}], [agency_rating{11,2:end}]);
% [agency_rating{36,2}, agency_rating{36,3}, ~, agency_rating{36,4}] = ttest([agency_rating{9, 2:end}], [agency_rating{11,2:end}]);
% 
% [agency_rating{37,[1,3]}] = deal('Bonf. p', 0.05/6);

% lineare regression
y = []; % answers
x = []; % SOAs
for sb = 1:Nsub
    y = vertcat(y,[agency_rating{16:19,sb+1}]');
    x = vertcat(x,[1:4]');
end
x(:,2) = 1;
[~,~,~,~, stats] = regress(y,x) % R² = 0.40, F = 42.23, p = 0.000, err = 0.76

%%%% SPSS export
% Kruskal-Wallis normierte Daten
soaagency = [[agency_rating{16,2:end}]',[agency_rating{17,2:end}]',[agency_rating{18,2:end}]',[agency_rating{19,2:end}]'];
varnames={'S0','S50','S200','S600'};
save4spss(soaagency,varnames,'SOAvsAgencyRating.dat')

%%%%% testen für quadratischen Zusammenhang 
% Daten Quadratwurzel nehmen und dann linearen Zusammenhang testen
yquad = sqrt(y);
[~,~,~,~, stats] = regress(yquad,x) % R² = 0.39, F = 41.44, p = 0.000, err = 0.045


% figure
figure()
hold on
rectangle('Position',[0.5, (agency_rating{22,2}-agency_rating{22,4}),1,(agency_rating{22,4}+agency_rating{22,4})],...
    'FaceColor',[128/255,201/255,255/255],'EdgeColor','none')
plot([0.5, 1.5], [agency_rating{22,2}, agency_rating{22,2}], 'k', 'LineWidth',1)
rectangle('Position',[2.5, (agency_rating{23,2}-agency_rating{23,4}),1,(agency_rating{23,4}+agency_rating{23,4})],...
    'FaceColor',[128/255,201/255,255/255],'EdgeColor','none')
plot([2.5, 3.5], [agency_rating{23,2}, agency_rating{23,2}], 'k', 'LineWidth',1)
rectangle('Position',[4.5, (agency_rating{24,2}-agency_rating{24,4}),1,(agency_rating{24,4}+agency_rating{24,4})],...
    'FaceColor',[128/255,201/255,255/255],'EdgeColor','none')
plot([4.5, 5.5], [agency_rating{24,2}, agency_rating{24,2}], 'k', 'LineWidth',1)
rectangle('Position',[6.5, (agency_rating{25,2}-agency_rating{25,4}),1,(agency_rating{25,4}+agency_rating{25,4})],...
    'FaceColor',[128/255,201/255,255/255],'EdgeColor','none')
plot([6.5, 7.5], [agency_rating{25,2}, agency_rating{25,2}], 'k', 'LineWidth',1)
hold off

ylim([1, 7.5])
yticks([1,2,3,4,5,6,7])
yticklabels({'1','2','3','4','5','6','7'})
ylabel('mean agency rating')
xlim([0, 8])
xticks([1, 3, 5, 7])
xticklabels({'0', '50', '200', '600'})
xlabel('SOA [ms]')
%title('Agency Rating for different SOAs')

cd('../Figures')
saveas(gcf, 'comparison_RatingSOA_notitle.png')



%%%% für jeden Probanden Korrelation über SOAs rechnen
% --> nimmt Agency mit SOA konsistent ab
% --> kann man auch über sie gemittelt machen
figure()
hold on
for sb = 2:Nsub+1
    plot(1:4,[agency_rating{16:19,sb}],'--')
end
% plot(1:4, [agency_rating{16:19,3}],'r','LineWidth',1.5) % hb10: gegensätzliche Ratings
plot(1:4,[agency_rating{22:25,2}],'k','LineWidth',1.5)

xticks([1:4])
xticklabels({'0', '50','200','600'})
xlabel('SOA [ms]')
ylabel('Median Agency Rating')
saveas(gcf, 'Agency_correlation.png')

% Korrelation:
corrAG = [];
Y = [];
for sb = 1:Nsub
    corrAG = vertcat(corrAG, [agency_rating{16:19,sb+1}]');
    Y = vertcat(Y, [1;2;3;4]);
end
Y(:,2) = 1;

[~,~,~,~,stats] = regress(corrAG,Y)
% stats:
% - R² = 0.3958
% - F = 43.2305
% - p = 0.0000
% - estimate of error variance = 0.7644



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                 Gedankenexperiment: Habituierung                    %%%
%%%     --> analyses are not used anymore (actually never really used)  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% a)
% wenn man die ganze Zeit Töne hört, könnte man habituieren -> ...
% sich ans Delay gewöhnen --> sollte über die trials hinweg höheres
% agency rating zeigen

agency_timecourse = agency_rating(1,1:end);
rows = [4,6,8,10;2,13,24,35]; % agency rating: r4,6,8,10, timecourse: pro SOA 5 Reihen nötig + Leerzeile
figure('Position',[150,100, 1200, 600])
for ss = 1:4 % for each SOA (all stacked in one matrix)
    agency_timecourse(rows(2,ss),1:end) = agency_rating(rows(1,ss),1:end);
    [agency_timecourse{rows(2,ss)+1:rows(2,ss)+4,1}] = deal('SM', 'GM', 'SM - GM', 'SOA corr');
    
    % SM
    for sb = 2:size(agency_timecourse,2)
        agency_timecourse{rows(2,ss)+1,sb} = mean([agency_timecourse{rows(2,ss),sb}], 'omitnan');
    end
    
    % GM
    agency_timecourse{rows(2,ss)+2,2} = mean([agency_timecourse{rows(2,ss)+1,2:end}]);
    
    % SM - GM + corr
    for sb = 2:size(agency_timecourse,2)
        agency_timecourse{rows(2,ss)+3,sb} = agency_timecourse{rows(2,ss)+1,sb} - agency_timecourse{rows(2,ss)+2,2};
        agency_timecourse{rows(2,ss)+4,sb} = agency_timecourse{rows(2,ss),sb} - agency_timecourse{rows(2,ss)+3,sb};
    end

    % mean, SD, SEM
    len = [];
    for sb = 2:size(agency_timecourse,2)
        len = horzcat(len, length(agency_timecourse{rows(2,ss)+4,sb}));
    end
    max_len = max(len);
    t_mat = NaN(size(agency_timecourse,2)-1,max_len);
    for sb = 1:size(agency_timecourse,2)-1
        t_mat(sb,1:len(sb)) = agency_timecourse{rows(2,ss)+4,sb+1};
    end

    [agency_timecourse{rows(2,ss)+5:rows(2,ss)+7,1}] = deal('Mean', 'SD', 'SEM');
    agency_timecourse{rows(2,ss)+5,2} = mean(t_mat,1,'omitnan');
    agency_timecourse{rows(2,ss)+6,2} = std(t_mat,1,'omitnan');
    agency_timecourse{rows(2,ss)+7,2} = std(t_mat,1,'omitnan')./sqrt(sum(~isnan(t_mat),1));

    subplot(2,2,ss)
    hold on
    scatter(1:length(agency_timecourse{rows(2,ss)+5,2}), agency_timecourse{rows(2,ss)+5,2})
    l = lsline();
    l.Color = 'r';
    l.LineStyle = '--';
    ylim([0,10])
    xlim([0, length(agency_timecourse{rows(2,ss)+5,2})+1])
    ylabel('agency rating')
    xlabel('trial')
    title(agency_timecourse{rows(2,ss),1})
    
    % Statistik: multiple linear regression ('regress')
    disp(agency_timecourse{rows(2,ss),1})
    [agency_timecourse{rows(2,ss)+8,1:5}] = deal('mult lin reg', 'R²', 'F','p','var');
    y = []; % variable
    par = []; % parameter
    for sb = 1:Nsub
        y = vertcat(y, [agency_timecourse{rows(2,ss)+4,sb+1}]');
        par = vertcat(par, [[1:length(agency_timecourse{rows(2,ss)+4,sb+1})]',ones(length(agency_timecourse{rows(2,ss)+4,sb+1}),1)]);
    end
    [~,~,~,~,stats] = regress(y,par)
    [agency_timecourse{rows(2,ss)+9,2:5}] = deal(stats(1),stats(2),stats(3),stats(4));
end

saveas(gcf, 'Habituation_Agency.png')
% SOA 600 Trend signifikanter p-Wert für Korrelation (aber sehr geringer R-Wert)



% b)
% durch Habituierung sollte man den ersten Ton leiser wahrnehmen als er
% ist --> über Zeit hinweg sollte man den 2. Ton häufiger als lauter
% wahrnehmen?
% 4 subplots für jedes SOA (mit verschiedenen Farben die verschiedenen
% Tonhöhen

% KORREKTUREN????
PSE_timecourse = agency_rating(1,1:end);
[PSE_timecourse{2:4,1}] = deal('SOAs', 'intensities 2. tone', 'Answer');

for sb = 2:length(subjects)
    for t = 1:length(subjects{2,sb}.trial)
        if subjects{2,sb}.trial(t).valid == 1
            PSE_timecourse{2,sb} = horzcat(PSE_timecourse{2,sb},subjects{2,sb}.mainvar.data.SOA(t));
            PSE_timecourse{3,sb} = horzcat(PSE_timecourse{3,sb},subjects{2,sb}.trial(t).level);
            PSE_timecourse{4,sb} = horzcat(PSE_timecourse{4,sb},subjects{2,sb}.mainvar.data.respComp(t));
        end
    end
end

[PSE_timecourse{[6:11,13:18,20:25,27:32],1}] = deal('SOA 0', '72 dB', '73 dB', '74 dB', '75 dB', '76 dB',...
    'SOA 50', '72 dB', '73 dB', '74 dB', '75 dB', '76 dB','SOA 200', '72 dB', '73 dB', '74 dB', '75 dB', '76 dB', 'SOA 600', '72 dB', '73 dB', '74 dB', '75 dB', '76 dB');
PSE_timecourse{6,size(PSE_timecourse,2)+1} = 'mean';

dBSPL = [72, 73,74,75,76];
soas = [0,0.05,0.2,0.6];
ss_ind = [6,13,20,27];
for sb = 2:length(subjects) % subjects
    for ss = 1:4 % SOAs
        for i = 1:5 % for that SOA for each intensity
            ind = find([PSE_timecourse{2,sb}]==soas(ss)&[PSE_timecourse{3,sb}]==dBSPL(i)); % indices for that SOA
            PSE_timecourse{ss_ind(ss)+i, sb} = [PSE_timecourse{4,sb}(ind)];
        end  
    end
end

% Mean
figure('Position', [150,100, 1200, 600])
for ss = 1:4
    for i = 1:5
        len =[];
        for sb = 2:size(PSE_timecourse,2)-1 % eine Spalte für mean inzwischen dabei
            len = horzcat(len, length([PSE_timecourse{ss_ind(ss)+i,sb}]));
        end
        max_len = max(len);
        t_mat = NaN(size(PSE_timecourse,2)-2,max_len);
        for sb = 1:size(PSE_timecourse,2)-2
            t_mat(sb,1:len(sb)) = PSE_timecourse{ss_ind(ss)+i,sb+1};
        end
        PSE_timecourse{ss_ind(ss)+i,size(PSE_timecourse,2)} = mean(t_mat,1,'omitnan');
    end
    subplot(2,2,ss)
    hold on
    plot(1:length([PSE_timecourse{ss_ind(ss)+1,size(PSE_timecourse,2)}]),PSE_timecourse{ss_ind(ss)+1,size(PSE_timecourse,2)}, 'o-') %72
    plot(1:length([PSE_timecourse{ss_ind(ss)+2,size(PSE_timecourse,2)}]),PSE_timecourse{ss_ind(ss)+2,size(PSE_timecourse,2)}, 'o-') %73
    plot(1:length([PSE_timecourse{ss_ind(ss)+3,size(PSE_timecourse,2)}]),PSE_timecourse{ss_ind(ss)+3,size(PSE_timecourse,2)}, 'o-') %74
    plot(1:length([PSE_timecourse{ss_ind(ss)+4,size(PSE_timecourse,2)}]),PSE_timecourse{ss_ind(ss)+4,size(PSE_timecourse,2)}, 'o-') %75
    plot(1:length([PSE_timecourse{ss_ind(ss)+5,size(PSE_timecourse,2)}]),PSE_timecourse{ss_ind(ss)+5,size(PSE_timecourse,2)}, 'o-') %76
    legend('72 dBSPL', '73 dBSPL', '74 dBSPL', '75 dBSPL', '76 dBSPL')
    title(PSE_timecourse{ss_ind(ss),1})
    xlim([0,17])
    ylim([0,3])
    yticks([1,2])
    yticklabels({'1.tone', '2.tone'})
    xlabel('trial')
    ylabel('louder tone')
end

saveas(gcf, 'habituation_PSE.png')
% STATISTIK??????



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% ------------------------ Performance ------------------------------ %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% how often did subjects chose the right tone to be louder (%)
% trials in which both tones were equally loud excluded from analysis
performance = subjects(1,:);
performance(2:3,1) = {'MA' 'A'};
performance(4:6,1) = {'SM', 'GM', 'SM - GM'};
performance(7:8,1) = {'MA corr (All,0,50,200,600)', 'A corr'};
for sb = 1:Nsub
    for c = 2:3 % MA,A
        condi = subjects{c,sb+1};
        answers = [];
        tone2 = [];
        soa = [];
        for t=1:length(condi.trial)
            if condi.trial(t).valid == 1
                answers = horzcat(answers, condi.mainvar.data.respComp(t)); % 1 = 1. tone louder, 2 = 2. tone louder?
                tone2 = horzcat(tone2, condi.trial(t).level);
                soa = horzcat(soa, condi.trial(t).pool);
            end
        end

        tone1 = 74;
        correctAnswers = zeros(1,length(answers));
        correct0 = [];
        correct50 = [];
        correct200 = [];
        correct600 = [];
        

        for t = 1:length(answers)
            if (tone2(t) < tone1) & (answers(t) == 1)
                correctAnswers(t) = 1;
            elseif (tone2(t) > tone1) & (answers(t) == 2)
                correctAnswers(t) = 1;
            else
                correctAnswers(t) = 0;
            end
            % für SOAs aufgespalten
            if soa(t) == 0
                if (tone2(t) < tone1) & (answers(t) == 1)
                    correct0 = horzcat(correct0,1);
                elseif (tone2(t) > tone1) & (answers(t) == 2)
                    correct0 = horzcat(correct0,1);
                else
                    correct0 = horzcat(correct0,0);
                end
            elseif soa(t) == 50
                if (tone2(t) < tone1) & (answers(t) == 1)
                    correct50 = horzcat(correct50,1);
                elseif (tone2(t) > tone1) & (answers(t) == 2)
                    correct50 = horzcat(correct50,1);
                else
                    correct50 = horzcat(correct50,0);
                end
            elseif soa(t) == 200
                if (tone2(t) < tone1) & (answers(t) == 1)
                    correct200 = horzcat(correct200,1);
                elseif (tone2(t) > tone1) & (answers(t) == 2)
                    correct200 = horzcat(correct200,1);
                else
                    correct200 = horzcat(correct200,0);
                end
            elseif soa(t) == 600
                if (tone2(t) < tone1) & (answers(t) == 1)
                    correct600 = horzcat(correct600,1);
                elseif (tone2(t) > tone1) & (answers(t) == 2)
                    correct600 = horzcat(correct600,1);
                else
                    correct600 = horzcat(correct600,0);
                end
            end
        end

        n74 = sum(tone2==74);
        performance{c,sb+1}.All = (sum(correctAnswers == 1)/(length(answers)-n74))*100; % proportion (%) correct answers, ohne dB74
        performance{c,sb+1}.S0 = (sum(correct0 == 1)/(sum(soa==0)-n74/4))*100; % proportion (%) correct answers, ohne dB74
        performance{c,sb+1}.S50 = (sum(correct50 == 1)/(sum(soa==50)-n74/4))*100; % proportion (%) correct answers, ohne dB74
        performance{c,sb+1}.S200 = (sum(correct200 == 1)/(sum(soa==200)-n74/4))*100; % proportion (%) correct answers, ohne dB74
        performance{c,sb+1}.S600 = (sum(correct600 == 1)/(sum(soa==600)-n74/4))*100; % proportion (%) correct answers, ohne dB74
        
        %proportion_correct74 = (sum(correctAnswers == 1)/300)*100 %  78,3% mit gleichen trials
        %proportion_correct = (sum(correctAnswers == 1)/240)*100 % 97.9% ohne gleiche trials
    end
    % Varianzkorrektur
    % SM
    performance{4,sb+1} = mean([performance{2,sb+1}.All,performance{2,sb+1}.S0,performance{2,sb+1}.S50,performance{2,sb+1}.S200,performance{2,sb+1}.S600,performance{3,sb+1}.All]);
end
% GM
performance{5,2} = mean([performance{4,2:Nsub+1}]);
for sb = 1:Nsub
    % SM - GM
    performance{6,sb+1} = performance{4,sb+1} - performance{5,2};
    
    % corrected data in matrix
    performance{7,sb+1} = [performance{2,sb+1}.All-performance{6,sb+1};performance{2,sb+1}.S0-performance{6,sb+1};performance{2,sb+1}.S50-performance{6,sb+1};performance{2,sb+1}.S200-performance{6,sb+1};performance{2,sb+1}.S600-performance{6,sb+1}];
    performance{8,sb+1} = performance{3,sb+1}.All - performance{6,sb+1};
    
    % corrected data
    m(sb) = performance{7,sb+1}(1);
    m0(sb) = performance{7,sb+1}(2);
    m50(sb) = performance{7,sb+1}(3);
    m200(sb) = performance{7,sb+1}(4);
    m600(sb) = performance{7,sb+1}(5);
    ma(sb) = performance{8,sb+1};
    % uncorrected data
    z(sb) = performance{2,sb+1}.S0;
    fu(sb) = performance{2,sb+1}.S50;
    t(sb) = performance{2,sb+1}.S200;
    s(sb) = performance{2,sb+1}.S600;
    a(sb) = performance{3,sb+1}.All;
end

performance(6,Nsub+2:Nsub+3) = {'Mean','SEM'};
performance{7,Nsub+2} = [mean(m);mean(m0);mean(m50);mean(m200);mean(m600)];
performance{8,Nsub+2} = mean(ma);
performance{7,Nsub+3} = [std(m)/sqrt(Nsub);std(m0)/sqrt(Nsub);std(m50)/sqrt(Nsub);std(m200)/sqrt(Nsub);std(m600)/sqrt(Nsub)];
performance{8,Nsub+3} = std(ma)/sqrt(Nsub);

% Shapiro-Wilks Normalverteilung
[H,shapA,~] = swtest(ma,0.01) % p = 0.41
[H,shap0,~] = swtest(m0,0.01) % p = 0.27
[H,shap5,~] = swtest(m50,0.01) % p = 0.18
[H,shap2,~] = swtest(m200,0.01) % p = 0.1
[H,shap6,~] = swtest(m600,0.01) % p = 0.0016

% A + SOAs, nicht-parametrisch
[p, tbl, ~] = kruskalwallis([ma',m0',m50',m200',m600'], [1,2,3,4,5], 'off')
% Chi² = 6.79, p = 0.15, df = [4,80]
% nur SOAs
[p, tbl, ~] = kruskalwallis([m0',m50',m200',m600'], [1,2,3,4,], 'off')
% Chi² = 2.70, p = 0.44, df = [3,64]

performance(9,1:4) = {'Anova SOA+A', 'df', 'F', 'p'};
perfsa(:,1) = [a';z';fu';t';s'];
perfsa(:,2) = [ones(Nsub,1);ones(Nsub,1)*2;ones(Nsub,1)*3;ones(Nsub,1)*4;ones(Nsub,1)*5];
perfsa(:,3) = [1:Nsub,1:Nsub,1:Nsub,1:Nsub,1:Nsub]';
disp('Anova SOAs + A')
RMAOV1(perfsa)

performance(11,1) = {'Anova SOAs'};
perfs(:,1) = [z';fu';t';s'];
perfs(:,2) = [ones(Nsub,1);ones(Nsub,1)*2;ones(Nsub,1)*3;ones(Nsub,1)*4];
perfs(:,3) = [1:Nsub,1:Nsub,1:Nsub,1:Nsub,]';
disp('Anova SOAs')
RMAOV1(perfs)

[performance{10,2:4}] = deal([4,64], 2.333, 0.0651);
[performance{11,2:4}] = deal([3,48], 2.467, 0.0734);


% Shapiro Wilks (differenz)
[H, shap, ~] = swtest([z-a],0.01) % p = 0.11

performance(12,1) = {'t-test MA(0) > A'};
[~, performance{12,2}, ~, stats] = ttest(a,z,'tail','left'); % tstat = -2.108, df = 16


% figure
figure()
hold on
fill([0.5 1.5 1.5 0.5], [performance{8,Nsub+2}-performance{8,Nsub+3}, performance{8,Nsub+2}-performance{8,Nsub+3}, performance{8,Nsub+2}+performance{8,Nsub+3},performance{8,Nsub+2}+performance{8,Nsub+3}], [255/255, 50/255, 50/255], 'EdgeColor', 'none') % A
plot([0.5 1.5], [performance{8,Nsub+2}, performance{8,Nsub+2}], 'k', 'LineWidth',1)
fill([2.5 3.5 3.5 2.5], [performance{7,Nsub+2}(2)-performance{7,Nsub+3}(2), performance{7,Nsub+2}(2)-performance{7,Nsub+3}(2), performance{7,Nsub+2}(2)+performance{7,Nsub+3}(2),performance{7,Nsub+2}(2)+performance{7,Nsub+3}(2)], [21/255,45/255,255/255], 'EdgeColor', 'none') % MA
plot([2.5 3.5], [performance{7,Nsub+2}(2), performance{7,Nsub+2}(2)], 'k', 'LineWidth',1)
xlim([0 4])
ylim([85 100])
xticks([1 3])
xticklabels({'Auditory-Only', 'Motor-Auditory (SOA 0)'})
xlabel('condition')
ylabel('mean of correct answers [%]')
saveas(gcf, 'Performance_A_MA.png')

figure()
hold on
fill([0.5 1.5 1.5 0.5], [performance{8,Nsub+2}-performance{8,Nsub+3}, performance{8,Nsub+2}-performance{8,Nsub+3}, performance{8,Nsub+2}+performance{8,Nsub+3},performance{8,Nsub+2}+performance{8,Nsub+3}], [128/255, 201/255, 255/255], 'EdgeColor', 'none', 'FaceAlpha', 0.3) % A
plot([0.5 1.5], [performance{8,Nsub+2}, performance{8,Nsub+2}], 'k', 'LineWidth',1)
fill([2.5 3.5 3.5 2.5], [performance{7,Nsub+2}(2)-performance{7,Nsub+3}(2), performance{7,Nsub+2}(2)-performance{7,Nsub+3}(2), performance{7,Nsub+2}(2)+performance{7,Nsub+3}(2),performance{7,Nsub+2}(2)+performance{7,Nsub+3}(2)], [128/255, 201/255, 255/255], 'EdgeColor', 'none', 'FaceAlpha', 0.3) % 0
plot([2.5 3.5], [performance{7,Nsub+2}(2), performance{7,Nsub+2}(2)], 'k', 'LineWidth',1)
fill([4.5 5.5 5.5 4.5], [performance{7,Nsub+2}(3)-performance{7,Nsub+3}(3), performance{7,Nsub+2}(3)-performance{7,Nsub+3}(3), performance{7,Nsub+2}(3)+performance{7,Nsub+3}(3),performance{7,Nsub+2}(3)+performance{7,Nsub+3}(3)], [128/255, 201/255, 255/255], 'EdgeColor', 'none', 'FaceAlpha', 0.3) % 50
plot([4.5 5.5], [performance{7,Nsub+2}(3), performance{7,Nsub+2}(3)], 'k', 'LineWidth',1)
fill([6.5 7.5 7.5 6.5], [performance{7,Nsub+2}(4)-performance{7,Nsub+3}(4), performance{7,Nsub+2}(4)-performance{7,Nsub+3}(4), performance{7,Nsub+2}(4)+performance{7,Nsub+3}(4),performance{7,Nsub+2}(4)+performance{7,Nsub+3}(4)], [128/255, 201/255, 255/255], 'EdgeColor', 'none', 'FaceAlpha', 0.3) % 200
plot([6.5 7.5], [performance{7,Nsub+2}(4), performance{7,Nsub+2}(4)], 'k', 'LineWidth',1)
fill([8.5 9.5 9.5 8.5], [performance{7,Nsub+2}(5)-performance{7,Nsub+3}(5), performance{7,Nsub+2}(5)-performance{7,Nsub+3}(5), performance{7,Nsub+2}(5)+performance{7,Nsub+3}(5),performance{7,Nsub+2}(5)+performance{7,Nsub+3}(5)], [128/255, 201/255, 255/255], 'EdgeColor', 'none', 'FaceAlpha', 0.3) % 600
plot([8.5 9.5], [performance{7,Nsub+2}(5), performance{7,Nsub+2}(5)], 'k', 'LineWidth',1)

xlim([0 10])
ylim([85 100])
xticks([1:2:9])
xticklabels({'Auditory-Only', 'SOA 0', 'SOA 50', 'SOA 200', 'SOA 600'})
ylabel('mean of correct answers [%]')
saveas(gcf, 'Performance_A_SOAs.png')

% bei auditory-only fällt ls02 etwas aus dem Rahmen -> deswegen nicht
% signifikant?



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% ---------------- Pausen Einfluss auf Performance? ----------------- %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Performance für jeden Block berechnen
% Pause zum vorherigen Block herausholen --> mainvar.tableData.trialendtobeginning
% auch Blocknummer merken
% N valid trials merken
% Blocknummer und Pause Einfluss?, eventuell Interaktion?

% MA: 20 trials per Block, 15 blocks
% A: 15 trials per block, 5 blocks
% Fehlertrials am Ende noch addiert

% MA
lvl = [74, 73, 75, 72, 76];
t1 = 74;
blockperformance = subjects(1,:);
blockperformance(1:5,1) = {'MA','perf','break','N','corr perf'};
blockperformance(6:10,1) = {'A','perf','break','N','corr perf'};

for con = 1:2
    for sb = 1:Nsub
        if subjects{con+1,sb+1}.mainvar.tableData(1,2).errorType == 0 % nur valid 1. trial
            t2 = lvl(subjects{con+1,sb+1}.mainvar.tableData(1,30).scndtone);
            ant = subjects{con+1,sb+1}.mainvar.tableData(1,3).respComp;
        else
            t2 = [];
            ant = [];
        end
        b = 1; % Startblock
        c = 0; % # correct answers in block
        blocks = 1:subjects{con+1,sb+1}.mainvar.tableData(end,6).blocknumber;
        perf = zeros(1,length(blocks));
        pause = nan(1,length(blocks)); % Block 1 = NaN??
        nval = zeros(1,length(blocks)); % valid trials in each block, except db74
        
        for t = 2:size(subjects{con+1,sb+1}.mainvar.tableData,1) % # trials, gehen jedes trial durch
            if subjects{con+1,sb+1}.mainvar.tableData(t,6).blocknumber ~= subjects{con+1,sb+1}.mainvar.tableData(t-1,6).blocknumber % while in same block
                % performance des abgeschlossenen Blocks berechnen:
                for p = 1:length(t2)
                    if (t2(p) < t1 & ant(p) == 1) | (t2(p) > t1 & ant(p) == 2)
                        c = c+1;
                    end
                end
                perf(b) = (c/(length(t2)-sum(t2==74)))*100; % performance in %, ohne db74 trials
                nval(b) = (length(t2)-sum(t2==74)); % ausgewertet N trials
    
                % reset Starteinstellungen für nächsten Block
                disp(t)
                b = b+1; % Blocknummer erhöht
                c = 0; % score reset to 0
                t2 = [];
                ant = [];
                % Pause für nächsten Block
                pause(b) = subjects{con+1,sb+1}.mainvar.tableData(t,19).trialendtobeginning;
            
            end
            if subjects{con+1,sb+1}.mainvar.tableData(t,2).errorType == 0 % nur valid trials nehmen
                t2 = horzcat(t2, lvl(subjects{con+1,sb+1}.mainvar.tableData(t,30).scndtone)); % intensity 2. tone
                ant = horzcat(ant, subjects{con+1,sb+1}.mainvar.tableData(t,3).respComp); % Antwort: 1 = 1.tone, 2 = 2.tone
            end 
        end
        % Auswertung letzter Block
        c = 0;
        for p = 1:length(t2)
            if (t2(p) < t1 & ant(p) == 1) | (t2(p) > t1 & ant(p) == 2)
                c = c+1;
            end
        end
        perf(b) = (c/(length(t2)-sum(t2==74)))*100; % performance in %, ohne db74 trials
        nval(b) = (length(t2)-sum(t2==74)); % ausgewertet N trials
        
        if con == 1
            idx = 2;
        else
            idx = 7;
        end
        [blockperformance{idx:idx+2,sb+1}] = deal(perf,pause,nval);
    end
    
    % Varianzkorrektur
    % SM
    clear sm gm smgm
    for sb = 1:Nsub
        sm(sb) = mean(blockperformance{idx,sb+1});
    end
    gm = mean(sm);
    for sb = 1:Nsub
        smgm(sb) = sm(sb) - gm;
        blockperformance{idx+3,sb+1} = blockperformance{idx,sb+1}-smgm(sb);
    end
    
    % regression
    x = [];
    y1 = [];
    y2 = [];
    for sb = 1:Nsub
        x = horzcat(x, blockperformance{idx+3,sb+1});
        y1 = horzcat(y1, [1:length(blockperformance{idx,sb+1})]); % blocknummer
        y2 = horzcat(y2, blockperformance{idx+1,sb+1}); % Pausenlänge
    end
    
    [~,~,~,~, statnr] = regress(x',[y1;ones(1,length(y1))]') % blocknr: R² = 0.053, F = 14.66, p = 0.0002; R² = 0.020, F = 1.79, p = 0.18
    [~,~,~,~, statbr] = regress(x',[y2;ones(1,length(y2))]') % breakl: R² = 0.0008, F = 0.19, p = 0.66; R² = 0.007, F = 0.48, p = 0.49
    

    % figure
    figure('Position', [200, 150, 800, 600])
    subplot(3,1,1) % Block
    hold on
    for sb = 1:Nsub
        scatter([1:length(blockperformance{idx+3,sb+1})], blockperformance{idx+3,sb+1}, 'k')
    end
    xlabel('Block number')
    ylabel('Block performance [%]')
    title([blockperformance{idx-1,1} ' | Block Number'])
    
    subplot(3,1,2) % break length
    hold on
    for sb = 1:Nsub
        scatter(blockperformance{idx+1,sb+1}, blockperformance{idx+3,sb+1}, 'k')
    end
    xlabel('Break Length [s]')
    ylabel('Block performance [%]')
    title([blockperformance{idx-1,1} ' | length of break between blocks'])
    
    subplot(3,1,3) % break length, close up
    hold on
    for sb = 1:Nsub
        scatter(blockperformance{idx+1,sb+1}, blockperformance{idx+3,sb+1}, 'k')
    end
    xlim([0 50])
    xlabel('Break Length [s]')
    ylabel('Block performance [%]')
    title([blockperformance{idx-1,1} ' | length of break between blocks close up'])

    saveas(gcf, ['InfluenceOnPerformance_' blockperformance{idx-1,1} '.png'])
end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%            Tastennähe bias bei Agency?                              %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% - Nateea meinte sie hatte manchmal das Gefühl, dass sie nach Q (T1) eher
% mal 1-3 gedrückt hat und nach E (T2) eher 4-7
% - bei auditory-only condition
% - wenn dort vielleicht auch in motor-auditory?

% für jeden Probanden separat schauen, welche ratings nach q und welche
% ratings nach e
% dann t-test rechnen ob MW signifikant verschieden
% getrennt für conditions
% condi = {'MA', 'A'};
% for con = 1:2 % row 1 = MA, row 2 = A
%     for sb = 1:size(subjects,2)-1
%         q.(subjects{1,sb+1}).ratings.(condi{con}) = [];
%         e.(subjects{1,sb+1}).ratings.(condi{con}) = [];
%         for t = 1:subjects{con+1,sb+1}.z
%             if subjects{con+1,sb+1}.mainvar.tableData.respComp(t) == 1 % Antwort 1. Ton
%                 q.(subjects{1,sb+1}).ratings.(condi{con}) = horzcat(q.(subjects{1,sb+1}).ratings.(condi{con}), str2num(subjects{con+1, sb+1}.agency{t}));
%             else
%                 e.(subjects{1,sb+1}).ratings.(condi{con}) = horzcat(q.(subjects{1,sb+1}).ratings.(condi{con}), str2num(subjects{con+1, sb+1}.agency{t}));
%             end
%         end
%         % small vs. high agency rating, getrennt für conditions
%         %disp([condi{con} '_' subjects{1,sb+1}])
%         tt(con,sb+1) = ranksum(q.(subjects{1,sb+1}).ratings.(condi{con}), e.(subjects{1,sb+1}).ratings.(condi{con}));
%         % variance corrected mean, SE
%     end 
% end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% sonstiges
% - Einfluss von Zeit auf korrekte Lautstärke, agency rating
%   - könnte sein, dass gegen Ende Aufmerksamkeit nachlässt --> dadurch
%   dann tone 1 nicht mehr so enhanced --> attenuation mehr
%   - 15 blocks à 20 trials (4 SOAs x 5 sound volumes)


% - Einfluss, ob man richtig geantwortet hat?


% SOA 0 vielleicht zu früh, um sich verantwortlich zu fühlen (Lioba hatte
% das Gefühl, dass der Ton kam bevor sie die Taste richtig gedrückt hat)



%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                     2. EEG                                          %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd("../EEG")
% set(0,'DefaultFigureVisible','off');


% ---------------------- 2.0.0 Original Daten --------------------------- %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subject{1} = 'ls02ICA';
subject{2} = 'lw03ICA';
subject{3} = 'jb04ICA';
subject{4} = 'mn05ICA';
subject{5} = 're06ICA';
subject{6} = 'ev07ICA';
subject{7} = 'nr08ICA';
subject{8} = 'sw13ICA';
subject{9} = 'lf14ICA';
subject{10} = 'lk15ICA';
subject{11} = 'sp16ICA';
subject{12} = 'hr17ICA';
subject{13} = 'sd19ICA';
subject{14} = 'nro20ICA';
subject{15} = 'lb21ICA';
subject{16} = 'jg22ICA';
subject{17} = 'al23ICA';

if IncAll == 1 % GP
    subject{18} = 'fs25ICA';
    subject{19} = 'am26ICA';
    subject{20} = 'lsc27ICA';
    subject{21} = 'rg28ICA';
end


EEG_data{1,1} = 'subject';
EEG_data{1,2} = 'ls02';
EEG_data{1,3} = 'lw03';
EEG_data{1,4} = 'jb04';
EEG_data{1,5} = 'mn05';
EEG_data{1,6} = 're06';
EEG_data{1,7} = 'ev07';
EEG_data{1,8} = 'nr08';
EEG_data{1,9} = 'sw13';
EEG_data{1,10} = 'lf14';
EEG_data{1,11} = 'lk15';
EEG_data{1,12} = 'sp16';
EEG_data{1,13} = 'hr17';
EEG_data{1,14} = 'sd19';
EEG_data{1,15} = 'nro20';
EEG_data{1,16} = 'lb21';
EEG_data{1,17} = 'jg22';
EEG_data{1,18} = 'al23';

if IncAll == 1 % GP
    EEG_data{19} = 'fs25ICA';
    EEG_data{20} = 'am26ICA';
    EEG_data{21} = 'lsc27ICA';
    EEG_data{22} = 'rg28ICA';
end


EEG_data{2,1} = 'motor-only (ns)';
EEG_data{3,1} = 'auditory-only (np)';
EEG_data{4,1} = 'motor-auditory (s)';

[EEG_data{2, 2:22}] = deal(load("ls02ICANoSound.mat"),  load("lw03ICANoSound.mat"),...
    load("jb04ICANoSound.mat"), load("mn05ICANoSound.mat"), load("re06ICANoSound.mat"),...
    load("ev07ICANoSound.mat"), load("nr08ICANoSound.mat"), load("sw13ICANoSound.mat"),...
    load("lf14ICANoSound.mat"), load("lk15ICANoSound.mat"), load("sp16ICANoSound.mat"),...
    load("hr17ICANoSound.mat"), load("sd19ICANoSound.mat"), load("nro20ICANoSound.mat"),...
    load("lb21ICANoSound.mat"), load("jg22ICANoSound.mat"), load("al23ICANoSound.mat"),...
    load("fs25ICANoSound.mat"), load("am26ICANoSound.mat"), load("lsc27ICANoSound.mat"),...
    load("rg28ICANoSound.mat"));
[EEG_data{3, 2:22}] = deal(load("ls02ICANoPress.mat"), load("lw03ICANoPress.mat"),...
    load("jb04ICANoPress.mat"), load("mn05ICANoPress.mat"), load("re06ICANoPress.mat"),...
    load("ev07ICANoPress.mat"), load("nr08ICANoPress.mat"), load("sw13ICANoPress.mat"),...
    load("lf14ICANoPress.mat"), load("lk15ICANoPress.mat"), load("sp16ICANoPress.mat"),...
    load("hr17ICANoPress.mat"), load("sd19ICANoPress.mat"), load("nro20ICANoPress.mat"),...
    load("lb21ICANoPress.mat"), load("jg22ICANoPress.mat"), load("al23ICANoPress.mat"),...
    load("fs25ICANoPress.mat"), load("am26ICANoPress.mat"), load("lsc27ICANoPress.mat"),...
    load("rg28ICANoPress.mat"));
[EEG_data{4, 2:22}] = deal(load("ls02ICASound.mat"), load("lw03ICASound.mat"),...
    load("jb04ICASound.mat"), load("mn05ICASound.mat"), load("re06ICASound.mat"),...
    load("ev07ICASound.mat"), load("nr08ICASound.mat"), load("sw13ICASound.mat"),...
    load("lf14ICASound.mat"), load("lk15ICASound.mat"), load("sp16ICASound.mat"),...
    load("hr17ICASound.mat"), load("sd19ICASound.mat"), load("nro20ICASound.mat"),...
    load("lb21ICASound.mat"), load("jg22ICASound.mat"), load("al23ICASound.mat"),...
    load("fs25ICASound.mat"), load("am26ICASound.mat"), load("lsc27ICASound.mat"),...
    load("rg28ICASound.mat"));
% if IncAll == 1
%     EEG_data{1,14} = 'hb10';
%     [EEG_data{2:4,14}] = deal(load("hb10ICANoSound.mat"), load("hb10ICANoPress.mat"),load("hb10ICASound.mat"));
% end

% FCz = 22, Fz = 5, Cz = 14
%[dataNoPress, dataNoSound, dataSOA0, dataSOA0corrected, datadiff, EEGtime] = AnalyzeEEG_All(22);
[EEG_data{6, 2:9}] = deal('dataNoPress', 'dataNoSound', 'dataSOA0', 'dataSOA0corrected', 'datadiff', 'EEGtime','N trials A/M/S0','SD A/M/S0');
[EEG_data{7:9,1}] = deal('FCz (21)', 'Fz (05)', 'Cz (14)');

[EEG_data{7, 2:9}] = AnalyzeEEG_All(IncAll,21);
[EEG_data{8, 2:9}] = AnalyzeEEG_All(IncAll,5);
[EEG_data{9, 2:9}] = AnalyzeEEG_All(IncAll,14);
%[EEG_data{10, 2:9}] = AnalyzeEEG_All(IncAll,17);

% für SOAs aufgetrennt
[EEG_data{6, 10:16}] = deal('SOA 0', 'SOA 50', 'SOA 200', 'SOA 600', 'SOA times','N trials A/M/S0','SD A/M/S0');
[EEG_data{7, 10:16}] = AnalyzeEEG_All_SOA(IncAll,21);
[EEG_data{8, 10:16}] = AnalyzeEEG_All_SOA(IncAll,5);
[EEG_data{9, 10:16}] = AnalyzeEEG_All_SOA(IncAll,14);
%[EEG_data{10, 10:16}] = AnalyzeEEG_All_SOA(IncAll,17);



% save EEG_data.mat EEG_data -v7.3

% set(0,'DefaultFigureVisible','on');

% load('EEG_data.mat')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% ------------ Test anderer Reihenfolge der corrections ------------- %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ---> doesn't make a difference whether first baseline and then motor (our approach)
%      or first motor and then baseline correction 


% cd('../Figures')
% clear EEG_rev
% for sb = 1:Nsub
%     [soa,SD,N,EEGtime] = AnalyzeEEG_reverse(21,subject{sb});
%     for s = 1:4 % different SOAs
%         EEG_rev(s).Mnosound(sb,:) = soa(s).datanosound(end,:);
%         EEG_rev(s).Mnopress(sb,:) = soa(1).datanopress(end,:);
%         EEG_rev(s).Msound(sb,:) = soa(s).dataSOA(end,:);
%         EEG_rev(s).SDnosound(sb,:) = SD(s).ns(end,:);
%         EEG_rev(s).SDnopress(sb,:) = SD(1).np(end,:);
%         EEG_rev(s).SDsound(sb,:) = SD(s).s(end,:);
%     end
%     EEG_rev(1).Nns(sb,1) = N.ns;
%     EEG_rev(1).Nnp(sb,1) = N.np;
%     EEG_rev(1).Ns(sb,:) = N.s;
%     EEG_rev(1).EEGtime(sb,:) = EEGtime;
% 
%     figure('Position', [150,100, 1200, 600])
%     subplot(2,3,1) % No sound
%     hold on
%     plot([0 0], [-35 35], 'Color', [153/255, 153/255, 153/255], 'LineWidth', 1)
%     plot([-200 400], [0 0], 'Color', [153/255, 153/255, 153/255], 'LineWidth', 1)
%     %fill([EEG_rev(1).EEGtime(sb,:),EEG_rev(1).EEGtime(sb,end:-1:1)], [EEG_data{7,3}(sb,:)-(EEG_data{7,9}{sb,1}.ns(end,:)/sqrt(EEG_data{7,8}{sb,1}.ns)),flip(EEG_data{7,3}(sb,:)+(EEG_data{7,9}{sb,1}.ns(end,:)/sqrt(EEG_data{7,8}{sb,1}.ns)))])
%     plot([EEG_data{7,7}], [EEG_data{7,3}(sb,:)],'k')
%     %fill([EEG_rev(1).EEGtime(sb,:),EEG_rev(1).EEGtime(sb,end:-1:1)],[])
%     plot([EEG_rev(1).EEGtime(sb,:)],[EEG_rev(1).Mnosound(sb,:)+1],'r')
%     xlim([-200 400])
%     ylim([-30 30])
%     title([subject{1,sb}(1:end-3) ' | No Sound | N = ' num2str(EEG_rev(1).Nns(sb))])
% 
%     subplot(2,3,2) % no press
%     hold on
%     plot([0 0], [-35 35], 'Color', [153/255, 153/255, 153/255], 'LineWidth', 1)
%     plot([-200 400], [0 0], 'Color', [153/255, 153/255, 153/255], 'LineWidth', 1)
%     plot([EEG_data{7,7}], [EEG_data{7,2}(sb,:)],'k')
%     plot([EEG_rev(1).EEGtime(sb,:)],[EEG_rev(1).Mnopress(sb,:)],'r')
%     xlim([-200 400])
%     ylim([-30 30])
%     title([subject{1,sb}(1:end-3) ' | No Press | N = ' num2str(EEG_rev(1).Nnp(sb))])
% 
%     subplot(2,3,3) % SOA 0
%     hold on
%     plot([0 0], [-35 35], 'Color', [153/255, 153/255, 153/255], 'LineWidth', 1)
%     plot([-200 400], [0 0], 'Color', [153/255, 153/255, 153/255], 'LineWidth', 1)
%     plot([EEG_data{7,7}], [EEG_data{7,10}(sb,:)],'k')
%     plot([EEG_rev(1).EEGtime(sb,:)],[EEG_rev(1).Msound(sb,:)],'r')
%     xlim([-200 400])
%     ylim([-30 30])
%     title([subject{1,sb}(1:end-3) ' | SOA 0 | N = ' num2str(EEG_rev(1).Ns(sb,1))])
% 
%     subplot(2,3,4) % SOA 50
%     hold on
%     plot([0 0], [-35 35], 'Color', [153/255, 153/255, 153/255], 'LineWidth', 1)
%     plot([-200 400], [0 0], 'Color', [153/255, 153/255, 153/255], 'LineWidth', 1)
%     plot([EEG_data{7,7}], [EEG_data{7,11}(sb,:)],'k')
%     plot([EEG_rev(1).EEGtime(sb,:)],[EEG_rev(2).Msound(sb,:)],'r')
%     xlim([-200 400])
%     ylim([-30 30])
%     title([subject{1,sb}(1:end-3) ' | SOA 50 | N = ' num2str(EEG_rev(1).Ns(sb,2))])
% 
%     subplot(2,3,5) % SOA 200
%     hold on
%     plot([0 0], [-35 35], 'Color', [153/255, 153/255, 153/255], 'LineWidth', 1)
%     plot([-200 400], [0 0], 'Color', [153/255, 153/255, 153/255], 'LineWidth', 1)
%     plot([EEG_data{7,7}], [EEG_data{7,12}(sb,:)],'k')
%     plot([EEG_rev(1).EEGtime(sb,:)],[EEG_rev(3).Msound(sb,:)],'r')
%     xlim([-200 400])
%     ylim([-30 30])
%     title([subject{1,sb}(1:end-3) ' | SOA 200 | N =' num2str(EEG_rev(1).Ns(sb,3))])
%     
%     subplot(2,3,6) % SOA 600
%     hold on
%     plot([0 0], [-35 35], 'Color', [153/255, 153/255, 153/255], 'LineWidth', 1)
%     plot([-200 400], [0 0], 'Color', [153/255, 153/255, 153/255], 'LineWidth', 1)
%     plot([EEG_data{7,7}], [EEG_data{7,13}(sb,:)],'k')
%     plot([EEG_rev(1).EEGtime(sb,:)],[EEG_rev(4).Msound(sb,:)],'r')
%     xlim([-200 400])
%     ylim([-30 30])
%     title([subject{1,sb}(1:end-3) ' | SOA 600 | N =' num2str(EEG_rev(1).Ns(sb,4))])
%     
%     saveas(gcf, ['Baseline_Alex_' subject{1,sb}(1:end-3) '.png'])
% end
% 
% cd('../EEG')


%%% ------------  2.0.1 raw Zeitverläufe aller Probanden ------------ %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% einfach mal für jede condition die Zeitverläufe angeschaut --> ziemliches
% Chaos: Subject-Korrektur nötig (??)

figure('Position', [150,100, 1200, 600])
subplot(2,4,1)
hold on 
for sb = 1:Nsub
    plot(EEG_data{7,7}, EEG_data{7,2}(sb,:))
end
title('no Press (A)')
subplot(2,4,2)
hold on 
for sb = 1:Nsub
    plot(EEG_data{7,7}, EEG_data{7,3}(sb,:))
end
title('no Sound (M)')
subplot(2,4,5)
hold on 
for sb = 1:Nsub
    plot(EEG_data{7,7}, EEG_data{7,10}(sb,:))
end
title('0 ms')
subplot(2,4,6)
hold on 
for sb = 1:Nsub
    plot(EEG_data{7,7}, EEG_data{7,11}(sb,:))
end
title('50 ms')
subplot(2,4,7)
hold on 
for sb = 1:Nsub
    plot(EEG_data{7,7}, EEG_data{7,12}(sb,:))
end
title('200 ms')
subplot(2,4,8)
hold on 
for sb = 1:Nsub
    plot(EEG_data{7,7}, EEG_data{7,13}(sb,:))
end
title('600 ms')

cd('../Figures')
saveas(gcf, 'Raw_ERP.png')
% cd('../EEG')


%%% ------------- 2.0.2 Bewegungs-Korrektur Beispiel ------------------ %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ERP Form motor only von motor-auditory abziehen (SOA 0)
% subplot A) motor-only curve + motor-auditory curve uncorrected
% subplot B) motor-auditory uncorrected + corrected
% for each subject, at the moment electrode FCz used

cd('../Figures')
for sb = 1:Nsub
    figure('Position', [200, 150, 850, 600])
    subplot(2,1,1)
    hold on
    plot([0 0], [-15 15], 'Color', [153/255, 153/255, 153/255], 'LineWidth', 1)
    plot([-200 400], [0 0], 'Color', [153/255, 153/255, 153/255], 'LineWidth', 1)
    plot([EEG_data{9,7}], [EEG_data{9,3}(sb,:)], 'k', 'LineWidth', 1) % motor-only
    plot([EEG_data{9,7}], [EEG_data{9,4}(sb,:)], 'Color', [128/255, 201/255, 255/255], 'LineWidth', 1) % motor-auditory
    ylim([-15, 15])
    xlim([-200, 400])
    ylabel('mean amplitude [µV]')
    %xlabel('time relative to tone onset [ms]')
    legend({'', '', 'Motor-Only', 'Motor-Auditory uncorrected'}, 'Location', 'northwest')
    %title(['Cz | ' EEG_data{1,sb+1}])
    
    subplot(2,1,2)
    hold on
    plot([0 0], [-15 15], 'Color', [153/255, 153/255, 153/255], 'LineWidth', 1)
    plot([-200 400], [0 0], 'Color', [153/255, 153/255, 153/255], 'LineWidth', 1)
    plot([EEG_data{9,7}], [EEG_data{9,4}(sb,:)], 'Color', [128/255, 201/255, 255/255], 'LineWidth', 1) % uncorrected
    plot([EEG_data{9,7}], [EEG_data{9,5}(sb,:)], 'Color', [21/255, 45/255, 255/255], 'LineWidth', 1) % corrected
    ylim([-15, 15])
    xlim([-200, 400])
    ylabel('mean amplitude [µV]')
    xlabel('time relative to tone onset [ms]')
    legend({'', '', 'Motor-Auditory uncorrected', 'Motor-Auditory corrected'}, 'Location', 'northwest')

    saveas(gcf, ['Motor_Correction_Cz_' EEG_data{1,sb+1} '.png'])
end
cd('../EEG')



%%% ---------------- 2.0.4 N1, P2 Peak Intervalle --------------------- %%%      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Elisabeth Manuskript:
% - population peak 80-120ms
%    - vorher über alle Elektroden, subjects, conditions gemittelt -> grand mean
% - peak +/- 20ms = Intervall

% Leonie: N1 (~100ms), P2 (~200ms)
% ERP overview paper: N1 (90-200ms), P2 (100 - 250ms)
% hier Peak suchen: N1 (100-180ms), P2 (180ms-300ms)

% Grand mean: EEG_data: 1) subjects, 2) electrode, 3) condition (A, SOAs)
% No Sound condition weggelassen, oder auch mit rein nehmen?
peaks = EEG_data(6,[1,7,2,10:13]);
peaks(2:4,1) = EEG_data(7:9,1);
peaks(2:4,2) = EEG_data(7:9,7);

% mean over subjects
for el = 1:3
    peaks{el+1,3} = mean([EEG_data{el+6,2}],1); % NoPress
    peaks{el+1,4} = mean([EEG_data{el+6,10}],1); % SOA 0
    peaks{el+1,5} = mean([EEG_data{el+6,11}],1); % SOA 50
    peaks{el+1,6} = mean([EEG_data{el+6,12}],1); % SOA 200
    peaks{el+1,7} = mean([EEG_data{el+6,13}],1); % SOA 600
end

% mean over electrodes
peaks{6,1} = 'µ electrodes 1-3';
%peaks{7,1} = 'µ electrodes 1-4';
for con = 2:size(peaks,2)
    peaks{6,con} = mean([peaks{2,con};peaks{3,con};peaks{4,con}],1);
%    peaks{7,con} = mean([peaks{2,con};peaks{3,con};peaks{4,con};peaks{5,con}],1);
end

% mean over conditions: Grand mean
peaks{8,1} = 'Grand Mean 1-3';
peaks{8,2} = mean([peaks{6,3};peaks{6,4};peaks{6,5};peaks{6,6};peaks{6,7}],1);

% Grand mean +M1
% peaks{9,1} = 'Grand Mean 1-4';
% peaks{9,2} = mean([peaks{7,3};peaks{7,4};peaks{7,5};peaks{7,6};peaks{7,7}],1);

% Peak von N1, P2 finden, wo EEGtime zwischen 100-180ms/180-300ms liegt
[peaks{11:12,1}] = deal('peak N1', 'peak P2');
%[peaks{13:14,1}] = deal('peak N1 +M1', 'peak P2 +M1');

[peaks{10,2:4}] = deal('amplitude', 'timepoint','index');
peaks{11,2} = min([peaks{8,2}([peaks{6,2}]>=100 & [peaks{6,2}]<=180)]);
peaks{12,2} = max([peaks{8,2}([peaks{6,2}]>=180 & [peaks{6,2}]<=300)]);

% peaks{13,2} = min([peaks{9,2}([peaks{7,2}]>=100 & [peaks{7,2}]<=180)]);
% peaks{14,2} = max([peaks{9,2}([peaks{7,2}]>=180 & [peaks{7,2}]<=300)]);

[peaks{11,3:4}] = deal(peaks{6,2}([peaks{8,2}] == peaks{11,2}), find([peaks{8,2}] == peaks{11,2}));
[peaks{12,3:4}] = deal(peaks{6,2}([peaks{8,2}] == peaks{12,2}), find([peaks{8,2}] == peaks{12,2}));

% [peaks{13,3:4}] = deal(peaks{7,2}([peaks{9,2}] == peaks{13,2}), find([peaks{9,2}] == peaks{13,2}));
% [peaks{14,3:4}] = deal(peaks{7,2}([peaks{9,2}] == peaks{14,2}), find([peaks{9,2}] == peaks{14,2}));

% Intevall um Peak (+/- 40ms)
[peaks{10:12,5}] = deal('intervals', [peaks{11,3}-40, peaks{11,3}+40], [peaks{12,3}-40,peaks{12,3}+40]);
[peaks{10:12,6}] = deal('index interval', [find(EEG_data{7,7}==peaks{11,5}(1)),find(EEG_data{7,7}==peaks{11,5}(2))], [find(EEG_data{7,7}==peaks{12,5}(1)),find(EEG_data{7,7}==peaks{12,5}(2))]);
% [peaks{13:14,5}] = deal([peaks{13,3}-40, peaks{13,3}+40], [peaks{14,3}-40,peaks{14,3}+40]);
% [peaks{13:14,6}] = deal([find(EEG_data{7,7}==peaks{13,5}(1)),find(EEG_data{7,7}==peaks{13,5}(2))], [find(EEG_data{7,7}==peaks{14,5}(1)),find(EEG_data{7,7}==peaks{14,5}(2))]);


figure('Position', [200, 150, 800, 600])
hold on
f2 = fill([peaks{11,3}-40,peaks{11,3}+40,peaks{11,3}+40,peaks{11,3}-40], [-10,-10,10,10],'w','EdgeColor',[153/255, 153/255, 153/255],'LineStyle','--','FaceAlpha',0);
fill([peaks{12,3}-40,peaks{12,3}+40,peaks{12,3}+40,peaks{12,3}-40], [-10,-10,10,10],'w','EdgeColor',[153/255, 153/255, 153/255],'LineStyle','--','FaceAlpha',0);

plot([-200, 400], [0, 0], 'Color',[153/255, 153/255, 153/255]) % Null-Linie
plot([0,0], [-15, 15], 'Color',[153/255, 153/255, 153/255]) % Null-Linie

plot([peaks{6,2}],[peaks{8,2}], 'k')

xlim([-200, 400])
ylim([-15, 15])
%title('Grand Mean of everything')
legend(f2,{'Interval'}, 'Location','northwest')
xlabel('time relative to tone onset [ms]')
ylabel('mean amplitude [µV]')

saveas(gcf, 'Interval_GrandMean_notitle.png')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% innerhalb Intervall nach einem lokalen min/max suchen
% um dieses Min/max dann +/- 20ms dann mitteln??
% ---> man könnte parallel dann auch Zeitpunkt des peaks raussuchen und
% vergleichen (statistisch)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% - als Kontrolle für Intervallbreite
% - subplot für jeden Probanden
% - mit verschiedenen Farben ERP für die verschiedenen conditions
% - noch grand mean Intervallfenster drüber legen
% - pro Proband & condition: mean, median, SEM


% mean SD & mean N over electrodes, rows = subjects, columns = conditions
% (A, M, SOAs)
m_sdel = cell(Nsub,6);
m_nel = cell(Nsub,6);
for sb = 1:Nsub
    m_sdel{sb,1} = mean([EEG_data{7,9}{sb,1}.np(end,:);EEG_data{8,9}{sb,1}.np(end,:);EEG_data{9,9}{sb,1}.np(end,:)]); % np
    m_nel{sb,1} = mean([EEG_data{7,8}{sb,1}.np, EEG_data{8,8}{sb,1}.np, EEG_data{9,8}{sb,1}.np]);
    m_sdel{sb,2} = mean([EEG_data{7,9}{sb,1}.ns(end,:);EEG_data{8,9}{sb,1}.ns(end,:);EEG_data{9,9}{sb,1}.ns(end,:)]); % ns
    m_nel{sb,2} = mean([EEG_data{7,8}{sb,1}.ns, EEG_data{8,8}{sb,1}.ns, EEG_data{9,8}{sb,1}.ns]);
    m_sdel{sb,3} = mean([EEG_data{7,16}{sb,1}(1).s(end,:);EEG_data{8,16}{sb,1}(1).s(end,:);EEG_data{9,16}{sb,1}(1).s(end,:)]); % soa 0
    m_nel{sb,3} = mean([EEG_data{7,15}{sb,1}.s(1), EEG_data{8,15}{sb,1}.s(1),EEG_data{9,15}{sb,1}.s(1)]);
    m_sdel{sb,4} = mean([EEG_data{7,16}{sb,1}(2).s(end,:);EEG_data{8,16}{sb,1}(2).s(end,:);EEG_data{9,16}{sb,1}(2).s(end,:)]); % soa 50
    m_nel{sb,4} = mean([EEG_data{7,15}{sb,1}.s(2), EEG_data{8,15}{sb,1}.s(2),EEG_data{9,15}{sb,1}.s(2)]);
    m_sdel{sb,5} = mean([EEG_data{7,16}{sb,1}(3).s(end,:);EEG_data{8,16}{sb,1}(3).s(end,:);EEG_data{9,16}{sb,1}(3).s(end,:)]); % soa 200
    m_nel{sb,5} = mean([EEG_data{7,15}{sb,1}.s(3), EEG_data{8,15}{sb,1}.s(3),EEG_data{9,15}{sb,1}.s(3)]);
    m_sdel{sb,6} = mean([EEG_data{7,16}{sb,1}(4).s(end,:);EEG_data{8,16}{sb,1}(4).s(end,:);EEG_data{9,16}{sb,1}(4).s(end,:)]); % soa 600
    m_nel{sb,6} = mean([EEG_data{7,15}{sb,1}.s(4), EEG_data{8,15}{sb,1}.s(4),EEG_data{9,15}{sb,1}.s(4)]);

    m_sdel{sb,8} = mean([EEG_data{7,9}{sb,1}.s0(end,:);EEG_data{8,9}{sb,1}.s0(end,:);EEG_data{9,9}{sb,1}.s0(end,:)]); % SOA 0 aus erstem Analyze_All Skript (als Kontrolle)
end

% Test ob SOA 0 aus beiden Skripten gleiche SD hat
for sb = 1:Nsub
    if m_sdel{sb,3} ~= m_sdel{sb,8}
        disp(sb)
        find([m_sdel{sb,3}] ~= [m_sdel{sb,8}]);
    else
        disp(sb)
        disp('correct')
    end
end

% mean over electrodes
intv_ctrl = EEG_data(6, [1:3,10:13]);
intv_ctrl(1:Nsub+1,1) = EEG_data(1,1:Nsub+1);
condi = [2:3,10:13];
%cols = [204/255,204/255,0/255;0/255, 204/255, 0/255; 0/255,204/255,204/255;0/255,0/255,204/255;204/255,0/255,204/255;204/255,0/255,0/255];
cols = [180/255, 180/255, 180/255];

cd('../Figures')
for sb = 2:Nsub+1 % for each subject
    figure('Position',[50, 50, 1400, 700])
    
    for c = 1:length(condi) % for each condition
        %intv_ctrl{1,c+1} = EEG_data{6,condi(c)};
        %mean over electrodes
        intv_ctrl{sb,c+1}(1,:) = mean([EEG_data{7,condi(c)}(sb-1,:); EEG_data{8,condi(c)}(sb-1,:);EEG_data{9,condi(c)}(sb-1,:)],1); % mean of condition for subject in 1. row
        intv_ctrl{sb,c+1}(2,:) = median([EEG_data{7,condi(c)}(sb-1,:); EEG_data{8,condi(c)}(sb-1,:);EEG_data{9,condi(c)}(sb-1,:)],1); % median in 2. row
        intv_ctrl{sb,c+1}(3,:) = [m_sdel{sb-1,c}]./m_nel{sb-1,c}; % Standardfehler in 3. Reihe
        
        Nmin = find(intv_ctrl{sb,c+1}(1,:) == min(intv_ctrl{sb,c+1}(1,peaks{11,6}(1):peaks{11,6}(2))));
        Pmax = find(intv_ctrl{sb,c+1}(1,:) == max(intv_ctrl{sb,c+1}(1,peaks{12,6}(1):peaks{12,6}(2))));

        subplot(3,3,c)
        hold on
%         fill([peaks{11,3}-20,peaks{11,3}+20,peaks{11,3}+20,peaks{11,3}-20], [-15,-15,15,15],'w','EdgeColor',[153/255, 153/255, 153/255],'LineStyle','--'); % grand mean Intervall N1
%         fill([peaks{12,3}-20,peaks{12,3}+20,peaks{12,3}+20,peaks{12,3}-20], [-15,-15,15,15],'w','EdgeColor',[153/255, 153/255, 153/255],'LineStyle','--'); % grand mean Intervall P2
%         
        fill([EEG_data{7,7}(Nmin)-20, EEG_data{7,7}(Nmin)+20, EEG_data{7,7}(Nmin)+20, EEG_data{7,7}(Nmin)-20], [-15, -15, 15, 15], 'w', 'EdgeColor', 'r', 'LineStyle','--'); % personal Interval N1
        fill([EEG_data{7,7}(Pmax)-20, EEG_data{7,7}(Pmax)+20, EEG_data{7,7}(Pmax)+20, EEG_data{7,7}(Pmax)-20], [-15, -15, 15, 15], 'w', 'EdgeColor', 'r', 'LineStyle','--'); % personal Interval N1
        

        plot([-200, 400], [0, 0], 'Color',[153/255, 153/255, 153/255]) % Null-Linie
        plot([0,0], [-15, 15], 'Color',[153/255, 153/255, 153/255]) % Null-Linie
        
        fill([EEG_data{7,7}(1:end),EEG_data{7,7}(end:-1:1)], [[intv_ctrl{sb,c+1}(1,:)]-[intv_ctrl{sb,c+1}(3,:)], flip([intv_ctrl{sb,c+1}(1,:)]+[intv_ctrl{sb,c+1}(3,:)])],'k', 'FaceAlpha',0.3,'EdgeColor','none');
        p1 = plot([EEG_data{7,7}],[intv_ctrl{sb,c+1}(1,:)],"Color",'b'); % mean
        p2 = plot([EEG_data{7,7}],[intv_ctrl{sb,c+1}(2,:)],'k--'); % median

        title([intv_ctrl{sb,1} ' | ' intv_ctrl{1,c+1} ' | N=' num2str(m_nel{sb-1,c})])
        xlabel('time [ms]')
        ylabel('mean amplitude [µV]')
        xlim([-200 400])
        ylim([-15 15])
        %legend([f1,p1,p2,f2],{'grand mean interval','mean','median','SE'}, 'Location','northwest')
    end
    % als 7. plot noch mean über die Bedingungen
    mittel = mean([[intv_ctrl{sb,2}(1,:)];[intv_ctrl{sb,4}(1,:)];[intv_ctrl{sb,5}(1,:)];[intv_ctrl{sb,6}(1,:)];[intv_ctrl{sb,7}(1,:)]],1);
    mittel_sd = mean([[intv_ctrl{sb,2}(3,:)];[intv_ctrl{sb,4}(3,:)];[intv_ctrl{sb,5}(3,:)];[intv_ctrl{sb,6}(3,:)];[intv_ctrl{sb,7}(3,:)]],1);
    mittel_n = mean([m_nel{sb-1,1},m_nel{sb-1,3},m_nel{sb-1,4},m_nel{sb-1,5},m_nel{sb-1,6}]);
    mini = find(mittel == min(mittel(peaks{11,6}(1):peaks{11,6}(2))));
    maxi = find(mittel == max(mittel(peaks{12,6}(1):peaks{12,6}(2))));

    subplot(3,3,7)
    hold on
%     fgm = fill([peaks{11,3}-20,peaks{11,3}+20,peaks{11,3}+20,peaks{11,3}-20], [-15,-15,15,15],'w','EdgeColor',[153/255, 153/255, 153/255],'LineStyle','--'); % Intervall N1 grand mean
%     fill([peaks{12,3}-20,peaks{12,3}+20,peaks{12,3}+20,peaks{12,3}-20], [-15,-15,15,15],'w','EdgeColor',[153/255, 153/255, 153/255],'LineStyle','--'); % Intervall P2
    
    fpm = fill([EEG_data{7,7}(1,mini)-20,EEG_data{7,7}(1,mini)+20,EEG_data{7,7}(1,mini)+20,EEG_data{7,7}(1,mini)-20],[-15,-15,15,15],'w','EdgeColor','r','LineStyle','--'); % Interval N1, personal mean
    fill([EEG_data{7,7}(1,maxi)-20,EEG_data{7,7}(1,maxi)+20,EEG_data{7,7}(1,maxi)+20,EEG_data{7,7}(1,maxi)-20],[-15,-15,15,15],'w','EdgeColor','r','LineStyle','--')% Intervall P2, personal mean
    
    plot([-200, 400], [0, 0], 'Color',[153/255, 153/255, 153/255]) % Null-Linie
    plot([0,0], [-15, 15], 'Color',[153/255, 153/255, 153/255]) % Null-Linie
    
    fs = fill([EEG_data{7,7}(1:end),EEG_data{7,7}(end:-1:1)], [[mittel-mittel_sd], flip([mittel+mittel_sd])],'k', 'FaceAlpha',0.3,'EdgeColor','none');
    plot([EEG_data{7,7}], mittel,'b');
    
    title([intv_ctrl{sb,1} ' | mean over conditions | N=' num2str(mittel_n)])
    xlabel('time [ms]')
    ylabel('mean amplitude [µV]')
    xlim([-200 400])
    ylim([-15 15])
    lg = legend([fpm,p1,p2,fs],{'personal mean interval','mean','median','SE'},'Location','bestoutside');
    set(lg, 'Position',[0.4,0.15,0.13,0.13])
    saveas(gcf,['Interval_' intv_ctrl{sb,1}  '.png'])
end


%%%%%%%%%%%%%% Varianzkontrolle ERP Form %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd('../Figures')
for c = 1:length(condi) % for each condition figure 
    figure('Position',[150,55,1200,720])
    
    for sb = 1:Nsub % for each subjectc = 1:length(condi) 
        subplot(6,4,sb)
        hold on
        plot([-200, 400], [0, 0], 'Color',[153/255, 153/255, 153/255]) % Null-Linie
        plot([0,0], [-35, 35], 'Color',[153/255, 153/255, 153/255]) % Null-Linie
        
        fs = fill([EEG_data{7,7}(1:end),EEG_data{7,7}(end:-1:1)], [[intv_ctrl{sb+1,c+1}(1,:)]-m_sdel{sb,c}, flip([intv_ctrl{sb+1,c+1}(1,:)]+m_sdel{sb,c})],'k', 'FaceAlpha',0.3,'EdgeColor','none');
        p1 = plot([EEG_data{7,7}],[intv_ctrl{sb+1,c+1}(1,:)],"Color",'b'); % mean
        p2 = plot([EEG_data{7,7}],[intv_ctrl{sb+1,c+1}(2,:)],'k--'); % median

        title([intv_ctrl{1,c+1} ' | ' intv_ctrl{sb+1,1} ' | N =' num2str(m_nel{sb,c})])
        xlabel('time [ms]')
        ylabel('mean amplitude [µV]')
        xlim([-200 400])
        ylim([-35 35])
        %legend([f1,p1,p2,f2],{'grand mean interval','mean','median','SE'}, 'Location','northwest')
    end
    lg = legend([p1,p2,fs],{'mean','median','SD'},'Location','bestoutside');
    set(lg, 'Position',[0.56,0.09,0.13,0.13])
    saveas(gcf,['Varianzkontrolle_' intv_ctrl{1,c+1}  '.png'])
end
cd('../EEG')


%%% --------------- 2.0.3 Subject-Variance Korrektur ------------------ %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% details siehe OneNote
% für jede Eletrode getrennt

% FCz
fcz_data{2,1} = 'SM';
[fcz_data{1,2:6}] = deal('A vs. 0', 'A vs. 50', 'A vs. 200', 'A vs. 600', 'SOAs');
% Fz
fz_data{2,1} = 'SM';
[fz_data{1,2:6}] = deal('A vs. 0', 'A vs. 50', 'A vs. 200', 'A vs. 600', 'SOAs');
% Cz
cz_data{2,1} = 'SM';
[cz_data{1,2:6}] = deal('A vs. 0', 'A vs. 50', 'A vs. 200', 'A vs. 600', 'SOAs');
% M1
% m1_data{2,1} = 'SM';
% [m1_data{1,2:6}] =  deal('A vs. 0', 'A vs. 50', 'A vs. 200', 'A vs. 600', 'SOAs');

% A vs. soas (2, 2:5)
for soa = 1:4
    fcz_data{2, soa+1} = zeros(Nsub, length(EEG_data{7,7}));
    fz_data{2, soa+1} = zeros(Nsub, length(EEG_data{8,7}));
    cz_data{2, soa+1} = zeros(Nsub, length(EEG_data{9,7}));
%     m1_data{2, soa+1} = zeros(Nsub, length(EEG_data{9,7}));
    for sb = 1:Nsub
        for t = 1: length(EEG_data{7,7})
            fcz_data{2, soa+1}(sb,t) = mean([EEG_data{7,2}(sb,t), EEG_data{7,soa+9}(sb,t)]);
            fz_data{2, soa+1}(sb,t) = mean([EEG_data{8,2}(sb,t), EEG_data{8,soa+9}(sb,t)]);
            cz_data{2, soa+1}(sb,t) = mean([EEG_data{9,2}(sb,t), EEG_data{9,soa+9}(sb,t)]);
%             m1_data{2, soa+1}(sb,t) = mean([EEG_data{10,2}(sb,t), EEG_data{10,soa+9}(sb,t)]);
        end
    end
end

% soas untereinander
fcz_data{2,6} = zeros(Nsub, length(EEG_data{7,7}));
fz_data{2,6} = zeros(Nsub, length(EEG_data{7,7}));
cz_data{2,6} = zeros(Nsub, length(EEG_data{7,7}));
%m1_data{2,6} = zeros(Nsub, length(EEG_data{7,7}));

for sb = 1:Nsub
    for t = 1: length(EEG_data{7,7})
        fcz_data{2, 6}(sb,t) = mean([EEG_data{7,10}(sb,t), EEG_data{7,11}(sb,t), EEG_data{7,12}(sb,t), EEG_data{7,13}(sb,t)]);
        fz_data{2, 6}(sb,t) = mean([EEG_data{8,10}(sb,t), EEG_data{8,11}(sb,t), EEG_data{8,12}(sb,t), EEG_data{8,13}(sb,t)]);
        cz_data{2, 6}(sb,t) = mean([EEG_data{9,10}(sb,t), EEG_data{9,11}(sb,t), EEG_data{9,12}(sb,t), EEG_data{9,13}(sb,t)]);
%        m1_data{2, 6}(sb,t) = mean([EEG_data{10,10}(sb,t), EEG_data{10,11}(sb,t), EEG_data{10,12}(sb,t), EEG_data{10,13}(sb,t)]);
    end
end


% GM (pro Zeitpunkt über alle subjects)
fcz_data{3,1} = 'GM';
fz_data{3,1} = 'GM';
cz_data{3,1} = 'GM';
%m1_data{3,1} = 'GM';
for v = 2: size(fcz_data, 2)
    fcz_data{3,v} = mean(fcz_data{2,v},1);
    fz_data{3,v} = mean(fz_data{2,v},1);
    cz_data{3,v} = mean(cz_data{2,v},1);
%    m1_data{3,v} = mean(m1_data{2,v},1);
end

% SM - GM
fcz_data{4,1} = 'SM - GM';
fz_data{4,1} = 'SM - GM';
cz_data{4,1} = 'SM - GM';
%m1_data{4,1} = 'SM - GM';
for sb = 2: size(fcz_data, 2)
    fcz_data{4,sb} = fcz_data{2,sb} - fcz_data{3,sb};
    fz_data{4,sb} = fz_data{2,sb} - fz_data{3,sb};
    cz_data{4,sb} = cz_data{2,sb} - cz_data{3,sb};
%    m1_data{4,sb} = m1_data{2,sb} - m1_data{3,sb};
end


%%% ------------- 2.1 figure 8: example ERP Form ---------------------- %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4 subplots: für jedes SOA + auditory-only dazu in jedem

[com_EEG_A0{1, 2:3}] = deal('A', 'SOA 0');
[com_EEG_A0{2:4, 1}] = deal('FCz', 'Fz', 'Cz');

[com_EEG_A50{1, 2:3}] = deal('A', 'SOA 50');
[com_EEG_A50{2:4, 1}] = deal('FCz', 'Fz', 'Cz');

[com_EEG_A200{1, 2:3}] = deal('A', 'SOA 200');
[com_EEG_A200{2:4, 1}] = deal('FCz', 'Fz', 'Cz');

[com_EEG_A600{1, 2:3}] = deal('A', 'SOA 600');
[com_EEG_A600{2:4, 1}] = deal('FCz', 'Fz', 'Cz');

% A FCz, Fz, Cz
com_EEG_A0{2,2} = EEG_data{7,2} - fcz_data{4,2};
com_EEG_A0{3,2} = EEG_data{8,2} - fz_data{4,2};
com_EEG_A0{4,2} = EEG_data{9,2} - cz_data{4,2};

com_EEG_A50{2,2} = EEG_data{7,2} - fcz_data{4,3};
com_EEG_A50{3,2} = EEG_data{8,2} - fz_data{4,3};
com_EEG_A50{4,2} = EEG_data{9,2} - cz_data{4,3};

com_EEG_A200{2,2} = EEG_data{7,2} - fcz_data{4,4};
com_EEG_A200{3,2} = EEG_data{8,2} - fz_data{4,4};
com_EEG_A200{4,2} = EEG_data{9,2} - cz_data{4,4};

com_EEG_A600{2,2} = EEG_data{7,2} - fcz_data{4,5};
com_EEG_A600{3,2} = EEG_data{8,2} - fz_data{4,5};
com_EEG_A600{4,2} = EEG_data{9,2} - cz_data{4,5};

% SOA 0
com_EEG_A0{2,3} = EEG_data{7,10} - fcz_data{4,2};
com_EEG_A0{3,3} = EEG_data{8,10} - fz_data{4,2};
com_EEG_A0{4,3} = EEG_data{9,10} - cz_data{4,2};

% SOA 50
com_EEG_A50{2,3} = EEG_data{7,11} - fcz_data{4,3};
com_EEG_A50{3,3} = EEG_data{8,11} - fz_data{4,3};
com_EEG_A50{4,3} = EEG_data{9,11} - cz_data{4,3};

% SOA 200
com_EEG_A200{2,3} = EEG_data{7,12} - fcz_data{4,4};
com_EEG_A200{3,3} = EEG_data{8,12} - fz_data{4,4};
com_EEG_A200{4,3} = EEG_data{9,12} - cz_data{4,4};

% SOA 600
com_EEG_A600{2,3} = EEG_data{7,13} - fcz_data{4,5};
com_EEG_A600{3,3} = EEG_data{8,13} - fz_data{4,5};
com_EEG_A600{4,3} = EEG_data{9,13} - cz_data{4,5};


% mean
[com_EEG_A0{5:7,1}] = deal('µ FCz (21)', 'µ Fz (05)', 'µ Cz (14)');
[com_EEG_A50{5:7,1}] = deal('µ FCz (21)', 'µ Fz (05)', 'µ Cz (14)');
[com_EEG_A200{5:7,1}] = deal('µ FCz (21)', 'µ Fz (05)', 'µ Cz (14)');
[com_EEG_A600{5:7,1}] = deal('µ FCz (21)', 'µ Fz (05)', 'µ Cz (14)');

[com_EEG_A0{8:10,1}] = deal('SEM FCz (21)', 'SEM Fz (05)', 'SEM Cz (14)');
[com_EEG_A50{8:10,1}] = deal('SEM FCz (21)', 'SEM Fz (05)', 'SEM Cz (14)');
[com_EEG_A200{8:10,1}] = deal('SEM FCz (21)', 'SEM Fz (05)', 'SEM Cz (14)');
[com_EEG_A600{8:10,1}] = deal('SEM FCz (21)', 'SEM Fz (05)', 'SEM Cz (14)');

for el = 2:4 % for each electrode
    for con = 2:3 % for both conditions
        com_EEG_A0{el+3,con} = mean(com_EEG_A0{el,con},1);
        com_EEG_A0{el+6,con} = std(com_EEG_A0{el,con},0,1)/sqrt(Nsub);
        com_EEG_A50{el+3,con} = mean(com_EEG_A50{el,con},1);
        com_EEG_A50{el+6,con} = std(com_EEG_A50{el,con},0,1)/sqrt(Nsub);
        com_EEG_A200{el+3,con} = mean(com_EEG_A200{el,con},1);
        com_EEG_A200{el+6,con} = std(com_EEG_A200{el,con},0,1)/sqrt(Nsub);
        com_EEG_A600{el+3,con} = mean(com_EEG_A600{el,con},1);
        com_EEG_A600{el+6,con} = std(com_EEG_A600{el,con},0,1)/sqrt(Nsub);
    end
end


%%% ------------------ 2.2.2 permutation tests ------------------------ %%%
% condition: A, SOAs
% variable: timepoints
% observations: subjects
[com_EEG_A0{1,4:9}] = deal('Permutationtest personal mean', 'pval','t_orig','crit_t','est_alpha','seed_state');
[com_EEG_A50{1,4:9}] = deal('Permutationtest personal mean', 'pval','t_orig','crit_t','est_alpha','seed_state');
[com_EEG_A200{1,4:9}] = deal('Permutationtest personal mean', 'pval','t_orig','crit_t','est_alpha','seed_state');
[com_EEG_A600{1,4:9}] = deal('Permutationtest personal mean', 'pval','t_orig','crit_t','est_alpha','seed_state');
% permutation test personal peak
[com_EEG_A0{1,10:15}] = deal('Perm personal peak', 'pval','t_orig','crit_t','est_alpha','seed_state');
[com_EEG_A50{1,10:15}] = deal('Perm personal peak', 'pval','t_orig','crit_t','est_alpha','seed_state');
[com_EEG_A200{1,10:15}] = deal('Perm personal peak', 'pval','t_orig','crit_t','est_alpha','seed_state');
[com_EEG_A600{1,10:15}] = deal('Perm personal peak', 'pval','t_orig','crit_t','est_alpha','seed_state');
% paired t-test personal mean
[com_EEG_A0{5,4:7}] = deal('t-test', 'h','p', 'stats');
[com_EEG_A50{5,4:7}] = deal('t-test', 'h','p', 'stats');
[com_EEG_A200{5,4:7}] = deal('t-test', 'h','p','stats');
[com_EEG_A600{5,4:7}] = deal('t-test', 'h','p', 'stats');
% paired t-test personal peak
[com_EEG_A0{5,10:13}] = deal('t-test', 'h','p', 'stats');
[com_EEG_A50{5,10:13}] = deal('t-test', 'h','p', 'stats');
[com_EEG_A200{5,10:13}] = deal('t-test', 'h','p', 'stats');
[com_EEG_A600{5,10:13}] = deal('t-test', 'h','p', 'stats');

 

% 2-way repeated measures ANOVA
% X(:,1) = values
% X(:,2) = condition (A vs. MA)
% X(:,3) = subcondition (SOA)
% X(:,4) = subject
% pro condition jedes SOA, pro SOA jedes subject
t=[Nsub,2*Nsub,3*Nsub,4*Nsub]; % Indexe
for el = 1:3
    SOA_A_N = zeros(Nsub*5,4);
    SOA_A_P = zeros(Nsub*5,4);
    for sb = 1:Nsub
        % A, gibt nur SOA 0
        SOA_A_N(sb,:) = [min(EEG_data{el+6,2}(sb, peaks{11,6}(1):peaks{11,6}(2))), 1, 1, sb];
        SOA_A_P(sb,:) = [max(EEG_data{el+6,2}(sb, peaks{12,6}(1):peaks{12,6}(2))), 1, 1, sb];
    end
    % MA
    for ss = 1:4
        for sb = 1:Nsub
            SOA_A_N(t(ss)+sb,1) = min(EEG_data{el+6,ss+9}(sb,peaks{11,6}(1):peaks{11,6}(2)));
            SOA_A_N(t(ss)+sb,2) = 2;
            SOA_A_N(t(ss)+sb,3) = ss;
            SOA_A_N(t(ss)+sb,4) = sb;

            SOA_A_P(t(ss)+sb,1) = max(EEG_data{el+6,ss+9}(sb,peaks{12,6}(1):peaks{12,6}(2)));
            SOA_A_P(t(ss)+sb,2) = 2;
            SOA_A_P(t(ss)+sb,3) = ss;
            SOA_A_P(t(ss)+sb,4) = sb;
        end
    end
    disp(['el_' num2str(el) 'Anova2_N'])
    RMAOV2(SOA_A_N)
    disp(['el_' num2str(el) 'Anova2_P'])
    RMAOV2(SOA_A_P)
end

% 2-way repeated measures ANOVA results
%FCz
% N

%%% ------------- 2.3 differences between SOAs ------------------------ %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% -- amplitude differences between SOAs angeschaut (only in motor-auditory)
% all ERP forms in one graph (4 curves for 4 SOAs)
% sign tests for N1 und P2: different SOAs compared to each other

[com_EEG_SOA{1, 2:5}] = deal('SOA 0', 'SOA 50', 'SOA 200', 'SOA 600');
[com_EEG_SOA{2:4, 1}] = deal('FCz', 'Fz', 'Cz');
% mean + SOA
[com_EEG_SOA{5:7,1}] = deal('µ FCz (22)', 'µ Fz (05)', 'µ Cz (14)');
[com_EEG_SOA{8:10,1}] = deal('SEM FCz', 'SEM Fz', 'SEM Cz');

for soa = 1:4
    com_EEG_SOA{2,soa+1} = EEG_data{7,soa+9} - fcz_data{4,6};
    com_EEG_SOA{3,soa+1} = EEG_data{8,soa+9} - fz_data{4,6};
    com_EEG_SOA{4,soa+1} = EEG_data{9,soa+9} - cz_data{4,6};

    com_EEG_SOA{5,soa+1} = mean(com_EEG_SOA{2, soa+1},1);
    com_EEG_SOA{6,soa+1} = mean(com_EEG_SOA{3, soa+1},1);
    com_EEG_SOA{7,soa+1} = mean(com_EEG_SOA{4, soa+1},1);

    com_EEG_SOA{8,soa+1} = std(com_EEG_SOA{2,soa+1},0,1)/sqrt(size(com_EEG_SOA{2,soa+1},1));
    com_EEG_SOA{9,soa+1} = std(com_EEG_SOA{3,soa+1},0,1)/sqrt(size(com_EEG_SOA{3,soa+1},1));
    com_EEG_SOA{10,soa+1} = std(com_EEG_SOA{4,soa+1},0,1)/sqrt(size(com_EEG_SOA{4,soa+1},1));
end


%%% ----------------------- permutation test -------------------------- %%%
% mean around personal peak
[com_EEG_SOA{1,7:12}] = deal('Perm mean 0-50', 'pval','t_orig','crit_t','est_alpha','seed_state');
[com_EEG_SOA{1,14:19}] = deal('Perm mean 0-200', 'pval','t_orig','crit_t','est_alpha','seed_state');
[com_EEG_SOA{1,21:26}] = deal('Perm mean 0-600', 'pval','t_orig','crit_t','est_alpha','seed_state');
[com_EEG_SOA{1,28:33}] = deal('Perm mean 50-200', 'pval','t_orig','crit_t','est_alpha','seed_state');
[com_EEG_SOA{1,35:40}] = deal('Perm mean 50-600', 'pval','t_orig','crit_t','est_alpha','seed_state');
[com_EEG_SOA{1,42:47}] = deal('Perm mean 200-600', 'pval','t_orig','crit_t','est_alpha','seed_state');

[com_EEG_SOA{5,7:9}] = deal('t-test mean 0-50', 'h','p');
[com_EEG_SOA{5,14:16}] = deal('t-test mean 0-200', 'h','p');
[com_EEG_SOA{5,21:23}] = deal('t-test mean 0-600', 'h','p');
[com_EEG_SOA{5,28:30}] = deal('t-test mean 50-200', 'h','p');
[com_EEG_SOA{5,35:37}] = deal('t-test mean 50-600', 'h','p');
[com_EEG_SOA{5,42:44}] = deal('t-test mean 200-600', 'h','p');

% personal peak directly
[com_EEG_SOA{9,7:12}] = deal('Perm 0-50', 'pval','t_orig','crit_t','est_alpha','seed_state');
[com_EEG_SOA{9,14:19}] = deal('Perm  0-200', 'pval','t_orig','crit_t','est_alpha','seed_state');
[com_EEG_SOA{9,21:26}] = deal('Perm 0-600', 'pval','t_orig','crit_t','est_alpha','seed_state');
[com_EEG_SOA{9,28:33}] = deal('Perm 50-200', 'pval','t_orig','crit_t','est_alpha','seed_state');
[com_EEG_SOA{9,35:40}] = deal('Perm 50-600', 'pval','t_orig','crit_t','est_alpha','seed_state');
[com_EEG_SOA{9,42:47}] = deal('Perm 200-600', 'pval','t_orig','crit_t','est_alpha','seed_state');

[com_EEG_SOA{13,7:9}] = deal('t-test 0-50', 'h','p');
[com_EEG_SOA{13,14:16}] = deal('t-test 0-200', 'h','p');
[com_EEG_SOA{13,21:23}] = deal('t-test 0-600', 'h','p');
[com_EEG_SOA{13,28:30}] = deal('t-test 50-200', 'h','p');
[com_EEG_SOA{13,35:37}] = deal('t-test 50-600', 'h','p');
[com_EEG_SOA{13,42:44}] = deal('t-test 200-600', 'h','p');

[com_EEG_SOA{12,1:4}] = deal('Kruskal-Wallis meanN', 'p', 'tbl', 'stats');
[com_EEG_SOA{16,1:4}] = deal('Kruskal-Wallis meanP', 'p','tbl', 'stats');
[com_EEG_SOA{20,1:4}] = deal('Anova meanN', 'df', 'F', 'p');
[com_EEG_SOA{24,1:4}] = deal('Anova meanP', 'df', 'F', 'p');

[com_EEG_SOA{28,1:4}] = deal('Kruskal-Wallis indN', 'p','tbl', 'stats');
[com_EEG_SOA{32,1:4}] = deal('Kruskal-Wallis indP', 'p','tbl', 'stats');
[com_EEG_SOA{36,1:4}] = deal('Anova indN', 'df', 'F', 'p');
[com_EEG_SOA{40,1:4}] = deal('Anova indP', 'df', 'F', 'p');


for el = 1:3
    NA = zeros(Nsub,2); % 1. column = personal N peak, 2. column = mean around personal N peak
    N0 = zeros(Nsub,2);
    N5 = zeros(Nsub,2);
    N2 = zeros(Nsub,2);
    N6 = zeros(Nsub,2);
    PA = zeros(Nsub,2); % 1. column = personal N peak, 2. column = mean around personal N peak
    P0 = zeros(Nsub,2);
    P5 = zeros(Nsub,2);
    P2 = zeros(Nsub,2);
    P6 = zeros(Nsub,2);

    for sb = 1:Nsub
        [m,i] = min([EEG_data{el+6,2}(sb,peaks{11,6}(1):peaks{11,6}(2))]);
        NA(sb,1) = m; % personal N peak
        NA(sb,2) = mean(EEG_data{el+6,2}(sb,i+peaks{11,6}(1)-11:i+peaks{11,6}(1)+9)); % mean around personal peak
        
        [m,i] = min([EEG_data{el+6,10}(sb,peaks{11,6}(1):peaks{11,6}(2))]);
        N0(sb,1) = m; % personal N peak
        N0(sb,2) = mean(EEG_data{el+6,10}(sb,i+peaks{11,6}(1)-11:i+peaks{11,6}(1)+9)); % mean around personal peak
        
        [m,i] = min([EEG_data{el+6,11}(sb,peaks{11,6}(1):peaks{11,6}(2))]);
        N5(sb,1) = m; % personal N peak
        N5(sb,2) = mean(EEG_data{el+6,11}(sb,i+peaks{11,6}(1)-11:i+peaks{11,6}(1)+9)); % mean around personal peak
        
        [m,i] = min([EEG_data{el+6,12}(sb,peaks{11,6}(1):peaks{11,6}(2))]);
        N2(sb,1) = m; % personal N peak
        N2(sb,2) = mean(EEG_data{el+6,12}(sb,i+peaks{11,6}(1)-11:i+peaks{11,6}(1)+9)); % mean around personal peak
        
        [m,i] = min([EEG_data{el+6,13}(sb,peaks{11,6}(1):peaks{11,6}(2))]);
        N6(sb,1) = m; % personal N peak
        N6(sb,2) = mean(EEG_data{el+6,13}(sb,i+peaks{11,6}(1)-11:i+peaks{11,6}(1)+9)); % mean around personal peak
        
        [m,i] = max([EEG_data{el+6,2}(sb,peaks{12,6}(1):peaks{12,6}(2))]);
        PA(sb,1) = m; % personal N peak
        PA(sb,2) = mean(EEG_data{el+6,2}(sb,i+peaks{12,6}(1)-11:i+peaks{12,6}(1)+9)); % mean around personal peak
        
        [m,i] = max([EEG_data{el+6,10}(sb,peaks{12,6}(1):peaks{12,6}(2))]);
        P0(sb,1) = m; % personal N peak
        P0(sb,2) = mean(EEG_data{el+6,10}(sb,i+peaks{12,6}(1)-11:i+peaks{12,6}(1)+9)); % mean around personal peak
        
        [m,i] = max([EEG_data{el+6,11}(sb,peaks{12,6}(1):peaks{12,6}(2))]);
        P5(sb,1) = m; % personal N peak
        P5(sb,2) = mean(EEG_data{el+6,11}(sb,i+peaks{12,6}(1)-11:i+peaks{12,6}(1)+9)); % mean around personal peak
        
        [m,i] = max([EEG_data{el+6,12}(sb,peaks{12,6}(1):peaks{12,6}(2))]);
        P2(sb,1) = m; % personal N peak
        P2(sb,2) = mean(EEG_data{el+6,12}(sb,i+peaks{12,6}(1)-11:i+peaks{12,6}(1)+9)); % mean around personal peak
        
        [m,i] = max([EEG_data{el+6,13}(sb,peaks{12,6}(1):peaks{12,6}(2))]);
        P6(sb,1) = m; % personal N peak
        P6(sb,2) = mean(EEG_data{el+6,13}(sb,i+peaks{12,6}(1)-11:i+peaks{12,6}(1)+9)); % mean around personal peak
    end
    
    %%%% SPSS export
    % rows = subjects, column = SOA (erst N1, dann P2), value = PSE
    soapeak = [N0(:,1),N5(:,1),N2(:,1),N6(:,1),P0(:,1),P5(:,1),P2(:,1),P6(:,1)];
    varnames={'N0','N50','N200','N600','P0','P50','P200','P600'};
    save4spss(soapeak,varnames,['SOAvsP2_el' num2str(el) '.dat'])

    % Shapiro-Wilks
    % A vs. SOAs
    disp(el)
    [H, shapna0,~] = swtest([NA(:,1)-N0(:,1)],0.01) % FCz: 0.03, Fz: 0.53, Cz: 0.013
    [H, shapna5,~] = swtest([NA(:,1)-N5(:,1)],0.01) % FCz: 0.73, Fz: 0.49, Cz: 0.13
    [H, shapna2,~] = swtest([NA(:,1)-N2(:,1)],0.01) % FCz: 0.57, Fz: 0.65, Cz: 0.83
    [H, shapna6,~] = swtest([NA(:,1)-N6(:,1)],0.01) % FCz: 0.87, Fz: 0.97, Cz: 0.56
    
    [H, shappa0,~] = swtest([PA(:,1)-P0(:,1)],0.01) % FCz: 0.33, Fz: 0.99, Cz: 0.18
    [H, shappa5,~] = swtest([PA(:,1)-P5(:,1)],0.01) % FCz: 0.93, Fz: 0.60, Cz: 0.37
    [H, shappa2,~] = swtest([PA(:,1)-P2(:,1)],0.01) % FCz: 0.19, Fz: 0.42, Cz: 0.14
    [H, shappa6,~] = swtest([PA(:,1)-P6(:,1)],0.01) % FCz: 0.71, Fz: 0.40, Cz: 0.68
    % SOAs miteinander
    [H,shapn0,~] = swtest(N0(:,1),0.01) % FCz: 0.17, Fz: 1.00, Cz: 0.79
    [H,shapn5,~] = swtest(N5(:,1),0.01) % FCz: 0.64, Fz: 0.40, Cz: 0.04
    [H,shapn2,~] = swtest(N2(:,1),0.01) % FCz: 0.06, Fz: 0.13, Cz: 0.08
    [H,shapn6,~] = swtest(N6(:,1),0.01) % FCz: 0.09, Fz: 0.08, Cz: 0.31

    [H,shapp0,~] = swtest(P0(:,1),0.01) % FCz: 0.62, Fz: 0.25, Cz: 0.57
    [H,shapp5,~] = swtest(P5(:,1),0.01) % FCz: 0.97, Fz: 0.99, Cz: 0.63
    [H,shapp2,~] = swtest(P2(:,1),0.01) % FCz: 0.77, Fz: 0.99, Cz: 0.54
    [H,shapp6,~] = swtest(P6(:,1),0.01) % FCz: 0.36, Fz: 0.54, Cz: 0.64
    % --> all normally distributed -> Anova fine
    
    % permutation test with mean around individual peak
    A = [NA(:,2), PA(:,2)];
    S0 = [N0(:,2), P0(:,2)];
    diff0 = A-S0;
    [com_EEG_A0{el+1,5},com_EEG_A0{el+1,6},com_EEG_A0{el+1,7},com_EEG_A0{el+1,8},com_EEG_A0{el+1,9}] = mult_comp_perm_t1(diff0);
    
    [com_EEG_A0{el+5,5}(1), com_EEG_A0{el+5,6}(1)] = ttest(A(:,1), S0(:,1)); % N peak
    [com_EEG_A0{el+5,5}(2), com_EEG_A0{el+5,6}(2)] = ttest(A(:,2), S0(:,2)); % P peak
    %%%
    S5 = [N5(:,2), P5(:,2)];
    diff5 = A-S5;
    [com_EEG_A50{el+1,5},com_EEG_A50{el+1,6},com_EEG_A50{el+1,7},com_EEG_A50{el+1,8},com_EEG_A50{el+1,9}] = mult_comp_perm_t1(diff5);
    
    [com_EEG_A50{el+5,5}(1), com_EEG_A50{el+5,6}(1)] = ttest(A(:,1), S5(:,1)); % N peak
    [com_EEG_A50{el+5,5}(2), com_EEG_A50{el+5,6}(2)] = ttest(A(:,2), S5(:,2)); % P peak
    %%%
    S2 = [N2(:,2), P2(:,2)];
    diff2 = A-S2;
    [com_EEG_A200{el+1,5},com_EEG_A200{el+1,6},com_EEG_A200{el+1,7},com_EEG_A200{el+1,8},com_EEG_A200{el+1,9}] = mult_comp_perm_t1(diff2);
    
    [com_EEG_A200{el+5,5}(1), com_EEG_A200{el+5,6}(1)] = ttest(A(:,1), S2(:,1)); % N peak
    [com_EEG_A200{el+5,5}(2), com_EEG_A200{el+5,6}(2)] = ttest(A(:,2), S2(:,2)); % P peak
    %%%
    S6 = [N6(:,2), P6(:,2)];
    diff6 = A-S6;
    [com_EEG_A600{el+1,5},com_EEG_A600{el+1,6},com_EEG_A600{el+1,7},com_EEG_A600{el+1,8},com_EEG_A600{el+1,9}] = mult_comp_perm_t1(diff6);
    
    [com_EEG_A600{el+5,5}(1), com_EEG_A600{el+5,6}(1)] = ttest(A(:,1), S6(:,1)); % N peak
    [com_EEG_A600{el+5,5}(2), com_EEG_A600{el+5,6}(2)] = ttest(A(:,2), S6(:,2)); % P peak
    
    % SOAs untereinander
    % Kruskal-Wallis
    grp = [0,5,2,6];
    [com_EEG_SOA{el+12,2:4}] = kruskalwallis([N0(:,2),N5(:,2),N2(:,2),N6(:,2)],grp,'off');
    [com_EEG_SOA{el+16,2:4}] = kruskalwallis([P0(:,2),P5(:,2),P2(:,2),P6(:,2)],grp,'off');

    disp(['Anova mean N peak_' num2str(el)])
    Xn(:,1) = [N0(:,2);N5(:,2);N2(:,2);N6(:,2)];
    Xn(:,2) = [ones(Nsub,1);ones(Nsub,1)*2;ones(Nsub,1)*3;ones(Nsub,1)*4];
    Xn(:,3) = [1:Nsub,1:Nsub,1:Nsub,1:Nsub]';
    RMAOV1(Xn)

    disp(['Anova mean P peak_' num2str(el)])
    Xp(:,1) = [P0(:,2);P5(:,2);P2(:,2);P6(:,2)];
    Xp(:,2) = [ones(Nsub,1);ones(Nsub,1)*2;ones(Nsub,1)*3;ones(Nsub,1)*4];
    Xp(:,3) = [1:Nsub,1:Nsub,1:Nsub,1:Nsub]';
    RMAOV1(Xp)

    % permutation + t-test for all SOAs
    diff05 = S0 - S5;
    [com_EEG_SOA{el+1,8},com_EEG_SOA{el+1,9},com_EEG_SOA{el+1,10},com_EEG_SOA{el+1,11},com_EEG_SOA{el+1,12}] = mult_comp_perm_t1(diff05);
    [com_EEG_SOA{el+5,8},com_EEG_SOA{el+5,9}] = ttest(S0,S5);

    diff02 = S0 - S2;
    [com_EEG_SOA{el+1,15},com_EEG_SOA{el+1,16},com_EEG_SOA{el+1,17},com_EEG_SOA{el+1,18},com_EEG_SOA{el+1,19}] = mult_comp_perm_t1(diff02);
    [com_EEG_SOA{el+5,15},com_EEG_SOA{el+5,16}] = ttest(S0,S2);

    diff06 = S0 - S6;
    [com_EEG_SOA{el+1,22},com_EEG_SOA{el+1,23},com_EEG_SOA{el+1,24},com_EEG_SOA{el+1,25},com_EEG_SOA{el+1,26}] = mult_comp_perm_t1(diff06);
    [com_EEG_SOA{el+5,22},com_EEG_SOA{el+5,23}] = ttest(S0,S6);

    diff52 = S5 - S2;
    [com_EEG_SOA{el+1,29},com_EEG_SOA{el+1,30},com_EEG_SOA{el+1,31},com_EEG_SOA{el+1,32},com_EEG_SOA{el+1,33}] = mult_comp_perm_t1(diff52);
    [com_EEG_SOA{el+5,29},com_EEG_SOA{el+5,30}] = ttest(S5, S2);

    diff56 = S5 - S6;
    [com_EEG_SOA{el+1,36},com_EEG_SOA{el+1,37},com_EEG_SOA{el+1,38},com_EEG_SOA{el+1,39},com_EEG_SOA{el+1,40}] = mult_comp_perm_t1(diff56);
    [com_EEG_SOA{el+5,36},com_EEG_SOA{el+5,37}] = ttest(S5, S6);

    diff26 = S2 - S6;
    [com_EEG_SOA{el+1,43},com_EEG_SOA{el+1,44},com_EEG_SOA{el+1,45},com_EEG_SOA{el+1,46},com_EEG_SOA{el+1,47}] = mult_comp_perm_t1(diff26);
    [com_EEG_SOA{el+5,43},com_EEG_SOA{el+5,44}] = ttest(S2,S6);


    %%%% permutation + t-test for individual peak
    A = [NA(:,1), PA(:,1)];
    S0 = [N0(:,1), P0(:,1)];
    diff0 = A-S0;
    [com_EEG_A0{el+1,11},com_EEG_A0{el+1,12},com_EEG_A0{el+1,13},com_EEG_A0{el+1,14},com_EEG_A0{el+1,15}] = mult_comp_perm_t1(diff0);
    
    [com_EEG_A0{el+5,11}(1), com_EEG_A0{el+5,12}(1),~, com_EEG_A0{el+5,13}{1}] = ttest(A(:,1), S0(:,1)); % N peak
    [com_EEG_A0{el+5,11}(2), com_EEG_A0{el+5,12}(2),~, com_EEG_A0{el+5,13}{2}] = ttest(A(:,2), S0(:,2)); % P peak
    
    amu{1,el} = mean(A,1);
    amu{2,el} = std(A,1)/sqrt(Nsub);
    smu{1,el} = mean(S0,1);
    smu{2,el} = std(S0,1)/sqrt(Nsub);
    %
    S5 = [N5(:,1), P5(:,1)];
    diff5 = A-S5;
    [com_EEG_A50{el+1,11},com_EEG_A50{el+1,12},com_EEG_A50{el+1,13},com_EEG_A50{el+1,14},com_EEG_A50{el+1,15}] = mult_comp_perm_t1(diff5);
    
    [com_EEG_A50{el+5,11}(1), com_EEG_A50{el+5,12}(1)] = ttest(A(:,1), S5(:,1)); % N peak
    [com_EEG_A50{el+5,11}(2), com_EEG_A50{el+5,12}(2)] = ttest(A(:,2), S5(:,2)); % P peak
    smu{3,el} = mean(S5,1);
    smu{4,el} = std(S5,1)/sqrt(Nsub);
    %
    S2 = [N2(:,1), P2(:,1)];
    diff2 = A-S2;
    [com_EEG_A200{el+1,11},com_EEG_A200{el+1,12},com_EEG_A200{el+1,13},com_EEG_A200{el+1,14},com_EEG_A200{el+1,15}] = mult_comp_perm_t1(diff2);
    
    [com_EEG_A200{el+5,11}(1), com_EEG_A200{el+5,12}(1)] = ttest(A(:,1), S2(:,1)); % N peak
    [com_EEG_A200{el+5,11}(2), com_EEG_A200{el+5,12}(2)] = ttest(A(:,2), S2(:,2)); % P peak
    smu{5,el} = mean(S2,1);
    smu{6,el} = std(S2,1)/sqrt(Nsub);
    %
    S6 = [N6(:,1), P6(:,1)];
    diff6 = A-S6;
    [com_EEG_A600{el+1,11},com_EEG_A600{el+1,12},com_EEG_A600{el+1,13},com_EEG_A600{el+1,14},com_EEG_A600{el+1,15}] = mult_comp_perm_t1(diff6);
    
    [com_EEG_A600{el+5,11}(1), com_EEG_A600{el+5,12}(1)] = ttest(A(:,1), S6(:,1)); % N peak
    [com_EEG_A600{el+5,11}(2), com_EEG_A600{el+5,12}(2)] = ttest(A(:,2), S6(:,2)); % P peak
    smu{7,el} = mean(S6,1);
    smu{8,el} = std(S6,1)/sqrt(Nsub);

    % SOAs untereinander
    % Kruskal-Wallis
    grp = [0,5,2,6];
    [com_EEG_SOA{28+el,2:4}] = kruskalwallis([N0(:,1),N5(:,1),N2(:,1),N6(:,1)],grp,'off');
    [com_EEG_SOA{32+el,2:4}] = kruskalwallis([P0(:,1),P5(:,1),P2(:,1),P6(:,1)],grp,'off');

    disp(['Anova ind N peak_' num2str(el)])
    Xn(:,1) = [N0(:,1);N5(:,1);N2(:,1);N6(:,1)];
    Xn(:,2) = [ones(Nsub,1);ones(Nsub,1)*2;ones(Nsub,1)*3;ones(Nsub,1)*4];
    Xn(:,3) = [1:Nsub,1:Nsub,1:Nsub,1:Nsub]';
    RMAOV1(Xn)

    disp(['Anova ind P peak_' num2str(el)])
    Xp(:,1) = [P0(:,1);P5(:,1);P2(:,1);P6(:,1)];
    Xp(:,2) = [ones(Nsub,1);ones(Nsub,1)*2;ones(Nsub,1)*3;ones(Nsub,1)*4];
    Xp(:,3) = [1:Nsub,1:Nsub,1:Nsub,1:Nsub]';
    RMAOV1(Xp)

    % permutation + t-test for all SOAs
    diff05 = S0 - S5;
    [com_EEG_SOA{el+9,8},com_EEG_SOA{el+9,9},com_EEG_SOA{el+9,10},com_EEG_SOA{el+9,11},com_EEG_SOA{el+9,12}] = mult_comp_perm_t1(diff05);
    [com_EEG_SOA{el+13,8},com_EEG_SOA{el+13,9}] = ttest(S0,S5);

    diff02 = S0 - S2;
    [com_EEG_SOA{el+9,15},com_EEG_SOA{el+9,16},com_EEG_SOA{el+9,17},com_EEG_SOA{el+9,18},com_EEG_SOA{el+9,19}] = mult_comp_perm_t1(diff02);
    [com_EEG_SOA{el+13,15},com_EEG_SOA{el+13,16}] = ttest(S0,S2);

    diff06 = S0 - S6;
    [com_EEG_SOA{el+9,22},com_EEG_SOA{el+9,23},com_EEG_SOA{el+9,24},com_EEG_SOA{el+9,25},com_EEG_SOA{el+9,26}] = mult_comp_perm_t1(diff06);
    [com_EEG_SOA{el+13,22},com_EEG_SOA{el+13,23}] = ttest(S0,S6);

    diff52 = S5 - S2;
    [com_EEG_SOA{el+9,29},com_EEG_SOA{el+9,30},com_EEG_SOA{el+9,31},com_EEG_SOA{el+9,32},com_EEG_SOA{el+9,33}] = mult_comp_perm_t1(diff52);
    [com_EEG_SOA{el+13,29},com_EEG_SOA{el+13,30}] = ttest(S5, S2);

    diff56 = S5 - S6;
    [com_EEG_SOA{el+9,36},com_EEG_SOA{el+9,37},com_EEG_SOA{el+9,38},com_EEG_SOA{el+9,39},com_EEG_SOA{el+9,40}] = mult_comp_perm_t1(diff56);
    [com_EEG_SOA{el+13,36},com_EEG_SOA{el+13,37}] = ttest(S5, S6);

    diff26 = S2 - S6;
    [com_EEG_SOA{el+9,43},com_EEG_SOA{el+9,44},com_EEG_SOA{el+9,45},com_EEG_SOA{el+9,46},com_EEG_SOA{el+9,47}] = mult_comp_perm_t1(diff26);
    [com_EEG_SOA{el+13,43},com_EEG_SOA{el+13,44}] = ttest(S2,S6);

    % linear regression to find linear connection
    x = [];
    y = [];
    yn = [];
    for sb = 1:Nsub
        y = vertcat(y,[S0(sb,2);S5(sb,2);S2(sb,2);S6(sb,2)]);
        yn = vertcat(yn,[S0(sb,1);S5(sb,1);S2(sb,1);S6(sb,1)]);
        x = vertcat(x,[[1:4]',ones(4,1)]);
    end
    [~,~,~,~,stats] = regress(y,x)
    [com_EEG_SOA{el+44,2:5}] = deal(stats(1),stats(2),stats(3),stats(4));
    [~,~,~,~,stats] = regress(yn,x) % N1
    [com_EEG_SOA{el+48,2:5}] = deal(stats(1),stats(2),stats(3),stats(4));
end
[com_EEG_SOA{44,1:5}] = deal('linear Reg P2', 'R²', 'F','p','error var');
[com_EEG_SOA{48,1:5}] = deal('linear Reg N1', 'R²', 'F','p','error var');

[com_EEG_SOA{21,2:4}] = deal([3,48], 1.699, 0.1797); % mean N FCz
[com_EEG_SOA{25,2:4}] = deal([3,48], 5.102, 0.0038); % mean P FCz
[com_EEG_SOA{37,2:4}] = deal([3,48], 1.519, 0.2216); % ind N FCz
[com_EEG_SOA{41,2:4}] = deal([3,48], 5.290, 0.0031); % ind P FCz

[com_EEG_SOA{22,2:4}] = deal([3,48], 2.441, 0.0756); % mean N Fz
[com_EEG_SOA{26,2:4}] = deal([3,48], 1.759, 0.1677); % mean P Fz
[com_EEG_SOA{38,2:4}] = deal([3,48], 3.033, 0.0382); % ind N Fz
[com_EEG_SOA{42,2:4}] = deal([3,48], 2.019, 0.1237); % ind P Fz

[com_EEG_SOA{23,2:4}] = deal([3,48], 3.029, 0.0383); % mean N Cz
[com_EEG_SOA{27,2:4}] = deal([3,48], 10.515, 0.0000); % mean P Cz
[com_EEG_SOA{39,2:4}] = deal([3,48], 1.854, 0.1500); % ind N Cz
[com_EEG_SOA{43,2:4}] = deal([3,48], 10.860, 0.0000); % ind P Cz

% save com_EEG_SOA.mat com_EEG_SOA


%%% ---------------------- 2.2.3 figures ------------------------------ %%%
% 1 figure for each electrode
% pro figure 4 subplots for each SOA (incl. A)
% SEM als Schatten

% shaded area where permutation test was significant (<0.05)
%   (- significant when >=3 neighbouring time points significant) nicht
%   mehr so geregelt
ca = [255/255, 50/255, 50/255];
cs = [21/255, 45/255, 255/255];
sig = [180/255, 180/255, 180/255];

for el = 1:3 % 3 plots for 3 electrodes
%     figure('Position', [150, 100, 1200, 600])
%     subplot(2,2,1) %A0
    figure()
    hold on
    plot([0 0], [-15 15], 'Color', [153/255, 153/255, 153/255], 'LineWidth', 1) % yNull-Linie
    plot([-200 400], [0 0], 'Color', [153/255, 153/255, 153/255], 'LineWidth', 1) % xNull-Linie

    % significant timepoints N1
    if com_EEG_A0{el+5,12}(1) <= 0.05
        fill([peaks{11,3}-20,peaks{11,3}+20,peaks{11,3}+20,peaks{11,3}-20],[-15,-15,15,15],sig,'FaceAlpha',0.3,'EdgeColor','none');
    end

    % significant timepoints P2
    if com_EEG_A0{el+5,12}(2) <= 0.05
        fill([peaks{12,3}-20,peaks{12,3}+20,peaks{12,3}+20,peaks{12,3}-20],[-15,-15,15,15],sig,'FaceAlpha',0.3,'EdgeColor','none');
    end
    
    fill([EEG_data{el+6,7}(1:end),EEG_data{el+6,7}(end:-1:1)],[[com_EEG_A0{el+4,2}]-[com_EEG_A0{el+7,2}],flip([com_EEG_A0{el+4,2}]+[com_EEG_A0{el+7,2}])],ca,'FaceAlpha',0.3,'EdgeColor','none')
    p1=plot([EEG_data{el+6,7}], [com_EEG_A0{el+4,2}], 'Color', [255/255, 50/255, 50/255], 'LineWidth', 1); % mean A
    fill([EEG_data{el+6,7}(1:end),EEG_data{el+6,7}(end:-1:1)],[[com_EEG_A0{el+4,3}]-[com_EEG_A0{el+7,3}],flip([com_EEG_A0{el+4,3}]+[com_EEG_A0{el+7,3}])],cs,'FaceAlpha',0.3,'EdgeColor','none')
    p2=plot([EEG_data{el+6,7}], [com_EEG_A0{el+4,3}], 'Color', [21/255, 45/255, 255/255], 'LineWidth', 1);
       
    xlim([-200, 400])
    ylim([-15, 15])
    title([EEG_data{el+6,1}(1:end-4) ' ' '| SOA 0'])
    ylabel('mean amplitude [µV]')
    legend([p1,p2],{'Auditory-Only','Motor-Auditory'}, 'Location', 'northwest')
    xlabel('time relative to tone onset [ms]')
    cd('../Figures')
    saveas(gcf, ['ERP_A_0_' EEG_data{el+6,1}(1:end-5) '.png'])

%     subplot(2,2,2) %A50
%     hold on
%     % significant timepoints N1
%     if com_EEG_A50{el+5,12}(1) <= 0.05
%         fill([peaks{11,3}-20,peaks{11,3}+20,peaks{11,3}+20,peaks{11,3}-20],[-15,-15,15,15],sig,'FaceAlpha',0.3,'EdgeColor','none');
%     end
% 
%     % significant timepoints P2
%     if com_EEG_A50{el+5,12}(2) <= 0.05
%         fill([peaks{12,3}-20,peaks{12,3}+20,peaks{12,3}+20,peaks{12,3}-20],[-15,-15,15,15],sig,'FaceAlpha',0.3,'EdgeColor','none');
%     end
% 
%     plot([0 0], [-15 15], 'Color', [153/255, 153/255, 153/255], 'LineWidth', 1) % yNull-Linie
%     plot([-200 400], [0 0], 'Color', [153/255, 153/255, 153/255], 'LineWidth', 1) % xNull-Linie
%     fill([EEG_data{el+6,7}(1:end),EEG_data{el+6,7}(end:-1:1)],[[com_EEG_A50{el+4,2}]-[com_EEG_A50{el+7,2}],flip([com_EEG_A50{el+4,2}]+[com_EEG_A50{el+7,2}])],ca,'FaceAlpha',0.3,'EdgeColor','none')
%     plot([EEG_data{el+6,7}], [com_EEG_A50{el+4,2}], 'Color', [255/255, 50/255, 50/255], 'LineWidth', 1);
%     fill([EEG_data{el+6,7}(1:end),EEG_data{el+6,7}(end:-1:1)],[[com_EEG_A50{el+4,3}]-[com_EEG_A50{el+7,3}],flip([com_EEG_A50{el+4,3}]+[com_EEG_A50{el+7,3}])],cs,'FaceAlpha',0.3,'EdgeColor','none')
%     plot([EEG_data{el+6,7}], [com_EEG_A50{el+4,3}], 'Color', [21/255, 45/255, 255/255], 'LineWidth', 1);
%     
%     xlim([-200, 400])
%     ylim([-15, 15])
%     title([EEG_data{el+6,1}(1:end-4) ' ' '| SOA 50'])
% 
%     subplot(2,2,3)
%     hold on
% 
%     % significant timepoints N1
%     if com_EEG_A200{el+5,12}(1) <= 0.05
%         fill([peaks{11,3}-20,peaks{11,3}+20,peaks{11,3}+20,peaks{11,3}-20],[-15,-15,15,15],sig,'FaceAlpha',0.3,'EdgeColor','none');
%     end
% 
%     % significant timepoints P2
%     if com_EEG_A200{el+5,12}(2) <= 0.05
%         fill([peaks{12,3}-20,peaks{12,3}+20,peaks{12,3}+20,peaks{12,3}-20],[-15,-15,15,15],sig,'FaceAlpha',0.3,'EdgeColor','none');
%     end
% 
%     plot([0 0], [-15 15], 'Color', [153/255, 153/255, 153/255], 'LineWidth', 1) % yNull-Linie
%     plot([-200 400], [0 0], 'Color', [153/255, 153/255, 153/255], 'LineWidth', 1) % xNull-Linie
%     
%     fill([EEG_data{el+6,7}(1:end),EEG_data{el+6,7}(end:-1:1)],[[com_EEG_A200{el+4,2}]-[com_EEG_A200{el+7,2}],flip([com_EEG_A200{el+4,2}]+[com_EEG_A200{el+7,2}])],ca,'FaceAlpha',0.3,'EdgeColor','none')
%     plot([EEG_data{el+6,7}], [com_EEG_A200{el+4,2}], 'Color', [255/255, 50/255, 50/255], 'LineWidth', 1);
%     fill([EEG_data{el+6,7}(1:end),EEG_data{el+6,7}(end:-1:1)],[[com_EEG_A200{el+4,3}]-[com_EEG_A200{el+7,3}],flip([com_EEG_A200{el+4,3}]+[com_EEG_A200{el+7,3}])],cs,'FaceAlpha',0.3,'EdgeColor','none')
%     plot([EEG_data{el+6,7}], [com_EEG_A200{el+4,3}], 'Color', [21/255, 45/255, 255/255], 'LineWidth', 1);
%     
%     xlim([-200, 400])
%     ylim([-15, 15])
%     title([EEG_data{el+6,1}(1:end-4) ' ' '| SOA 200'])
%     ylabel('mean amplitude [µV]')
%     xlabel('time relative to tone onset [ms]')
% 
%     subplot(2,2,4)
%     hold on
% % significant timepoints N1
%     if com_EEG_A600{el+5,12}(1) <= 0.05
%         fill([peaks{11,3}-20,peaks{11,3}+20,peaks{11,3}+20,peaks{11,3}-20],[-15,-15,15,15],sig,'FaceAlpha',0.3,'EdgeColor','none');
%     end
% 
%     % significant timepoints P2
%     if com_EEG_A600{el+5,12}(2) <= 0.05
%         fill([peaks{12,3}-20,peaks{12,3}+20,peaks{12,3}+20,peaks{12,3}-20],[-15,-15,15,15],sig,'FaceAlpha',0.3,'EdgeColor','none');
%     end
% 
%     plot([0 0], [-15 15], 'Color', [153/255, 153/255, 153/255], 'LineWidth', 1) % yNull-Linie
%     plot([-200 400], [0 0], 'Color', [153/255, 153/255, 153/255], 'LineWidth', 1) % xNull-Linie
%     
%     fill([EEG_data{el+6,7}(1:end),EEG_data{el+6,7}(end:-1:1)],[[com_EEG_A600{el+4,2}]-[com_EEG_A600{el+7,2}],flip([com_EEG_A600{el+4,2}]+[com_EEG_A600{el+7,2}])],ca,'FaceAlpha',0.3,'EdgeColor','none')
%     plot([EEG_data{el+6,7}], [com_EEG_A600{el+4,2}], 'Color', [255/255, 50/255, 50/255], 'LineWidth', 1);
%     
%     fill([EEG_data{el+6,7}(1:end),EEG_data{el+6,7}(end:-1:1)],[[com_EEG_A600{el+4,3}]-[com_EEG_A600{el+7,3}],flip([com_EEG_A600{el+4,3}]+[com_EEG_A600{el+7,3}])],cs,'FaceAlpha',0.3,'EdgeColor','none')
%     plot([EEG_data{el+6,7}], [com_EEG_A600{el+4,3}], 'Color', [21/255, 45/255, 255/255], 'LineWidth', 1);
%     
%     xlim([-200, 400])
%     ylim([-15, 15])
%     title([EEG_data{el+6,1}(1:end-4) ' ' '| SOA 600'])
%     xlabel('time relative to tone onset [ms]')
%     
%     cd('../Figures')
%     saveas(gcf, ['ERP_A_MA_' EEG_data{el+6,1}(1:end-5) '.png'])
end
cd('../EEG')


%%%%% SOAs untereinander
%%% ---------------- figure (1 for each elektrode) -------------------- %%%
% - SEM as shaded area around
% - boxes for significant 
combi_ind = [2,3,7;2,4,14;2,5,21;3,4,28;3,5,35;4,5,42];
sigcol = [204/255,0/255,0/255;204/255,204/255,0/255;0/255,204/255,0/255; 0/255,204/255,204/255;0/255,0/255,204/255;204/255,0/255,204/255];
elidx = [21,5,14];
cd('../Figures')
for el = 1:3
    figure()
    hold on
    % Signifkanzen, ANOVA
    %for c = 1:size(combi_ind,1)
    % N1
    if com_EEG_SOA{el+36,4} <= 0.05
        fill([peaks{11,3}-20,peaks{11,3}+20,peaks{11,3}+20,peaks{11,3}-20],[-15,-15,15,15],sig, 'FaceAlpha',0.3,'EdgeColor','none')
    end
    % P2
    if com_EEG_SOA{el+40,4} <= 0.05
        fill([peaks{12,3}-20,peaks{12,3}+20,peaks{12,3}+20,peaks{12,3}-20],[-15,-15,15,15],sig, 'FaceAlpha',0.3,'EdgeColor','none')
    end
    %end

    plot([0 0], [-15 15], 'Color', [153/255, 153/255, 153/255], 'LineWidth', 1) % yNull-Linie
    plot([-200 400], [0 0], 'Color', [153/255, 153/255, 153/255], 'LineWidth', 1) % xNull-Linie
    
    p1=plot([EEG_data{el+6,7}], [com_EEG_SOA{el+4,2}],'g'); % SOA 0
    fill([[EEG_data{el+6,7}(1:end)],[EEG_data{el+6,7}(end:-1:1)]],[[com_EEG_SOA{el+4,2}]-[com_EEG_SOA{el+7,2}],flip([com_EEG_SOA{el+4,2}]+[com_EEG_SOA{el+7,2}])],'g','EdgeColor','none','FaceAlpha',0.3)

    p2=plot([EEG_data{el+6,7}], [com_EEG_SOA{el+4,3}],'b'); % SOA 50
    fill([[EEG_data{el+6,7}(1:end)],[EEG_data{el+6,7}(end:-1:1)]],[[com_EEG_SOA{el+4,3}]-[com_EEG_SOA{el+7,3}],flip([com_EEG_SOA{el+4,3}]+[com_EEG_SOA{el+7,3}])],'b','EdgeColor','none','FaceAlpha',0.3)

    p3=plot([EEG_data{el+6,7}], [com_EEG_SOA{el+4,4}],'m'); % SOA 200
    fill([[EEG_data{el+6,7}(1:end)],[EEG_data{el+6,7}(end:-1:1)]],[[com_EEG_SOA{el+4,4}]-[com_EEG_SOA{el+7,4}],flip([com_EEG_SOA{el+4,4}]+[com_EEG_SOA{el+7,4}])],'m','EdgeColor','none','FaceAlpha',0.3)
    
    p4=plot([EEG_data{el+6,7}], [com_EEG_SOA{el+4,5}],'r'); % SOA 600
    fill([[EEG_data{el+6,7}(1:end)],[EEG_data{el+6,7}(end:-1:1)]],[[com_EEG_SOA{el+4,5}]-[com_EEG_SOA{el+7,5}],flip([com_EEG_SOA{el+4,5}]+[com_EEG_SOA{el+7,5}])],'r','EdgeColor','none','FaceAlpha',0.3)

    xlim([-200, 400])
    ylim([-15, 15])
    title([EEG_data{el+6,1}(1:end-4)])
    ylabel('mean amplitude [µV]')
    xlabel('time relative to tone onset [ms]')
    legend([p1,p2,p3,p4],{'SOA 0','SOA 50','SOA 200','SOA 600'},'Location','northwest')
    
    saveas(gcf,['ERP_SOAs_' EEG_data{el+6,1}(1:end-5) '.png'])

    % Vergleich für jede Person einzeln --> wegen auffälliger N1 Latenz bei
    % SOA 0
    for sb = 1:Nsub
        figure()
        hold on
        plot([0 0], [-15 15], 'Color', [153/255, 153/255, 153/255], 'LineWidth', 1) % yNull-Linie
        plot([-200 400], [0 0], 'Color', [153/255, 153/255, 153/255], 'LineWidth', 1) % xNull-Linie
    
        %fill([EEG_data{7,7},EEG_data{7,7}(end:-1:1)], [EEG_data{el+6,10}(sb,:)-EEG_data{el+6,16}{sb,1}(1).s(elidx(el),:),flip(EEG_data{el+6,10}(sb,:)+EEG_data{el+6,16}{sb,1}(1).s(elidx(el),:))],'g','EdgeColor','none','FaceAlpha',0.3) % SOA 0 SD
        p1 = plot(EEG_data{7,7}, EEG_data{el+6,10}(sb,:),'g');
        %fill([EEG_data{7,7},EEG_data{7,7}(end:-1:1)], [EEG_data{el+6,11}(sb,:)-EEG_data{el+6,16}{sb,1}(2).s(elidx(el),:),flip(EEG_data{el+6,11}(sb,:)+EEG_data{el+6,16}{sb,1}(2).s(elidx(el),:))],'b','EdgeColor','none','FaceAlpha',0.3) % SOA 50 SD
        p2 = plot(EEG_data{7,7}, EEG_data{el+6,11}(sb,:),'b');
        %fill([EEG_data{7,7},EEG_data{7,7}(end:-1:1)], [EEG_data{el+6,12}(sb,:)-EEG_data{el+6,16}{sb,1}(3).s(elidx(el),:),flip(EEG_data{el+6,12}(sb,:)+EEG_data{el+6,16}{sb,1}(3).s(elidx(el),:))],'m','EdgeColor','none','FaceAlpha',0.3) % SOA 200 SD
        p3 = plot(EEG_data{7,7}, EEG_data{el+6,12}(sb,:),'m');
        %fill([EEG_data{7,7},EEG_data{7,7}(end:-1:1)], [EEG_data{el+6,13}(sb,:)-EEG_data{el+6,16}{sb,1}(4).s(elidx(el),:),flip(EEG_data{el+6,13}(sb,:)+EEG_data{el+6,16}{sb,1}(4).s(elidx(el),:))],'r','EdgeColor','none','FaceAlpha',0.3) % SOA 0 SD
        p4 = plot(EEG_data{7,7}, EEG_data{el+6,13}(sb,:),'r');
        
        xlim([-200, 400])
        ylim([-15, 15])
        title([EEG_data{el+6,1}(1:end-4) '| ' subjects{1,sb+1}])
        ylabel('mean amplitude [µV]')
        xlabel('time relative to tone onset [ms]')
        legend([p1,p2,p3,p4],{'SOA 0','SOA 50','SOA 200','SOA 600'},'Location','northwest')
    
        saveas(gcf,['ERP_SOAs_' EEG_data{el+6,1}(1:end-5) '_' subjects{1,sb+1} '.png'])

        figure()
        hold on
        plot([0 0], [-15 15], 'Color', [153/255, 153/255, 153/255], 'LineWidth', 1) % yNull-Linie
        plot([-200 400], [0 0], 'Color', [153/255, 153/255, 153/255], 'LineWidth', 1) % xNull-Linie
    
        %fill([EEG_data{7,7},EEG_data{7,7}(end:-1:1)], [EEG_data{el+6,2}(sb,:)-EEG_data{el+6,9}{sb,1}.np(elidx(el),:), flip(EEG_data{el+6,2}(sb,:)+EEG_data{el+6,9}{sb,1}.np(elidx(el),:))], 'k', 'EdgeColor', 'none', 'FaceAlpha', 0.3) % Auditory only
        p0 = plot(EEG_data{7,7}, EEG_data{el+6,2}(sb,:), 'k');
        %fill([EEG_data{7,7},EEG_data{7,7}(end:-1:1)], [EEG_data{el+6,10}(sb,:)-EEG_data{el+6,16}{sb,1}(1).s(elidx(el),:),flip(EEG_data{el+6,10}(sb,:)+EEG_data{el+6,16}{sb,1}(1).s(elidx(el),:))],'g','EdgeColor','none','FaceAlpha',0.3) % SOA 0 SD
        p1 = plot(EEG_data{7,7}, EEG_data{el+6,10}(sb,:),'g');
        %fill([EEG_data{7,7},EEG_data{7,7}(end:-1:1)], [EEG_data{el+6,11}(sb,:)-EEG_data{el+6,16}{sb,1}(2).s(elidx(el),:),flip(EEG_data{el+6,11}(sb,:)+EEG_data{el+6,16}{sb,1}(2).s(elidx(el),:))],'b','EdgeColor','none','FaceAlpha',0.3) % SOA 50 SD
        p2 = plot(EEG_data{7,7}, EEG_data{el+6,11}(sb,:),'b');
        %fill([EEG_data{7,7},EEG_data{7,7}(end:-1:1)], [EEG_data{el+6,12}(sb,:)-EEG_data{el+6,16}{sb,1}(3).s(elidx(el),:),flip(EEG_data{el+6,12}(sb,:)+EEG_data{el+6,16}{sb,1}(3).s(elidx(el),:))],'m','EdgeColor','none','FaceAlpha',0.3) % SOA 200 SD
        p3 = plot(EEG_data{7,7}, EEG_data{el+6,12}(sb,:),'m');
        %fill([EEG_data{7,7},EEG_data{7,7}(end:-1:1)], [EEG_data{el+6,13}(sb,:)-EEG_data{el+6,16}{sb,1}(4).s(elidx(el),:),flip(EEG_data{el+6,13}(sb,:)+EEG_data{el+6,16}{sb,1}(4).s(elidx(el),:))],'r','EdgeColor','none','FaceAlpha',0.3) % SOA 0 SD
        p4 = plot(EEG_data{7,7}, EEG_data{el+6,13}(sb,:),'r');
        
        xlim([-200, 400])
        ylim([-15, 15])
        title([EEG_data{el+6,1}(1:end-4) '| ' subjects{1,sb+1}])
        ylabel('mean amplitude [µV]')
        xlabel('time relative to tone onset [ms]')
        legend([p0, p1,p2,p3,p4],{'Auditory-only','SOA 0','SOA 50','SOA 200','SOA 600'},'Location','northwest')
    
        saveas(gcf,['ERP_SOAsA_' EEG_data{el+6,1}(1:end-5) '_' subjects{1,sb+1} '.png'])
   
    end
end
cd('../EEG')
% M1
% [com_EEG_A0{12:14,1}] = deal('M1', 'µ', 'SE');
% [com_EEG_A50{12:14,1}] = deal('M1', 'µ', 'SE');
% [com_EEG_A200{12:14,1}] = deal('M1', 'µ', 'SE');
% [com_EEG_A600{12:14,1}] = deal('M1', 'µ', 'SE');
% % korrigierte Daten
% [com_EEG_A0{12,2:3}] = deal(EEG_data{10,2} - m1_data{4,2}, EEG_data{10,10}-m1_data{4,2}); % Korrektur A vs. 0
% [com_EEG_A50{12,2:3}] = deal(EEG_data{10,2} - m1_data{4,3}, EEG_data{10,11}-m1_data{4,3}); % Korrektur A vs. 50
% [com_EEG_A200{12,2:3}] = deal(EEG_data{10,2} - m1_data{4,4}, EEG_data{10,12}-m1_data{4,4}); % Korrektur A vs. 50
% [com_EEG_A600{12,2:3}] = deal(EEG_data{10,2} - m1_data{4,5}, EEG_data{10,13}-m1_data{4,5}); % Korrektur A vs. 50
% % Mean
% [com_EEG_A0{13,2:3}] = deal(mean(com_EEG_A0{12,2},1),mean(com_EEG_A0{12,3},1));
% [com_EEG_A0{14,2:3}] = deal(std(com_EEG_A0{12,2},1)/sqrt(Nsub),std(com_EEG_A0{12,3},1)/sqrt(Nsub));
% [com_EEG_A50{13,2:3}] = deal(mean(com_EEG_A50{12,2},1),mean(com_EEG_A50{12,3},1));
% [com_EEG_A50{14,2:3}] = deal(std(com_EEG_A50{12,2},1)/sqrt(Nsub),std(com_EEG_A50{12,3},1)/sqrt(Nsub));
% [com_EEG_A200{13,2:3}] = deal(mean(com_EEG_A200{12,2},1),mean(com_EEG_A200{12,3},1));
% [com_EEG_A200{14,2:3}] = deal(std(com_EEG_A200{12,2},1)/sqrt(Nsub),std(com_EEG_A200{12,3},1)/sqrt(Nsub));
% [com_EEG_A600{13,2:3}] = deal(mean(com_EEG_A600{12,2},1),mean(com_EEG_A600{12,3},1));
% [com_EEG_A600{14,2:3}] = deal(std(com_EEG_A600{12,2},1)/sqrt(Nsub),std(com_EEG_A600{12,3},1)/sqrt(Nsub));
% 
% % t-test
% [com_EEG_A0{12,5},com_EEG_A0{12,6}] = ttest([min(EEG_data{10,2}(:,peaks{13,6}(1):peaks{13,6}(2)),[],2),max(EEG_data{10,2}(:,peaks{14,6}(1):peaks{14,6}(2)),[],2)],...
%     [min(EEG_data{10,10}(:,peaks{13,6}(1):peaks{13,6}(2)),[],2),max(EEG_data{10,10}(:,peaks{14,6}(1):peaks{14,6}(2)),[],2)]);
% 
% [com_EEG_A50{12,5},com_EEG_A50{12,6}] = ttest([min(EEG_data{10,2}(:,peaks{13,6}(1):peaks{13,6}(2)),[],2),max(EEG_data{10,2}(:,peaks{14,6}(1):peaks{14,6}(2)),[],2)],...
%     [min(EEG_data{10,11}(:,peaks{13,6}(1):peaks{13,6}(2)),[],2),max(EEG_data{10,11}(:,peaks{14,6}(1):peaks{14,6}(2)),[],2)]);
% 
% [com_EEG_A200{12,5},com_EEG_A200{12,6}] = ttest([min(EEG_data{10,2}(:,peaks{13,6}(1):peaks{13,6}(2)),[],2),max(EEG_data{10,2}(:,peaks{14,6}(1):peaks{14,6}(2)),[],2)],...
%     [min(EEG_data{10,12}(:,peaks{13,6}(1):peaks{13,6}(2)),[],2),max(EEG_data{10,12}(:,peaks{14,6}(1):peaks{14,6}(2)),[],2)]);
% 
% [com_EEG_A600{12,5},com_EEG_A600{12,6}] = ttest([min(EEG_data{10,2}(:,peaks{13,6}(1):peaks{13,6}(2)),[],2),max(EEG_data{10,2}(:,peaks{14,6}(1):peaks{14,6}(2)),[],2)],...
%     [min(EEG_data{10,13}(:,peaks{13,6}(1):peaks{13,6}(2)),[],2),max(EEG_data{10,13}(:,peaks{14,6}(1):peaks{14,6}(2)),[],2)]);
% 
% % all SOAs
% [com_EEG_SOA{45,2:5}] = deal('SOA 0', 'SOA 50', 'SOA 200', 'SOA 600');
% [com_EEG_SOA{46,1:5}] = deal('M1 corr',EEG_data{10,10}-m1_data{4,6}, EEG_data{10,11}-m1_data{4,6},EEG_data{10,12}-m1_data{4,6},EEG_data{10,13}-m1_data{4,6});
% [com_EEG_SOA{47,1:5}] = deal('mean', mean(com_EEG_SOA{46,2},1),mean(com_EEG_SOA{46,3},1),mean(com_EEG_SOA{46,4},1),mean(com_EEG_SOA{46,5},1));
% [com_EEG_SOA{48,1:5}] = deal('SE', std(com_EEG_SOA{46,2},1)/sqrt(Nsub),std(com_EEG_SOA{46,3},1)/sqrt(Nsub),std(com_EEG_SOA{46,4},1)/sqrt(Nsub),std(com_EEG_SOA{46,5},1)/sqrt(Nsub));
% [com_EEG_SOA{49,1:4}] = deal('Anova','df','F','p');
% con=[1,14;15,28;29,42;43,56];
% for c = 1:4
%     XM1N(con(c,1):con(c,2),1) = min(EEG_data{10,c+9}(:,peaks{13,6}(1):peaks{13,6}(2)),[],2);
%     XM1N(con(c,1):con(c,2),2) = ones(Nsub,1)*c;
%     XM1N(con(c,1):con(c,2),3) = 1:Nsub;
%     XM1P(con(c,1):con(c,2),1) = max(EEG_data{10,c+9}(:,peaks{14,6}(1):peaks{14,6}(2)),[],2);
%     XM1P(con(c,1):con(c,2),2) = ones(Nsub,1)*c;
%     XM1P(con(c,1):con(c,2),3) = 1:Nsub;
% end
% RMAOV1(XM1N)
% [com_EEG_SOA{50,1:4}] = deal('N1',[3,39],0.75, 0.53);
% 
% RMAOV1(XM1P)
% [com_EEG_SOA{51,1:4}] = deal('P2',[3,39],1.811, 0.16);
% 
% % figures
% figure('Position', [150,100, 1200, 600]) % A vs SOA
% subplot(2,2,1) % A vs. 0
% hold on
% plot([0 0], [-15 15], 'Color', [153/255, 153/255, 153/255], 'LineWidth', 1) % yNull-Linie
% plot([-200 400], [0 0], 'Color', [153/255, 153/255, 153/255], 'LineWidth', 1) % xNull-Linie
% 
% fill([EEG_data{10,7},EEG_data{10,7}(end:-1:1)], [com_EEG_A0{13,2}-com_EEG_A0{14,2},flip(com_EEG_A0{13,2}+com_EEG_A0{14,2})], ca,'FaceAlpha',0.3,'EdgeColor','none')
% plot(EEG_data{10,7},com_EEG_A0{13,2},'Color',ca,'LineWidth', 1)
% fill([EEG_data{10,7},EEG_data{10,7}(end:-1:1)], [com_EEG_A0{13,3}-com_EEG_A0{14,3},flip(com_EEG_A0{13,3}+com_EEG_A0{14,3})], cs,'FaceAlpha',0.3,'EdgeColor','none')
% plot(EEG_data{10,7},com_EEG_A0{13,3},'Color',cs,'LineWidth', 1)
% xlim([-200 400])
% ylim([-15 15])
% ylabel('mean amplitude [µV]')
% title('M1 | SOA 0')
% 
% subplot(2,2,2) % A vs. 50
% hold on
% plot([0 0], [-15 15], 'Color', [153/255, 153/255, 153/255], 'LineWidth', 1) % yNull-Linie
% plot([-200 400], [0 0], 'Color', [153/255, 153/255, 153/255], 'LineWidth', 1) % xNull-Linie
% 
% fill([EEG_data{10,7},EEG_data{10,7}(end:-1:1)], [com_EEG_A50{13,2}-com_EEG_A50{14,2},flip(com_EEG_A50{13,2}+com_EEG_A50{14,2})], ca,'FaceAlpha',0.3,'EdgeColor','none')
% plot(EEG_data{10,7},com_EEG_A50{13,2},'Color',ca,'LineWidth', 1)
% fill([EEG_data{10,7},EEG_data{10,7}(end:-1:1)], [com_EEG_A50{13,3}-com_EEG_A50{14,3},flip(com_EEG_A50{13,3}+com_EEG_A50{14,3})], cs,'FaceAlpha',0.3,'EdgeColor','none')
% plot(EEG_data{10,7},com_EEG_A50{13,3},'Color',cs,'LineWidth', 1)
% xlim([-200 400])
% ylim([-15 15])
% ylabel('mean amplitude [µV]')
% title('M1 | SOA 50')
% 
% subplot(2,2,3) % A vs. 200
% hold on
% plot([0 0], [-15 15], 'Color', [153/255, 153/255, 153/255], 'LineWidth', 1) % yNull-Linie
% plot([-200 400], [0 0], 'Color', [153/255, 153/255, 153/255], 'LineWidth', 1) % xNull-Linie
% 
% fill([EEG_data{10,7},EEG_data{10,7}(end:-1:1)], [com_EEG_A200{13,2}-com_EEG_A200{14,2},flip(com_EEG_A200{13,2}+com_EEG_A200{14,2})], ca,'FaceAlpha',0.3,'EdgeColor','none')
% plot(EEG_data{10,7},com_EEG_A200{13,2},'Color',ca,'LineWidth', 1)
% fill([EEG_data{10,7},EEG_data{10,7}(end:-1:1)], [com_EEG_A200{13,3}-com_EEG_A200{14,3},flip(com_EEG_A200{13,3}+com_EEG_A200{14,3})], cs,'FaceAlpha',0.3,'EdgeColor','none')
% plot(EEG_data{10,7},com_EEG_A200{13,3},'Color',cs,'LineWidth', 1)
% xlim([-200 400])
% ylim([-15 15])
% ylabel('mean amplitude [µV]')
% xlabel('time relative to tone onset [ms]')
% title('M1 | SOA 200')
% 
% subplot(2,2,4) % A vs. 600
% hold on
% plot([0 0], [-15 15], 'Color', [153/255, 153/255, 153/255], 'LineWidth', 1) % yNull-Linie
% plot([-200 400], [0 0], 'Color', [153/255, 153/255, 153/255], 'LineWidth', 1) % xNull-Linie
% 
% fill([EEG_data{10,7},EEG_data{10,7}(end:-1:1)], [com_EEG_A600{13,2}-com_EEG_A600{14,2},flip(com_EEG_A600{13,2}+com_EEG_A600{14,2})], ca,'FaceAlpha',0.3,'EdgeColor','none')
% plot(EEG_data{10,7},com_EEG_A600{13,2},'Color',ca,'LineWidth', 1)
% fill([EEG_data{10,7},EEG_data{10,7}(end:-1:1)], [com_EEG_A600{13,3}-com_EEG_A600{14,3},flip(com_EEG_A600{13,3}+com_EEG_A600{14,3})], cs,'FaceAlpha',0.3,'EdgeColor','none')
% plot(EEG_data{10,7},com_EEG_A600{13,3},'Color',cs,'LineWidth', 1)
% xlim([-200 400])
% ylim([-15 15])
% ylabel('mean amplitude [µV]')
% xlabel('time relative to tone onset [ms]')
% title('M1 | SOA 600')
% cd('../Figures')
% saveas(gcf, 'ERP_A_MA_M1.png')
% 
% % all SOAs
% figure()
% hold on
% plot([0 0], [-15 15], 'Color', [153/255, 153/255, 153/255], 'LineWidth', 1) % yNull-Linie
% plot([-200 400], [0 0], 'Color', [153/255, 153/255, 153/255], 'LineWidth', 1) % xNull-Linie
% 
% fill([EEG_data{10,7},EEG_data{10,7}(end:-1:1)], [com_EEG_SOA{47,2}-com_EEG_SOA{48,2},flip(com_EEG_SOA{47,2}+com_EEG_SOA{48,2})], 'g','FaceAlpha',0.3,'EdgeColor','none')
% p1=plot(EEG_data{10,7},com_EEG_SOA{47,2},'Color','g','LineWidth', 1);
% fill([EEG_data{10,7},EEG_data{10,7}(end:-1:1)], [com_EEG_SOA{47,3}-com_EEG_SOA{48,3},flip(com_EEG_SOA{47,3}+com_EEG_SOA{48,3})], 'b','FaceAlpha',0.3,'EdgeColor','none')
% p2=plot(EEG_data{10,7},com_EEG_SOA{47,3},'Color','b','LineWidth', 1);
% fill([EEG_data{10,7},EEG_data{10,7}(end:-1:1)], [com_EEG_SOA{47,4}-com_EEG_SOA{48,4},flip(com_EEG_SOA{47,4}+com_EEG_SOA{48,4})], 'm','FaceAlpha',0.3,'EdgeColor','none')
% p3=plot(EEG_data{10,7},com_EEG_SOA{47,4},'Color','m','LineWidth', 1);
% fill([EEG_data{10,7},EEG_data{10,7}(end:-1:1)], [com_EEG_SOA{47,5}-com_EEG_SOA{48,5},flip(com_EEG_SOA{47,5}+com_EEG_SOA{48,5})], 'r','FaceAlpha',0.3,'EdgeColor','none')
% p4=plot(EEG_data{10,7},com_EEG_SOA{47,5},'Color','r','LineWidth', 1);
% 
% xlim([-200, 400])
% ylim([-15, 15])
% title('M1')
% ylabel('mean amplitude [µV]')
% xlabel('time relative to tone onset [ms]')
% legend([p1,p2,p3,p4],{'SOA 0','SOA 50','SOA 200','SOA 600'},'Location','northwest')
% 
% saveas(gcf,'ERP_SOAs_M1.png')
% cd('../EEG')

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ---------------- 2.4 ERP for different agency ratings ----------------- %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% - trials direkt vergleichen: wenn agency rating hoch war, gab es dann
% auch eine Veränderung
% von EEG Ordner aus programmiert
% agency:
% EEG.event: 1 = 0ms, 2 = 50ms, 3 = 200ms, 4 = 600ms


agency_EEG = agency_rating(1:3,:);
[agency_EEG{[4:8,14:21,23:30,32:39,41:48],1}] = deal('double agency','SOA0', 'SOA 50', 'SOA 200', 'SOA 600', 'EEG FCz', 'out1', 'out2', 'out3', 'out4', 'EEGtime', 'soa', 'con_info',...
    'EEG Fz', 'out1', 'out2', 'out3', 'out4', 'EEGtime', 'soa', 'con_info', 'EEG Cz', 'out1', 'out2', 'out3', 'out4', 'EEGtime', 'soa', 'con_info',...
    'EEG M1', 'out1', 'out2', 'out3', 'out4', 'EEGtime', 'soa', 'con_info');
agency_EEG{13,1} = 'trial index, soa';
channel = [21,5,14];
soas = [0, 0.05, 0.2, 0.6];

for sb = 1:Nsub
    agency_EEG{4,sb+1} = str2double([agency_EEG{2,sb+1}]);% cell into double numbers
    ind_f = find([agency_EEG{4,sb+1}]<0 | [agency_EEG{4,sb+1}]>7);
    agency_EEG{4,sb+1}(ind_f) = NaN;

    tr = [];
    for t = 1:length([subjects{2,sb+1}.trial])
        if subjects{2,sb+1}.trial(t).valid == 1
            tr = vertcat(tr, [subjects{2,sb+1}.trial(t).number, subjects{2,sb+1}.trial(t).pool]); % pool = SOA, for all trials index + SOA
        end
    end

    agency_EEG{13,sb+1} = tr;

    for ss = 1:4 % separate for SOA
        indices = find(agency_EEG{3,sb+1} == soas(ss));
        agency_EEG{ss+4,sb+1} = agency_EEG{4,sb+1}(indices);
    end
    

    ErrTr = ErrorTrials(subject{sb});
    [out1, out2, out3, out4, EEGtime, soa, con_info, st_lat]=AnalyzeEEG_agency(subject{sb},channel(1),ErrTr); % soa = means über alle trials pro condition
    [agency_EEG{15:22, sb+1}] = deal(out1, out2, out3, out4, EEGtime, soa, con_info,st_lat);
    [out1, out2, out3, out4, EEGtime, soa, con_info, st_lat]=AnalyzeEEG_agency(subject{sb},channel(2),ErrTr); % Fz
    [agency_EEG{24:31, sb+1}] = deal(out1, out2, out3, out4, EEGtime, soa, con_info,st_lat);
    [out1, out2, out3, out4, EEGtime, soa, con_info, st_lat]=AnalyzeEEG_agency(subject{sb},channel(3),ErrTr); % Cz
    [agency_EEG{33:40, sb+1}] = deal(out1, out2, out3, out4, EEGtime, soa, con_info,st_lat);
end

[agency_EEG{9:12,1}] = deal('SOA 0 corr', 'SOA 50 corr', 'SOA 200 corr', 'SOA 600 corr');
[agency_EEG(9:12,2:end)] = [agency_timecourse([6,17,28,39],2:end)];


% Test ob es die gleichen Trials sind
% [agency_EEG{[22,31,40],1}] = deal('start latency','start latency','start latency');
% agency_EEG{13,1} = 'trial nr/soa';
% [eeg_nr{1:4}] = deal([],[],[],[]);

so = [0,50,200,600];
for sub = 2:Nsub+1
    for s = 1:4
        ps_nr = agency_EEG{13,sub}([agency_EEG{13,sub}(:,2)]==so(s),1)';
        disp([num2str(sub) ' | ' num2str(so(s))])
        find(ps_nr(1:end) ~= [agency_EEG{22,sub}{s}(1:end)])
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% - re06 letztes EEG trial bei 600 kein passendes Agency Rating
%%% - nr08 bei 0 trial 221 agency rating, aber kein EEG?,
%       - index: 1346/1347 boundaries --> Anfang des trials abgeschnitten???
%%% - nr08 200ms bis trial 55 Übereinstimmung danach Unterschiede (durch
%%% das vorhergehende verschoben?)
%%% (aber trial 56 nicht das Problem scheinbar?)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% sorting for agency
% 2 Varianten:
%   a) 0-1 = 1, 1-2 = 2 ...
%   b) 0.5 - 1.5 = 1, 1.5 - 2.5 = 2,....
var = 1;

% FCz
AgEEG = agency_EEG(1,:);
[AgEEG{[2,43,84],1}] = deal('FCz','Fz','Cz');
[AgEEG{[3:11,13:21,23:31,33:41],1}] = deal('agency SOA 0', '0-1 (1)', '1-2 (2)', '2-3 (3)', '3-4 (4)', '4-5 (5)', '5-6 (6)', '6-7 (7)', '7-8 (8)',...
    'agency SOA 50', '0-1', '1-2', '2-3', '3-4', '4-5', '5-6', '6-7', '7-8',...
    'agency SOA 200', '0-1', '1-2', '2-3', '3-4', '4-5', '5-6', '6-7', '7-8',...
    'agency SOA 600', '0-1', '1-2', '2-3', '3-4', '4-5', '5-6', '6-7', '7-8');
AgEEG(44:82,1) = AgEEG(3:41,1); 
AgEEG(85:123,1) = AgEEG(3:41,1);


data_ind = [9,10,11,12; 15,16,17,18; 24,25,26,27; 33,34,35,36]; %1.row = agency, 2.row = EEG FCz, 3.row = Fz, 4.row = Cz
sort_ind = [3,13,23,33; 44,54,64,74; 85,95,105,115]; % rows: verschiedene Elektroden, columns = block start for different SOAs
if var == 1
    ags = 0:8; % rating boundaries
elseif var == 2
    ags = 1:8;
end
sms_ind = [1,9,17];% electrode block
[sms{sms_ind,1}] = deal('FCz', 'Fz','Cz');
[sms{[6,14,22],1}] = deal('mean over SOAs','mean over SOAs','mean over SOAs');


stat_AE = cell(0,0);
els = ["FCz", "Fz", "Cz",];

for el = 1:3
    for ss = 1:4 % for each SOA
        for sb = 2:size(agency_EEG,2) % for each subject
            for a = 1:length(ags)-1 % for each rating
                if var == 1
                    ag_ind = find(agency_EEG{data_ind(1,ss),sb}>ags(a) & agency_EEG{data_ind(1,ss),sb}<=ags(a+1));
                elseif var == 2
                    ag_ind = find(agency_EEG{data_ind(1,ss),sb}>ags(a)-0.5 & agency_EEG{data_ind(1,ss),sb}<=ags(a)+0.5);
                end
                if isempty(ag_ind) == 0
                    n=1;
                    while n<=length(ag_ind) & ag_ind(n) <= size(agency_EEG{data_ind(el+1,ss),sb},1)
                        AgEEG{sort_ind(el,ss)+a,sb}(n,:) = [agency_EEG{data_ind(el+1,ss),sb}(ag_ind(n),:)];
                        n=n+1;
                    end
                end
            end
        end
    end
        

    AgEEG{2,length(subject)+2} = 'Mean';
    
    for ss = 1:4 % SOA
        for con = 1:8 % Agency Rating
            sm = NaN(length(subject),801);
            for sb = 1:length(subject) % subject
                m = mean(AgEEG{sort_ind(el,ss)+con,sb+1},1,'omitnan');
                if isempty(m) == 0
                    sm(sb,:) = m;
                end
                sms{sms_ind(el)+ss,con} = sm;
            end
            AgEEG{sort_ind(el,ss)+con,length(subject)+2} = mean(sm,1,'omitnan');
        end
    end


    col = [255,0,0;255,255,0;0,255,0;0,255,255;0,0,255;255,0,255;255,0,127;96,96,96]./255;

    % all SOA together
%     figure()
%     hold on
%     for con = 1:8
%         plot(EEGtime,mean([AgEEG{sort_ind(el,1)+con,length(subject)+2};AgEEG{sort_ind(el,2)+con,length(subject)+2};AgEEG{sort_ind(el,3)+con,length(subject)+2};AgEEG{sort_ind(el,4)+con,length(subject)+2}],1,'omitnan'),'LineWidth',1, 'Color', col(con,:))
%     end
%     xlim([-200,400])
%     ylim([-15,15])
%     xlabel('relative time')
%     ylabel('mean amplitude [µV]')
%     title(horzcat('all SOAs | ', [AgEEG{sort_ind(el,1)-1,1}]))
%     lgd=legend({'1','2','3','4','5','6','7','8'});
%     title(lgd,'agency ratings')
%     if var == 1
%         saveas(gcf, ['ERP_agency_' [AgEEG{sort_ind(el,1)-1,1}] '.png'])
%     elseif var == 2
%         saveas(gcf, ['ERP_agency_' [AgEEG{sort_ind(el,1)-1,1}] '_var2.png'])
%     end

% separated for SOAs
%     figure('Position', [150,100, 1200, 600])
%     for ss = 1:4
%         subplot(2,2,ss)
%         hold on
%         for con = 1:8
%             plot(EEGtime, AgEEG{sort_ind(el,ss)+con,length(subject)+2},'LineWidth',1, 'Color', col(con,:))
%         end
%         xlim([-200,400])
%         ylim([-30,30])
%         xlabel('relative time')
%         ylabel('mean amplitude [µV]')
%         title([num2str(AgEEG{(sort_ind(el,1)-1),1}) ' | ' num2str(AgEEG{sort_ind(3,ss),1}(8:end))])
%         lgd=legend({'1','2','3','4','5','6','7','8'});
%         title(lgd,'agency ratings')
%     end
%     if var == 1
%         saveas(gcf, ['ERP_AgencySOA_' [AgEEG{sort_ind(el,1)-1,1}] '.png'])
%     elseif var == 2
%         saveas(gcf, ['ERP_AgencySOA_' [AgEEG{sort_ind(el,1)-1,1}] '_var2.png'])
%     end


    % Statistik (Anova, Einfluss vom rating)
    % über alle SOAs
    s = size(stat_AE,1);
    for con = 1:8
        sms{sms_ind(el)+6,con} = zeros(length(subject),801);
        for sb = 1:length(subject)
            sms{sms_ind(el)+6,con}(sb,:) = mean([sms{sms_ind(el)+1,1}(sb,:);sms{sms_ind(el)+2,1}(sb,:);sms{sms_ind(el)+3,1}(sb,:);sms{sms_ind(el)+4,1}(sb,:)],1,'omitnan');
        end
    end
    clear XN
    clear XP
    XN(:,1) = [min(sms{sms_ind(el)+6,1}(:,peaks{11,6}(1):peaks{11,6}(2)),[],2);...
        min(sms{sms_ind(el)+6,2}(:,peaks{11,6}(1):peaks{11,6}(2)),[],2);...
        min(sms{sms_ind(el)+6,3}(:,peaks{11,6}(1):peaks{11,6}(2)),[],2);...
        min(sms{sms_ind(el)+6,4}(:,peaks{11,6}(1):peaks{11,6}(2)),[],2);...
        min(sms{sms_ind(el)+6,5}(:,peaks{11,6}(1):peaks{11,6}(2)),[],2);...
        min(sms{sms_ind(el)+6,6}(:,peaks{11,6}(1):peaks{11,6}(2)),[],2);...
        min(sms{sms_ind(el)+6,7}(:,peaks{11,6}(1):peaks{11,6}(2)),[],2);...
        min(sms{sms_ind(el)+6,8}(:,peaks{11,6}(1):peaks{11,6}(2)),[],2)];
    XP(:,1) = [max(sms{sms_ind(el)+6,1}(:,peaks{12,6}(1):peaks{12,6}(2)),[],2);...
        max(sms{sms_ind(el)+6,2}(:,peaks{12,6}(1):peaks{12,6}(2)),[],2);...
        max(sms{sms_ind(el)+6,3}(:,peaks{12,6}(1):peaks{12,6}(2)),[],2);...
        max(sms{sms_ind(el)+6,4}(:,peaks{12,6}(1):peaks{12,6}(2)),[],2);...
        max(sms{sms_ind(el)+6,5}(:,peaks{12,6}(1):peaks{12,6}(2)),[],2);...
        max(sms{sms_ind(el)+6,6}(:,peaks{12,6}(1):peaks{12,6}(2)),[],2);...
        max(sms{sms_ind(el)+6,7}(:,peaks{12,6}(1):peaks{12,6}(2)),[],2);...
        max(sms{sms_ind(el)+6,8}(:,peaks{12,6}(1):peaks{12,6}(2)),[],2)];

    XN(:,2) = [ones(Nsub,1);ones(Nsub,1)*2;ones(Nsub,1)*3;ones(Nsub,1)*4;ones(Nsub,1)*5;...
        ones(Nsub,1)*6;ones(Nsub,1)*7;ones(Nsub,1)*8];
    XN(:,3) = [1:Nsub,1:Nsub,1:Nsub,1:Nsub,1:Nsub,1:Nsub,1:Nsub,1:Nsub]';
    XP(:,2) = [ones(Nsub,1);ones(Nsub,1)*2;ones(Nsub,1)*3;ones(Nsub,1)*4;ones(Nsub,1)*5;...
        ones(Nsub,1)*6;ones(Nsub,1)*7;ones(Nsub,1)*8];
    XP(:,3) = [1:Nsub,1:Nsub,1:Nsub,1:Nsub,1:Nsub,1:Nsub,1:Nsub,1:Nsub]';
    disp([num2str(el) '_N_all'])
    RMAOV1(XN)
    disp([num2str(el) '_P_all'])
    RMAOV1(XP)
    

%     times = 0:2:400;
%     cond = 1:8;
%     for t = 1:length(times)
%         ind = find(EEGtime==times(t));
%         x = [sms{sms_ind(el)+6,1}(:,ind),sms{sms_ind(el)+6,2}(:,ind),sms{sms_ind(el)+6,3}(:,ind),sms{sms_ind(el)+6,4}(:,ind),sms{sms_ind(el)+6,5}(:,ind),sms{sms_ind(el)+6,6}(:,ind),sms{sms_ind(el)+6,7}(:,ind),sms{sms_ind(el)+6,8}(:,ind)];
%         if isempty(x) == 0
%             stat_AE{s+t,1} = EEGtime(ind);
%             [stat_AE{s+t,2},~,stat_AE{s+t,3}] = kruskalwallis(x,cond,'off');
%         end
%     end

    % getrennt für SOAs
    for ss = 1:4
        con = 1:Nsub:Nsub*9;
        for c = 1:8
            XN(con(c):con(c+1)-1,1) = [min(sms{sms_ind(el)+ss,c}(:,peaks{11,6}(1):peaks{11,6}(2)),[],2)];
            XP(con(c):con(c+1)-1,1) = [max(sms{sms_ind(el)+ss,c}(:,peaks{12,6}(1):peaks{12,6}(2)),[],2)];
        end
        disp([num2str(el) '_SOA' num2str(ss) '_N'])
        RMAOV1(XN)
        disp([num2str(el) '_SOA' num2str(ss) '_P'])
        RMAOV1(XP)
    end
    
%     s_idx = [5,9,13,17];
%     for ss = 1:4
%         for t = 1:length(times)
%             ind = find(EEGtime==times(t));
%             x = [sms{sms_ind(el)+ss,1}(:,ind),sms{sms_ind(el)+ss,2}(:,ind),sms{sms_ind(el)+ss,3}(:,ind),sms{sms_ind(el)+ss,4}(:,ind),sms{sms_ind(el)+ss,5}(:,ind),sms{sms_ind(el)+ss,6}(:,ind),sms{sms_ind(el)+ss,7}(:,ind),sms{sms_ind(el)+ss,8}(:,ind)];
%             if isempty(x) == 0
%                 stat_AE{s+t,s_idx(ss)} = EEGtime(ind);
%                 [stat_AE{s+t,s_idx(ss)+1},~,stat_AE{s+t,s_idx(ss)+2}] = kruskalwallis(x,cond,'off');
%             end
%         end
%     end
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% ----------------- Agency Ratings gruppieren ----------------------- %%%

% 1,8 rausschmeißen, 2/3, 4/5,6/7
AgEEGgrp = AgEEG(1,1:end-1); % letzte Spalte sind die means da
raw_idx = [5;46;87;128]; % index for (2) in AgEEG for every electrode
% [sigAgEEGgrp{2:5,1}] = deal('FCz', 'Fz', 'Cz', 'M1'); 
% sigAgEEGgrp{1,2} = 'sig t';
% sigAgEEGgrp{1,3} = 'trend t';
el_idx = [3,12,21];
f1 = figure();
f2 = figure();
f3 = figure();
%f4 = figure();
figs = [f1,f2,f3];

for el = 1:3
    s = size(AgEEGgrp,1); 

    AgEEGgrp{s+1,1} = convertStringsToChars(els(el));
    [AgEEGgrp{[s+2,s+3,s+4,s+5],1}] = deal('all SOAs', 'low', 'medium', 'high');
    % letzte Zeile bei jedem Probanden = MEAN!!!!
    for sb = 2:Nsub+1
        AgEEGgrp{s+3,sb} = [AgEEG{raw_idx(el,1),sb};AgEEG{raw_idx(el,1)+1,sb};AgEEG{raw_idx(el,1)+10,sb};AgEEG{raw_idx(el,1)+11,sb};AgEEG{raw_idx(el,1)+20,sb};AgEEG{raw_idx(el,1)+21,sb};AgEEG{raw_idx(el,1)+30,sb};AgEEG{raw_idx(el,1)+31,sb}];
        AgEEGgrp{s+3,sb}(size(AgEEGgrp{s+3,sb},1)+1,:) = mean([AgEEGgrp{s+3,sb}],1);
        
        AgEEGgrp{s+4,sb} = [AgEEG{raw_idx(el,1)+2,sb};AgEEG{raw_idx(el,1)+3,sb};AgEEG{raw_idx(el,1)+12,sb};AgEEG{raw_idx(el,1)+13,sb};AgEEG{raw_idx(el,1)+22,sb};AgEEG{raw_idx(el,1)+23,sb};AgEEG{raw_idx(el,1)+32,sb};AgEEG{raw_idx(el,1)+33,sb}];
        AgEEGgrp{s+4,sb}(size(AgEEGgrp{s+4,sb},1)+1,:) = mean([AgEEGgrp{s+4,sb}],1);
        
        AgEEGgrp{s+5,sb} = [AgEEG{raw_idx(el,1)+4,sb};AgEEG{raw_idx(el,1)+5,sb};AgEEG{raw_idx(el,1)+14,sb};AgEEG{raw_idx(el,1)+15,sb};AgEEG{raw_idx(el,1)+24,sb};AgEEG{raw_idx(el,1)+25,sb};AgEEG{raw_idx(el,1)+34,sb};AgEEG{raw_idx(el,1)+35,sb}];
        AgEEGgrp{s+5,sb}(size(AgEEGgrp{s+5,sb},1)+1,:) = mean([AgEEGgrp{s+5,sb}],1);
    end

    % N per condition
    AgEEGgrp{s+2,length(subject)+2} = 'N';
    %low
    AgEEGgrp{s+3,length(subject)+2} = sum([size(AgEEGgrp{s+3,2},1),size(AgEEGgrp{s+3,3},1),size(AgEEGgrp{s+3,4},1),size(AgEEGgrp{s+3,5},1),...
        size(AgEEGgrp{s+3,6},1),size(AgEEGgrp{s+3,7},1),size(AgEEGgrp{s+3,8},1),size(AgEEGgrp{s+3,9},1),size(AgEEGgrp{s+3,10},1),...
        size(AgEEGgrp{s+3,11},1),size(AgEEGgrp{s+3,12},1),size(AgEEGgrp{s+3,13},1),size(AgEEGgrp{s+3,14},1),size(AgEEGgrp{s+3,15},1)])-Nsub;
    % medium
    AgEEGgrp{s+4,length(subject)+2} = sum([size(AgEEGgrp{s+4,2},1),size(AgEEGgrp{s+4,3},1),size(AgEEGgrp{s+4,4},1),size(AgEEGgrp{s+4,5},1),...
        size(AgEEGgrp{s+4,6},1),size(AgEEGgrp{s+4,7},1),size(AgEEGgrp{s+4,8},1),size(AgEEGgrp{s+4,9},1),size(AgEEGgrp{s+4,10},1),...
        size(AgEEGgrp{s+4,11},1),size(AgEEGgrp{s+4,12},1),size(AgEEGgrp{s+4,13},1),size(AgEEGgrp{s+4,14},1),size(AgEEGgrp{s+4,15},1)])-Nsub;
    % high 
    AgEEGgrp{s+5,length(subject)+2} = sum([size(AgEEGgrp{s+5,2},1),size(AgEEGgrp{s+5,3},1),size(AgEEGgrp{s+5,4},1),size(AgEEGgrp{s+5,5},1),...
        size(AgEEGgrp{s+5,6},1),size(AgEEGgrp{s+5,7},1),size(AgEEGgrp{s+5,8},1),size(AgEEGgrp{s+5,9},1),size(AgEEGgrp{s+5,10},1),...
        size(AgEEGgrp{s+5,11},1),size(AgEEGgrp{s+5,12},1),size(AgEEGgrp{s+5,13},1),size(AgEEGgrp{s+5,14},1),size(AgEEGgrp{s+5,15},1)])-Nsub;


    % mean over subjects
    % correction SM
    clear sm gm smgm
    for sb = 1:Nsub
        sm(sb,1:801) = mean([AgEEGgrp{s+3,sb+1}(end,:);AgEEGgrp{s+4,sb+1}(end,:);AgEEGgrp{s+5,sb+1}(end,:)],1);
    end
    gm = mean(sm,1);
    smgm(sb,1:801) = sm(sb,1:end) - gm(1:end);

    AgEEGgrp{s+2,length(subject)+3} = 'Mean';
    [AgEEGgrp{s+3,length(subject)+3},AgEEGgrp{s+4,length(subject)+3},AgEEGgrp{s+5,length(subject)+3}] = ...
    ...
    deal(mean([AgEEGgrp{s+3,2}(end,:)-smgm(1,:);AgEEGgrp{s+3,3}(end,:)-smgm(2,:);AgEEGgrp{s+3,4}(end,:)-smgm(3,:);...
    AgEEGgrp{s+3,5}(end,:)-smgm(4,:);AgEEGgrp{s+3,6}(end,:)-smgm(5,:);AgEEGgrp{s+3,7}(end,:)-smgm(6,:);...
    AgEEGgrp{s+3,8}(end,:)-smgm(7,:);AgEEGgrp{s+3,9}(end,:)-smgm(8,:);AgEEGgrp{s+3,10}(end,:)-smgm(9,:);...
    AgEEGgrp{s+3,11}(end,:)-smgm(10,:);AgEEGgrp{s+3,12}(end,:)-smgm(11,:);AgEEGgrp{s+3,13}(end,:)-smgm(12,:);...
    AgEEGgrp{s+3,14}(end,:)-smgm(13,:);AgEEGgrp{s+3,15}(end,:)-smgm(14,:)],1),...
    ...
    mean([AgEEGgrp{s+4,2}(end,:)-smgm(1,:);AgEEGgrp{s+4,3}(end,:)-smgm(2,:);AgEEGgrp{s+4,4}(end,:)-smgm(3,:);...
    AgEEGgrp{s+4,5}(end,:)-smgm(4,:);AgEEGgrp{s+4,6}(end,:)-smgm(5,:);AgEEGgrp{s+4,7}(end,:)-smgm(6,:);...
    AgEEGgrp{s+4,8}(end,:)-smgm(7,:);AgEEGgrp{s+4,9}(end,:)-smgm(8,:);AgEEGgrp{s+4,10}(end,:)-smgm(9,:);...
    AgEEGgrp{s+4,11}(end,:)-smgm(10,:);AgEEGgrp{s+4,12}(end,:)-smgm(11,:);AgEEGgrp{s+4,13}(end,:)-smgm(12,:);...
    AgEEGgrp{s+4,14}(end,:)-smgm(13,:);AgEEGgrp{s+4,15}(end,:)-smgm(14,:)],1),...
    ...
    mean([AgEEGgrp{s+5,2}(end,:)-smgm(1,:);AgEEGgrp{s+5,3}(end,:)-smgm(2,:);AgEEGgrp{s+5,4}(end,:)-smgm(3,:);...
    AgEEGgrp{s+5,5}(end,:)-smgm(4,:);AgEEGgrp{s+5,6}(end,:)-smgm(5,:);AgEEGgrp{s+5,7}(end,:)-smgm(6,:);...
    AgEEGgrp{s+5,8}(end,:)-smgm(7,:);AgEEGgrp{s+5,9}(end,:)-smgm(8,:);AgEEGgrp{s+5,10}(end,:)-smgm(9,:);...
    AgEEGgrp{s+5,11}(end,:)-smgm(10,:);AgEEGgrp{s+5,12}(end,:)-smgm(11,:);AgEEGgrp{s+5,13}(end,:)-smgm(12,:);...
    AgEEGgrp{s+5,14}(end,:)-smgm(13,:);AgEEGgrp{s+5,15}(end,:)-smgm(14,:)],1));
    
    % SEM daneben
    AgEEGgrp{s+2,length(subject)+4} = 'SEM';
    [AgEEGgrp{s+3,length(subject)+4},AgEEGgrp{s+4,length(subject)+4},AgEEGgrp{s+5,length(subject)+4}] = ...
    ...
    deal(std([AgEEGgrp{s+3,2}(end,:)-smgm(1,:);AgEEGgrp{s+3,3}(end,:)-smgm(2,:);AgEEGgrp{s+3,4}(end,:)-smgm(3,:);...
    AgEEGgrp{s+3,5}(end,:)-smgm(4,:);AgEEGgrp{s+3,6}(end,:)-smgm(5,:);AgEEGgrp{s+3,7}(end,:)-smgm(6,:);...
    AgEEGgrp{s+3,8}(end,:)-smgm(7,:);AgEEGgrp{s+3,9}(end,:)-smgm(8,:);AgEEGgrp{s+3,10}(end,:)-smgm(9,:);...
    AgEEGgrp{s+3,11}(end,:)-smgm(10,:);AgEEGgrp{s+3,12}(end,:)-smgm(11,:);AgEEGgrp{s+3,13}(end,:)-smgm(12,:);...
    AgEEGgrp{s+3,14}(end,:)-smgm(13,:);AgEEGgrp{s+3,15}(end,:)-smgm(14,:)],0,1)/sqrt(length(subject)),...
    ...
    std([AgEEGgrp{s+4,2}(end,:)-smgm(1,:);AgEEGgrp{s+4,3}(end,:)-smgm(2,:);AgEEGgrp{s+4,4}(end,:)-smgm(3,:);...
    AgEEGgrp{s+4,5}(end,:)-smgm(4,:);AgEEGgrp{s+4,6}(end,:)-smgm(5,:);AgEEGgrp{s+4,7}(end,:)-smgm(6,:);...
    AgEEGgrp{s+4,8}(end,:)-smgm(7,:);AgEEGgrp{s+4,9}(end,:)-smgm(8,:);AgEEGgrp{s+4,10}(end,:)-smgm(9,:);...
    AgEEGgrp{s+4,11}(end,:)-smgm(10,:);AgEEGgrp{s+4,12}(end,:)-smgm(11,:);AgEEGgrp{s+4,13}(end,:)-smgm(12,:);...
    AgEEGgrp{s+4,14}(end,:)-smgm(13,:);AgEEGgrp{s+4,15}(end,:)-smgm(14,:)],0,1)/sqrt(length(subject)),...
    ...
    std([AgEEGgrp{s+5,2}(end,:)-smgm(1,:);AgEEGgrp{s+5,3}(end,:)-smgm(2,:);AgEEGgrp{s+5,4}(end,:)-smgm(3,:);...
    AgEEGgrp{s+5,5}(end,:)-smgm(4,:);AgEEGgrp{s+5,6}(end,:)-smgm(5,:);AgEEGgrp{s+5,7}(end,:)-smgm(6,:);...
    AgEEGgrp{s+5,8}(end,:)-smgm(7,:);AgEEGgrp{s+5,9}(end,:)-smgm(8,:);AgEEGgrp{s+5,10}(end,:)-smgm(9,:);...
    AgEEGgrp{s+5,11}(end,:)-smgm(10,:);AgEEGgrp{s+5,12}(end,:)-smgm(11,:);AgEEGgrp{s+5,13}(end,:)-smgm(12,:);...
    AgEEGgrp{s+5,14}(end,:)-smgm(13,:);AgEEGgrp{s+5,15}(end,:)-smgm(14,:)],0,1)/sqrt(length(subject)));


    % Statistik: (Kruskal-Wallis, permutation tests); Anova, t-tests
    % X = matrix, 3 columns (categories), 14 rows = subject mean
    [AgEEGgrp{s+6,1:8}] = deal('Anova N','df','F','p', 'Anova P','df', 'F','p');
    % N1
    %grp = 1:3;
    %XN = zeros(Nsub,length(grp));
    clear XN XP
    for sb = 1:Nsub
        mlow = mean([AgEEGgrp{el_idx(el)+1,sb+1}]); % mean per subject for low ratings
        nlow = mlow([peaks{11,6}(1):peaks{11,6}(2)]); % intervall around grand mean N peak
        XN(sb,1) = min(nlow,[],2); % personal N peak
        XP(sb,1) = max(mlow(peaks{12,6}(1):peaks{12,6}(2)));
        %Intlow = mlow([peaks{11,6}(1)+i-1]-10:[peaks{11,6}(1)+i-1]+10); % interval around personal N peak
        
        mmid = mean([AgEEGgrp{el_idx(el)+2,sb+1}]);
        nmid = mmid(peaks{11,6}(1):peaks{11,6}(2));
        XN(sb+Nsub,1) = min(nmid,[],2); % personal N peak
        XP(sb+Nsub,1) = max(mmid(peaks{12,6}(1):peaks{12,6}(2)));
        %Intmid = mmid([peaks{11,6}(1)+i-1]-10:[peaks{11,6}(1)+i-1]+10); % interval around personal N peak
        
        mhigh = mean([AgEEGgrp{el_idx(el)+3,sb+1}]);
        nhigh = mhigh(peaks{11,6}(1):peaks{11,6}(2));
        XN(sb+2*Nsub,1) = min(nhigh,[],2); % personal N peak
        XP(sb+2*Nsub,1) = max(mhigh(peaks{12,6}(1):peaks{12,6}(2)));
        %Inthigh = mhigh([peaks{11,6}(1)+i-1]-10:[peaks{11,6}(1)+i-1]+10); % interval around personal N peak
        
        %XN(sb,1:3) = [mean(Intlow),mean(Intmid),mean(Inthigh)];
    end
    lmu{1,el} = [mean(XN(1:Nsub,1)), mean(XP(1:Nsub,1))];
    lmu{2,el} = [std(XN(1:Nsub,1))/sqrt(Nsub), std(XP(1:Nsub,1))/sqrt(Nsub)];
    mmu{1,el} = [mean(XN(Nsub+1:2*Nsub,1)), mean(XP(Nsub+1:2*Nsub,1))];
    mmu{2,el} = [std(XN(Nsub+1:2*Nsub,1))/sqrt(Nsub), std(XP(Nsub+1:2*Nsub,1))/sqrt(Nsub)];
    hmu{1,el} = [mean(XN(2*Nsub+1:end,1)), mean(XP(2*Nsub+1:end,1))];
    hmu{2,el} = [std(XN(2*Nsub+1:end,1))/sqrt(Nsub), std(XP(2*Nsub+1:end,1))/sqrt(Nsub)];   

    % Shapiro Wilks test
    [H,shapnlow,~] = swtest(XN(1:Nsub,1),0.01) % fcz: 0.16, fz: 0.41, cz: 0.42
    [H,shapnmed,~] = swtest(XN(Nsub+1:2*Nsub,1),0.01) % fcz: 0.53, fz: 0.19, cz: 0.26
    [H,shapnhig,~] = swtest(XN(2*Nsub+1:3*Nsub,1),0.01) % fcz: 0.91, fz: 0.44, cz: 0.57
    
    [H,shapplow,~] = swtest(XP(1:Nsub,1),0.01) % fcz: 0.64, fz: 0.58, cz: 0.61
    [H,shappmed,~] = swtest(XP(Nsub+1:2*Nsub,1),0.01) % fcz: 0.89, fz: 0.96, cz: 0.24
    [H,shapphig,~] = swtest(XP(2*Nsub+1:3*Nsub,1),0.01) % fcz: 0.86, fz: 0.93, cz: 0.84
    % normalverteilt --> ANOVA passt

    XN(:,2) = [ones(Nsub,1);ones(Nsub,1)*2;ones(Nsub,1)*3];
    XN(:,3) = [1:Nsub,1:Nsub,1:Nsub]';
    XP(:,2:3) = XN(:,2:3);
    
    disp([num2str(el) '_N'])
    RMAOV1(XN)
    disp([num2str(el) '_P'])
    RMAOV1(XP)
    %[AgEEGgrp{s+7,2},~,AgEEGgrp{s+7,3}] = kruskalwallis(XN,grp,'off');
    
    %t-tests
    [AgEEGgrp{s+8,[1:8]}] = deal('t-test N','l-m','l-h','m-h', 't-test P', 'l-m','l-h','m-h');
    [~,AgEEGgrp{s+9,2}] = ttest(XN(1:Nsub,1),XN(Nsub+1:Nsub+Nsub,1)); %l-m
    [~,AgEEGgrp{s+9,3}] = ttest(XN(1:Nsub,1),XN(2*Nsub+1:end,1)); % l-h
    [~,AgEEGgrp{s+9,4}] = ttest(XN(Nsub+1:Nsub+Nsub,1),XN(2*Nsub+1:end,1)); %m-h
    [~,AgEEGgrp{s+9,6}] = ttest(XP(1:Nsub,1),XP(Nsub+1:Nsub+Nsub,1)); %l-m
    [~,AgEEGgrp{s+9,7}] = ttest(XP(1:Nsub,1),XP(2*Nsub+1:end,1)); % l-h
    [~,AgEEGgrp{s+9,8}] = ttest(XP(Nsub+1:Nsub+Nsub,1),XP(2*Nsub+1:end,1)); %m-h
    
    %%%% SPSS export
    peakagency = [XN(1:Nsub,1),XN(Nsub+1:2*Nsub,1), XN(2*Nsub+1:end,1),XP(1:Nsub,1),XP(Nsub+1:2*Nsub,1), XP(2*Nsub+1:end,1)];
    varnames={'Nlow','Nmid','Nhigh','Plow','Pmid','Phigh'};
    save4spss(peakagency,varnames,['Peakvs.AgencyRating_el' num2str(el) '.dat'])


    % P2
%     XP = zeros(Nsub,length(grp));
%     
%     for sb = 1:Nsub
%         mlow = mean([AgEEGgrp{el_idx(el)+1,sb+1}]); % mean per subject for low ratings
%         plow = mlow([peaks{12,6}(1):peaks{12,6}(2)]); % intervall around grand mean N peak
%         [m,i] = min(plow,[],2); % personal N peak
%         Intlow = mlow([peaks{12,6}(1)+i-1]-10:[peaks{12,6}(1)+i-1]+10); % interval around personal N peak
%         
%         mmid = mean([AgEEGgrp{el_idx(el)+2,sb+1}]);
%         pmid = mmid(peaks{12,6}(1):peaks{12,6}(2));
%         [m,i] = min(pmid,[],2); % personal N peak
%         Intmid = mmid([peaks{12,6}(1)+i-1]-10:[peaks{12,6}(1)+i-1]+10); % interval around personal N peak
%         
%         mhigh = mean([AgEEGgrp{el_idx(el)+3,sb+1}]);
%         phigh = mhigh(peaks{12,6}(1):peaks{12,6}(2));
%         [m,i] = min(phigh,[],2); % personal N peak
%         Inthigh = mhigh([peaks{12,6}(1)+i-1]-10:[peaks{12,6}(1)+i-1]+10); % interval around personal N peak
%         
%         XP(sb,1:3) = [mean(Intlow),mean(Intmid),mean(Inthigh)];
%     end
%     
%     [AgEEGgrp{s+7,5},~,AgEEGgrp{s+7,6}] = kruskalwallis(XP,grp,'off');
% 



%     [AgEEGgrp{s+7,1:3}] = deal('timepoint','p','stats');
%     
%     time = 0:2:400;
% 
%     for t = 1:length(time)
%         ind = find(EEGtime == time(t));
%         X = zeros(length(subject),3);
%         for sb = 1:length(subject)
%             X(sb,1) = AgEEGgrp{s+3,sb+1}(end,ind);
%             X(sb,2) = AgEEGgrp{s+4,sb+1}(end,ind);
%             X(sb,3) = AgEEGgrp{s+5,sb+1}(end,ind);
%         end
%         AgEEGgrp{s+7+t,1} = time(t);
%         
%     end
    
%     % signifikant?
%     sigAgEEGgrp{el+1,2} = [AgEEGgrp{find([AgEEGgrp{s+8:end,2}]<=0.05)+s+8,1}];
%     sigAgEEGgrp{el+1,3} = [AgEEGgrp{find([AgEEGgrp{s+8:end,2}]<=0.1)+s+8,1}];
%     
    % figure
    set(0, 'CurrentFigure', figs(1,el))
    hold on
    plot([-200,400],[0 0], 'Color', [153/255, 153/255, 153/255]) % Nulllinie x
    plot([0 0],[-15, 15], 'Color', [153/255, 153/255, 153/255]) % Nulllinie y
    
    p1 = plot(EEGtime,AgEEGgrp{s+3,end-1},'g'); % mean
    fill([EEGtime,EEGtime(end:-1:1)],[[AgEEGgrp{s+3,end-1}]-[AgEEGgrp{s+3,end}],flip([AgEEGgrp{s+3,end-1}]+[AgEEGgrp{s+3,end}])],'g','FaceAlpha',0.3,'EdgeColor','none')
    
    p2 = plot(EEGtime,AgEEGgrp{s+4,end-1},'b');
    fill([EEGtime,EEGtime(end:-1:1)],[[AgEEGgrp{s+4,end-1}]-[AgEEGgrp{s+4,end}],flip([AgEEGgrp{s+4,end-1}]+[AgEEGgrp{s+4,end}])],'b','FaceAlpha',0.3,'EdgeColor','none')
    
    p3 = plot(EEGtime,AgEEGgrp{s+5,end-1},'r');
    fill([EEGtime,EEGtime(end:-1:1)],[[AgEEGgrp{s+5,end-1}]-[AgEEGgrp{s+5,end}],flip([AgEEGgrp{s+5,end-1}]+[AgEEGgrp{s+5,end}])],'r','FaceAlpha',0.3,'EdgeColor','none')

    xlim([-200, 400])
    ylim([-15 15])
    xlabel('relative time to tone onset [ms]')
    ylabel('mean amplitude [µV]')
    title([els(el) ' | all SOAs, grouped ratings'])
    lgd = legend({'','', 'low', '', 'medium','','high','',''}, 'Location', 'northwest');
    %lgd = legend({'','',['low (N = ' num2str(AgEEGgrp{s+3,end-2}) ')'],'',['medium (N = ' num2str(AgEEGgrp{s+4,end-2}) ')'],'',['high (N = ' num2str(AgEEGgrp{s+5,end-2}) ')'],''}, 'Location','northwest');
    title(lgd,'rating')

    %saveas(gcf, ['ERP_AgencyGrouped_' convertStringsToChars(els(el)) '.png'])
end

% Anova results
%FCz
[AgEEGgrp{8,[2:4,6:8]}] = deal([2,32],0.314, 0.7326, [2,32],5.841, 0.0069);
%Fz
[AgEEGgrp{17,[2:4,6:8]}] = deal([2,32],0.246, 0.7832, [2,32],2.676, 0.0842);
%Cz
[AgEEGgrp{26,[2:4,6:8]}] = deal([2,32],0.564, 0.5745, [2,32],10.281, 0.0004);
%M1
%[AgEEGgrp{35,[2:4,6:8]}] = deal([2,26],0.413, 0.6658, [2,26],0.696, 0.5077);

cd('../Figures')
for el = 1:3
    set(0, 'CurrentFigure', figs(el))
    if AgEEGgrp{el_idx(el)+5,4} <= 0.05
        fill([peaks{11,3}-20,peaks{11,3}-20,peaks{11,3}+20,peaks{11,3}+20],[-15,15,15,-15],[180/255, 180/255, 180/255], 'FaceAlpha',0.3,'EdgeColor','none')
        lgd = legend({'','', 'low', '', 'medium','','high','',''}, 'Location', 'northwest');
        %lgd = legend({'','',['low (N = ' num2str(AgEEGgrp{el_idx(el)+1,end-2}) ')'],'',['medium (N = ' num2str(AgEEGgrp{el_idx(el)+2,end-2}) ')'],'',['high (N = ' num2str(AgEEGgrp{el_idx(el)+3,end-2}) ')'],'',''}, 'Location','northwest');
        title(lgd,'rating')
    elseif AgEEGgrp{el_idx(el)+5,8} <= 0.05
        fill([peaks{12,3}-20,peaks{12,3}-20,peaks{12,3}+20,peaks{12,3}+20],[-15,15,15,-15],[180/255, 180/255, 180/255], 'FaceAlpha',0.3,'EdgeColor','none')
        lgd = legend({'','', 'low', '', 'medium','','high','',''}, 'Location', 'northwest');
        %lgd = legend({'','',['low (N = ' num2str(AgEEGgrp{el_idx(el)+1,end-2}) ')'],'',['medium (N = ' num2str(AgEEGgrp{el_idx(el)+2,end-2}) ')'],'',['high (N = ' num2str(AgEEGgrp{el_idx(el)+3,end-2}) ')'],'',''}, 'Location','northwest');
        title(lgd,'rating')
    end
    saveas(gcf,['ERP_AgencyGrouped_nolegend' AgEEGgrp{el_idx(el)-1,1} '.png'])
end
cd('../EEG')



% Verteilung anschauen, um zu schauen, ob Einteilung Sinn macht????
% 0-3,>3-6,>6-<9

% Alternative: mittel  3,4,5, drunter alles, drüber alles
%fs = AnalyzeEEG_groupedagency(Nsub, agency_EEG, peaks);
% ANOVA results (version 3)
% FCz
% SOA 0
% N: F(2,32) = 0.956, p = 0.3951
% P: F(2,32) = 0.817, p = 0.4509
% SOA 50
% N: F(2,32) = 0.371, p = 0.6932
% P: F(2,32) = 1.464, p = 0.2464
% SOA 200
% N: F(2,32) = 0.464, p = 0.6329
% P: F(2,32) = 0.330, p = 0.7212
% SOA 600
% N: F(2,32) = 0.210, p = 0.8119
% P: F(2,32) = 0.416, p = 0.6633
% all SOAs
% N: F(2,32) = 1.219, p = 0.3088
% P: F(2,32) = 2.375, p = 0.1092

%set(0, 'CurrentFigure', fs)
% saveas(fs{1,1},'ERP_Agencydrittel_SOAs_FCz.png')
% saveas(fs{1,2},'ERP_Agencydrittel_all_FCz.png')

% Fz
% SOA 0
% N: F(2,32) = 0.970, p = 0.3900
% P: F(2,32) = 0.948, p = 0.3983
% SOA 50
% N: F(2,32) = 1.322, p = 0.2808
% P: F(2,32) = 1.995, p = 0.1526
% SOA 200
% N: F(2,32) = 1.089, p = 0.3487
% P: F(2,32) = 0.097, p = 0.9079
% SOA 600
% N: F(2,32) = 0.470, p = 0.6289
% P: F(2,32) = 0.085, p = 0.9190
% all SOAs
% N: F(2,32) = 0.613, p = 0.5479
% P: F(2,32) = 1.775, p = 0.1857

%set(0, 'CurrentFigure', fs)
% saveas(fs{2,1},'ERP_Agencydrittel_SOAs_Fz.png')
% saveas(fs{2,2},'ERP_Agencydrittel_all_Fz.png')

% Cz
% SOA 0
% N: F(2,32) = 1.185, p = 0.3188
% P: F(2,32) = 1.188, p = 0.3179
% SOA 50
% N: F(2,32) = 0.733, p = 0.4885
% P: F(2,32) = 3.723, p = 0.0352
% SOA 200
% N: F(2,32) = 0.007, p = 0.9929
% P: F(2,32) = 1.051, p = 0.3614
% SOA 600
% N: F(2,32) = 0.229, p = 0.7967
% P: F(2,32) = 1.719, p = 0.1954
% all SOAs
% N: F(2,32) = 0.524, p = 0.5971
% P: F(2,32) = 4.844, p = 0.0145

% set(0, 'CurrentFigure', fs{3,1})
% subplot(2,2,2)
% hold on
% fill([peaks{12,3}-20,peaks{12,3}+20,peaks{12,3}+20,peaks{12,3}-20],[-15 -15 15 15], [180/255, 180/255, 180/255], 'EdgeColor', 'none', 'FaceAlpha',0.3)
% legend({'','','','low','','medium','','high',''})
% saveas(fs{3,1},'ERP_Agencydrittel_SOAs_Cz.png')
% 
% set(0, 'CurrentFigure', fs{3,2})
% hold on
% fill([peaks{12,3}-20,peaks{12,3}+20,peaks{12,3}+20,peaks{12,3}-20],[-15 -15 15 15], [180/255, 180/255, 180/255], 'EdgeColor', 'none', 'FaceAlpha',0.3)
% legend({'','','','low','','medium','','high',''})
% saveas(fs{3,2},'ERP_Agencydrittel_all_Cz.png')



%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  ---------------------- 3. Intervall test ------------------------  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% latencies gebint in 10er Schritten
latencies = subjects(1,:);

for sb = 1:length(latencies)-1
    lat = intervals(subject{sb});
    latencies{2,sb+1} = lat;
end

% line plot
% mean over all conditions
% schadow for min and max?

figure()
hold on
for sb = 2:size(latencies,2)
    plot([1:5], [latencies{2,sb}{7,2:6}],'o--')

end
xticks([1:5])
xticklabels({'A','SOA 0','SOA 50','SOA 200','SOA 600'})
xlabel('condition')
ylabel('mean latency between the tones')
ylim([1100,1800])

saveas(gcf, 'Interval_control.png')
% stacked bar plot
% 5 positions for the different conditions
% for each conditions subjects next to each other?
% different lengths stuck upon each other (sum)

% bar


% Anova als Statistik??

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  --------------------- 4. second tone ---------------------------   %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Fz, Cz, FCz
channel = [21,5,14];
scd_tone=subjects(1,:);
[scd_tone{2:7,1}] = deal('EEGtime','intensity A','ERP A', 'intensity MA', 'ERP MA','SOAs');

for sb = 1:Nsub
    toneA = [];
    toneMA = [];
    fn = subject{sb};
    for t = 1:length(subjects{3,sb+1}.trial)
        if subjects{3,sb+1}.trial(t).valid == 1
            toneA = horzcat(toneA, subjects{3,sb+1}.trial(t).level);
        end
    end
    for t = 1:length(subjects{2,sb+1}.trial)
        if subjects{2,sb+1}.trial(t).valid == 1
            toneMA = horzcat(toneMA,subjects{2,sb+1}.trial(t).level);
%           disp(length(toneMA))
        end
    end
    ErrTr = ErrorTrials(fn);
    [EEGtime,dataA,dataMA,soa] = Analyze2tone(channel, fn, toneA, toneMA, ErrTr);

    [scd_tone{2:7,sb+1}] = deal(EEGtime, toneA, dataA, toneMA, dataMA,soa);
end

% mean over subjects: for each electrode and each loudness
[scd_tone{[8:13,15:20],1}] = deal('µ ERP A', '72','73','74','75','76', 'µ ERP MA','72','73','74','75','76');
for el = 1:length(channel)
    el_ind = find([scd_tone{4,2}{1,2:end}] == channel(el))+1;
    for ld = 1:5
        scd_tone{8,el+1} = EEG_data{4,2}.EEG.chanlocs(channel(el)).labels;
        meansA = zeros(Nsub,length(scd_tone{2,2}));
        meansMA = zeros(Nsub,length(scd_tone{2,2}));
        for sb = 1:Nsub % Matrix of the mean ERP for that electrode and intensity for each subject (rows)
            meansA(sb,:) = scd_tone{4,sb+1}{ld+1,el_ind}(end,:);
            meansMA(sb,:) = scd_tone{6,sb+1}{ld+1,el_ind}(end,:);
        end
        scd_tone{8+ld, el+1} = mean(meansA,1); % mean over subjects for that electrode and intensity
        scd_tone{15+ld, el+1} = mean(meansMA,1);
    end
end

% Kruskal Wallis Test
% erp = matrix, row = subject, col = mean for loudness for peak (N1/P2)
% A
[scd_tone{[14,21],1}] = deal('Kruskal-Wallis (N/P)','Kruskal-Wallis (N/P)');
loud = 72:76;
for el = 1:length(channel)
    erpN = zeros(Nsub,length(loud));
    erpP = zeros(Nsub,length(loud));
    
    for sb = 1:Nsub
        nintv = find([scd_tone{2,sb+1}]==peaks{11,5}(1)):find([scd_tone{2,sb+1}]==peaks{11,5}(2));
        pintv = find([scd_tone{2,sb+1}]==peaks{12,5}(1)):find([scd_tone{2,sb+1}]==peaks{12,5}(2));
    
        for ld = 1:5
            [n1, nidx] = min(scd_tone{4,sb+1}{ld+1,el+1}(end,nintv)); % index of personal min + personal min
            erpN(sb,ld) = n1;
            %erpN(sb,ld) = mean([scd_tone{4,sb+1}{ld+1,el+1}(end,nintv(nidx)-20:nintv(nidx)+20)]);
            
            [p2, pidx] = min(scd_tone{4,sb+1}{ld+1,el+1}(end,pintv)); % index of personal max + personal max
            erpP(sb,ld) = p2;
            %erpP(sb,ld) = mean([scd_tone{4,sb+1}{ld+1,el+1}(end,pintv(pidx)-20:pintv(pidx)+20)]);
        end
    end
    scd_tone{14,el+1} = [kruskalwallis(erpN,loud,'off'), kruskalwallis(erpP,loud,'off')];
end
% MA
loud = 72:76;
for el = 1:length(channel)
    erpN = zeros(Nsub,length(loud));
    erpP = zeros(Nsub,length(loud));
    
    for sb = 1:Nsub
        nintv = find([scd_tone{2,sb+1}]==peaks{11,5}(1)):find([scd_tone{2,sb+1}]==peaks{11,5}(2));
        pintv = find([scd_tone{2,sb+1}]==peaks{12,5}(1)):find([scd_tone{2,sb+1}]==peaks{12,5}(2));
    
        for ld = 1:5
            [n1, nidx] = min(scd_tone{6,sb+1}{ld+1,el+1}(end,nintv)); % index of personal min + personal min
            erpN(sb, ld) = n1;
            %erpN(sb,ld) = mean([scd_tone{6,sb+1}{ld+1,el+1}(end,nintv(nidx)-20:nintv(nidx)+20)]);
            
            [p2, pidx] = min(scd_tone{6,sb+1}{ld+1,el+1}(end,pintv)); % index of personal max + personal max
            erpP(sb, ld) = p2;
            %erpP(sb,ld) = mean([scd_tone{6,sb+1}{ld+1,el+1}(end,pintv(pidx)-20:pintv(pidx)+20)]);
        end
    end
    scd_tone{21,el+1} = [kruskalwallis(erpN,loud,'off'), kruskalwallis(erpP,loud,'off')];
end

% boxplot für N1, P2
% for each electrode?
% auditory: scd_tone{4,sb} enthält pro Lautstärke und Channel ein mean (1x801)
% motor-auditory: same
% subplot 1: x = intensities, y = mean +/- SE peak N1 (over subjects) A
% subplot 2: peak N1 MA
% subplot 3: peak P2 A
% subplot 4: peak P2 MA
% Statistik: Anova, paired t-test (Lautstärken gegeneinander)

clear peak_int
for el = 1:length(channel)
    elec = EEG_data{4,2}.EEG.chanlocs(channel(el)).labels
    [peak_int.(elec){1,1:5}] = deal('MA','N1', 'P2', 'lat N1', 'lat P2');
    [peak_int.(elec){2:6,1}] = deal('72 personal peak','73 personal peak','74 personal peak','75 personal peak','76 personal peak');
    [peak_int.(elec){1,12:16}] = deal('A','N1', 'P2', 'lat N1', 'lat P2');
    for ld = 1:5
        n1 = zeros(Nsub,1);
        p1 = zeros(Nsub,1);
        n2 = zeros(Nsub,1);
        p2 = zeros(Nsub,1);
        for sb = 1:Nsub
            [n1(sb,1), n1(sb,2)] = min(scd_tone{6,sb+1}{ld+1,el+1}(end,peaks{11,6}(1):peaks{11,6}(2)));
            [p1(sb,1), p1(sb,2)] = max(scd_tone{6,sb+1}{ld+1,el+1}(end,peaks{12,6}(1):peaks{12,6}(2)));
            [n2(sb,1), n2(sb,2)] = min(scd_tone{4,sb+1}{ld+1,el+1}(end,peaks{11,6}(1):peaks{11,6}(2)));
            [p2(sb,1), p2(sb,2)] = max(scd_tone{4,sb+1}{ld+1,el+1}(end,peaks{12,6}(1):peaks{12,6}(2)));
        
        end
        peak_int.(elec){ld+1,2} = n1(:,1);
        peak_int.(elec){ld+1,3} = p1(:,1);
        peak_int.(elec){ld+1,13} = n2(:,1);
        peak_int.(elec){ld+1,14} = p2(:,1);
        % lat
        peak_int.(elec){ld+1,4} = n1(:,2)+peaks{11,6}(1);
        peak_int.(elec){ld+1,5} = p1(:,2)+peaks{12,6}(1);
        peak_int.(elec){ld+1,15} = n2(:,2)+peaks{11,6}(1);
        peak_int.(elec){ld+1,16} = p2(:,2)+peaks{12,6}(1);
    end
    
    % Shapiro Wilks
    % MA
    [H, shapN72,~] = swtest(peak_int.(elec){2,2},0.01) % fcz: 0.34, fz: 0.51, cz: 0.45
    [H, shapN73,~] = swtest(peak_int.(elec){3,2},0.01) % fcz: 1.00, fz: 0.95, cz: 0.80
    [H, shapN74,~] = swtest(peak_int.(elec){4,2},0.01) % fcz: 0.05, fz: 0.25, cz: 0.11
    [H, shapN75,~] = swtest(peak_int.(elec){5,2},0.01) % fcz: 0.49, fz: 0.38, cz: 0.17
    [H, shapN76,~] = swtest(peak_int.(elec){6,2},0.01) % fcz: 0.70, fz: 0.54, cz: 0.56
    [H, shapp72,~] = swtest(peak_int.(elec){2,3},0.01) % fcz: 0.83, fz: 0.53, cz: 0.62
    [H, shapp73,~] = swtest(peak_int.(elec){3,3},0.01) % fcz: 0.20, fz: 0.60, cz: 0.57
    [H, shapp74,~] = swtest(peak_int.(elec){4,3},0.01) % fcz: 0.49, fz: 0.15, cz: 0.30
    [H, shapp75,~] = swtest(peak_int.(elec){5,3},0.01) % fcz: 0.21, fz: 0.06, cz: 0.19
    [H, shapp76,~] = swtest(peak_int.(elec){6,3},0.01) % fcz: 0.25, fz: 0.49, cz: 0.80
    % A
    [H, shapN72,~] = swtest(peak_int.(elec){2,13},0.01) % fcz: 0.72, fz: 0.82, cz: 0.25
    [H, shapN73,~] = swtest(peak_int.(elec){3,13},0.01) % fcz: 0.88, fz: 0.25, cz: 0.59
    [H, shapN74,~] = swtest(peak_int.(elec){4,13},0.01) % fcz: 0.22, fz: 0.28, cz: 0.81
    [H, shapN75,~] = swtest(peak_int.(elec){5,13},0.01) % fcz: 0.05, fz: 0.014, cz: 0.15
    [H, shapN76,~] = swtest(peak_int.(elec){6,13},0.01) % fcz: 0.72, fz: 0.71, cz: 0.72
    [H, shapp72,~] = swtest(peak_int.(elec){2,14},0.01) % fcz: 0.76, fz: 0.54, cz: 0.97
    [H, shapp73,~] = swtest(peak_int.(elec){3,14},0.01) % fcz: 0.54, fz: 0.54, cz: 0.87
    [H, shapp74,~] = swtest(peak_int.(elec){4,14},0.01) % fcz: 0.20, fz: 0.84, cz: 0.72
    [H, shapp75,~] = swtest(peak_int.(elec){5,14},0.01) % fcz: 0.79, fz: 0.70, cz: 0.74
    [H, shapp76,~] = swtest(peak_int.(elec){6,14},0.01) % fcz: 0.27, fz: 0.15, cz: 0.38
    % normalverteilt -> Anova passt

    % Anova, t-test
    % N1, MA
    X_intnma = zeros(Nsub*5,3);
    X_intnma(:,1) = vertcat(peak_int.(elec){2,2},peak_int.(elec){3,2},peak_int.(elec){4,2},peak_int.(elec){5,2},peak_int.(elec){6,2}); % peak data
    X_intnma(:,2) = vertcat(ones(Nsub,1), ones(Nsub,1)*2, ones(Nsub,1)*3, ones(Nsub,1)*4, ones(Nsub,1)*5); % condition
    X_intnma(:,3) = [1:Nsub,1:Nsub,1:Nsub,1:Nsub,1:Nsub]; % subjects
    
    disp(elec)
    disp('Anova N1 intensities MA')
    RMAOV1(X_intnma)

    [peak_int.(elec){7,1:4}] = deal('Anova N1','df','F','p');


    % A-only
    X_intna = zeros(Nsub*5,3);
    X_intna(:,1) = vertcat(peak_int.(elec){2,13},peak_int.(elec){3,13},peak_int.(elec){4,13},peak_int.(elec){5,13},peak_int.(elec){6,13}); % peak data
    X_intna(:,2) = vertcat(ones(Nsub,1), ones(Nsub,1)*2, ones(Nsub,1)*3, ones(Nsub,1)*4, ones(Nsub,1)*5); % condition
    X_intna(:,3) = [1:Nsub,1:Nsub,1:Nsub,1:Nsub,1:Nsub]; % subjects

    disp('Anova N1 intensities A')
    RMAOV1(X_intna)

    [peak_int.(elec){7,12:15}] = deal('Anova N1','df','F','p');


    % P2, MA
    X_intpma = zeros(Nsub*5,3);
    X_intpma(:,1) = vertcat(peak_int.(elec){2,3},peak_int.(elec){3,3},peak_int.(elec){4,3},peak_int.(elec){5,3},peak_int.(elec){6,3}); % peak data
    X_intpma(:,2) = vertcat(ones(Nsub,1), ones(Nsub,1)*2, ones(Nsub,1)*3, ones(Nsub,1)*4, ones(Nsub,1)*5); % condition
    X_intpma(:,3) = [1:Nsub,1:Nsub,1:Nsub,1:Nsub,1:Nsub]; % subjects

    disp('Anova P2 intensities MA')
    RMAOV1(X_intpma)

    [peak_int.(elec){11,1:4}] = deal('Anova P2','df','F','p');

    % A-only
    X_intpa = zeros(Nsub*5,3);
    X_intpa(:,1) = vertcat(peak_int.(elec){2,14},peak_int.(elec){3,14},peak_int.(elec){4,14},peak_int.(elec){5,14},peak_int.(elec){6,14}); % peak data
    X_intpa(:,2) = vertcat(ones(Nsub,1), ones(Nsub,1)*2, ones(Nsub,1)*3, ones(Nsub,1)*4, ones(Nsub,1)*5); % condition
    X_intpa(:,3) = [1:Nsub,1:Nsub,1:Nsub,1:Nsub,1:Nsub]; % subjects

    disp('Anova P2 intensities A')
    RMAOV1(X_intpa)

    [peak_int.(elec){11,12:15}] = deal('Anova P2','df','F','p');


    % ttest
    [peak_int.(elec){9,1:11}] = deal('t-test', 'p 72/73','p 72/74','p 72/75','p 72/76','p 73/74','p 73/75','p 73/76','p 74/75','p 74/76','p 75/76');
    [peak_int.(elec){13,1:11}] = deal('t-test', 'p 72/73','p 72/74','p 72/75','p 72/76','p 73/74','p 73/75','p 73/76','p 74/75','p 74/76','p 75/76');
    [peak_int.(elec){9,12:22}] = deal('t-test', 'p 72/73','p 72/74','p 72/75','p 72/76','p 73/74','p 73/75','p 73/76','p 74/75','p 74/76','p 75/76');
    [peak_int.(elec){13,12:22}] = deal('t-test', 'p 72/73','p 72/74','p 72/75','p 72/76','p 73/74','p 73/75','p 73/76','p 74/75','p 74/76','p 75/76');
    
    intcomb = [2,3;2,4;2,5;2,6;3,4;3,5;3,6;4,5;4,6;5,6];
    for c = 1:size(intcomb,1)
        [~,peak_int.(elec){10,c+1}] = ttest(peak_int.(elec){intcomb(c,1),2},peak_int.(elec){intcomb(c,2),2});
        [~,peak_int.(elec){14,c+1}] = ttest(peak_int.(elec){intcomb(c,1),3},peak_int.(elec){intcomb(c,2),3});
        [~,peak_int.(elec){10,c+12}] = ttest(peak_int.(elec){intcomb(c,1),13},peak_int.(elec){intcomb(c,2),13});
        [~,peak_int.(elec){14,c+12}] = ttest(peak_int.(elec){intcomb(c,1),14},peak_int.(elec){intcomb(c,2),14});
    end

    peak_int.(elec){16,1} = 'SM ';
    peak_int.(elec){16,12} = 'SM ';
    for sb = 1:Nsub
        peak_int.(elec){16,2}(sb) = mean([peak_int.(elec){2,2}(sb),peak_int.(elec){3,2}(sb),peak_int.(elec){4,2}(sb),peak_int.(elec){5,2}(sb),peak_int.(elec){6,2}(sb)]);
        peak_int.(elec){16,3}(sb) = mean([peak_int.(elec){2,3}(sb),peak_int.(elec){3,3}(sb),peak_int.(elec){4,3}(sb),peak_int.(elec){5,3}(sb),peak_int.(elec){6,3}(sb)]);
    
        peak_int.(elec){16,13}(sb) = mean([peak_int.(elec){2,13}(sb),peak_int.(elec){3,13}(sb),peak_int.(elec){4,13}(sb),peak_int.(elec){5,13}(sb),peak_int.(elec){6,13}(sb)]);
        peak_int.(elec){16,14}(sb) = mean([peak_int.(elec){2,14}(sb),peak_int.(elec){3,14}(sb),peak_int.(elec){4,14}(sb),peak_int.(elec){5,14}(sb),peak_int.(elec){6,14}(sb)]);
    end

    peak_int.(elec){17,1} = 'GM';
    [peak_int.(elec){17,2:3}] = deal(mean(peak_int.(elec){16,2}),mean(peak_int.(elec){16,3}));
    peak_int.(elec){17,12} = 'GM';
    [peak_int.(elec){17,13:14}] = deal(mean(peak_int.(elec){16,13}),mean(peak_int.(elec){16,14}));

    peak_int.(elec){18,1} = 'SM-GM';
    peak_int.(elec){18,2} = peak_int.(elec){16,2} - peak_int.(elec){17,2};
    peak_int.(elec){18,3} = peak_int.(elec){16,3} - peak_int.(elec){17,3};
    peak_int.(elec){18,12} = 'SM-GM';
    peak_int.(elec){18,13} = peak_int.(elec){16,13} - peak_int.(elec){17,13};
    peak_int.(elec){18,14} = peak_int.(elec){16,14} - peak_int.(elec){17,14};

    [peak_int.(elec){20:24,1}] = deal('72 corr','73 corr','74 corr','75 corr','76 corr');
    [peak_int.(elec){20:24,12}] = deal('72 corr','73 corr','74 corr','75 corr','76 corr');
    % mean, sem
    [peak_int.(elec){26:31,1}] = deal('mean','72 corr','73 corr','74 corr','75 corr','76 corr');
    [peak_int.(elec){32:37,1}] = deal('SE','72 corr','73 corr','74 corr','75 corr','76 corr');
    [peak_int.(elec){26:31,12}] = deal('mean','72 corr','73 corr','74 corr','75 corr','76 corr');
    [peak_int.(elec){32:37,12}] = deal('SE','72 corr','73 corr','74 corr','75 corr','76 corr');

    for c = 1:5
        [peak_int.(elec){c+19,2:3}] = deal(peak_int.(elec){c+1,2}-peak_int.(elec){18,2}', peak_int.(elec){c+1,3}-peak_int.(elec){18,3}');
        [peak_int.(elec){c+26,2:3}] = deal(mean(peak_int.(elec){c+19,2}),mean(peak_int.(elec){c+19,3}));
        [peak_int.(elec){c+32,2:3}] = deal(std(peak_int.(elec){c+19,2})/sqrt(Nsub), std(peak_int.(elec){c+19,3})/sqrt(Nsub));
        
        [peak_int.(elec){c+19,13:14}] = deal(peak_int.(elec){c+1,13}-peak_int.(elec){18,13}', peak_int.(elec){c+1,14}-peak_int.(elec){18,14}');
        [peak_int.(elec){c+26,13:14}] = deal(mean(peak_int.(elec){c+19,13}),mean(peak_int.(elec){c+19,14}));
        [peak_int.(elec){c+32,13:14}] = deal(std(peak_int.(elec){c+19,13})/sqrt(Nsub), std(peak_int.(elec){c+19,14})/sqrt(Nsub));
    end
end

[peak_int.FCz{8,2:4}] = deal([4,64],0.119, 0.9754); % MA N1
[peak_int.FCz{8,13:15}] = deal([4,64],0.623, 0.6478); % A N1
[peak_int.FCz{12,2:4}] = deal([4,64],2.583, 0.0453); % MA P2
[peak_int.FCz{12,13:15}] = deal([4,64],0.284, 0.8875); % A P2

[peak_int.Fz{8,2:4}] = deal([4,64],0.303, 0.8752); % MA N1
[peak_int.Fz{8,13:15}] = deal([4,64],0.257, 0.9042); % A N1
[peak_int.Fz{12,2:4}] = deal([4,64],2.312, 0.0671); % MA P2
[peak_int.Fz{12,13:15}] = deal([4,64],0.218, 0.9277); % A P2

[peak_int.Cz{8,2:4}] = deal([4,64],0.450, 0.7718); % MA N1
[peak_int.Cz{8,13:15}] = deal([4,64],0.925, 0.4549); % A N1
[peak_int.Cz{12,2:4}] = deal([4,64],2.690, 0.0388); % MA P2
[peak_int.Cz{12,13:15}] = deal([4,64],0.297, 0.8792); % A P2

% [peak_int.M1{8,2:4}] = deal([4,52],0.235, 0.9177); % MA N1
% [peak_int.M1{8,13:15}] = deal([4,52],0.985, 0.4238); % A N1
% [peak_int.M1{12,2:4}] = deal([4,52],1.205, 0.3200); % MA P2
% [peak_int.M1{12,13:15}] = deal([4,52],1.406, 0.2451); % A P2

% linear regression
for el = 1:length(channel)
    elec = EEG_data{4,2}.EEG.chanlocs(channel(el)).labels
    
    x = [];
    y = []; % responses = P2
    for sb = 1:Nsub
        y = vertcat(y,[peak_int.(elec){20,2}(sb);peak_int.(elec){21,2}(sb);peak_int.(elec){22,2}(sb);peak_int.(elec){23,2}(sb);peak_int.(elec){24,2}(sb)]);
        x = vertcat(x,[(1:5)',ones(5,1)]);
    end
    [~,~,~,~,stats] = regress(y,x)

    [peak_int.(elec){39,1:5}] = deal('lin reg', 'R²', 'F', 'p', 'err var');
    [peak_int.(elec){40,2:5}] = deal(stats(1),stats(2),stats(3),stats(4));


    %%%% SPSS export
    % rows = subjects, column = SOA (erst N1, dann P2), value = PSE
    dbpeakMA = [peak_int.(elec){2,2},peak_int.(elec){3,2},peak_int.(elec){4,2},peak_int.(elec){5,2},peak_int.(elec){6,2},...
        peak_int.(elec){2,3},peak_int.(elec){3,3},peak_int.(elec){4,3},peak_int.(elec){5,3},peak_int.(elec){6,3}];
    varnames={'N72','N73','N74','N75','N76','P72','P73','P74','P75','P76'};
    save4spss(dbpeakMA,varnames,['dBvsP2_MA_' elec '.dat'])

    dbpeakA = [peak_int.(elec){2,13},peak_int.(elec){3,13},peak_int.(elec){4,13},peak_int.(elec){5,13},peak_int.(elec){6,13},...
        peak_int.(elec){2,14},peak_int.(elec){3,14},peak_int.(elec){4,14},peak_int.(elec){5,14},peak_int.(elec){6,14}];
    varnames={'N72','N73','N74','N75','N76','P72','P73','P74','P75','P76'};
    save4spss(dbpeakA,varnames,['dBvsP2_A_' elec '.dat'])
end



% figure
int_pos = [1,3,5,7,9];

% FCz
figure('Position', [150,100, 1200, 600])
subplot(2,2,1) % MA N1 peak
hold on
for c=1:5
    fill([int_pos(c)-0.5,int_pos(c)+0.5,int_pos(c)+0.5,int_pos(c)-0.5],...
        [peak_int.FCz{c+26,2}-peak_int.FCz{c+32,2},peak_int.FCz{c+26,2}-peak_int.FCz{c+32,2},peak_int.FCz{c+26,2}+peak_int.FCz{c+32,2},peak_int.FCz{c+26,2}+peak_int.FCz{c+32,2}], ...
        [128/255, 201/255, 255/255], 'FaceAlpha', 0.3,'EdgeColor', 'none')
    plot([int_pos(c)-0.5,int_pos(c)+0.5], [peak_int.FCz{c+26,2},peak_int.FCz{c+26,2}],'k')
end
title('FCz | motor-auditory | N1')
ylim([-10,-5])
xticks([1,3,5,7,9])
xticklabels({'72','73','74','75','76'})
ylabel('mean peak [µV]')
xlabel('intensity [dB SPL]')

subplot(2,2,2) % MA P2 peak
hold on
for c=1:5
    fill([int_pos(c)-0.5,int_pos(c)+0.5,int_pos(c)+0.5,int_pos(c)-0.5],...
        [peak_int.FCz{c+26,3}-peak_int.FCz{c+32,3},peak_int.FCz{c+26,3}-peak_int.FCz{c+32,3},peak_int.FCz{c+26,3}+peak_int.FCz{c+32,3},peak_int.FCz{c+26,3}+peak_int.FCz{c+32,3}],...
        [128/255, 201/255, 255/255], 'FaceAlpha', 0.3, 'EdgeColor', 'none')
    plot([int_pos(c)-0.5,int_pos(c)+0.5], [peak_int.FCz{c+26,3},peak_int.FCz{c+26,3}],'k')
end
% % Signifikanz
% % 72 vs. 73
% plot([1 3], [6.1 6.1], 'k')
% plot([1 1], [5.9 6.1], 'k')
% plot([3 3], [5.9 6.1], 'k')
% text(2,6.3,{'**'},'Color','r','LineWidth',1)
% % 73 vs. 76
% plot([3 9], [7.2 7.2], 'k')
% plot([3 3], [7 7.2], 'k')
% plot([9 9], [7 7.2], 'k')
% text(6, 7.4, {'*'}, 'Color','r', 'LineWidth', 1)
% % 74 vs. 76
% plot([5 9], [6.1 6.1], 'k')
% plot([5 5], [5.9 6.1], 'k')
% plot([9 9], [5.9 6.1], 'k')
% text(7,6.3,{'*'},'Color','r','LineWidth',1)

title('FCz | motor-auditory |P2')
ylim([2 10])
xticks([1,3,5,7,9])
xticklabels({'72','73','74','75','76'})
ylabel('mean peak [µV]')
xlabel('intensity [dB SPL]')

subplot(2,2,3) % A N1 peak
hold on
for c=1:5
    fill([int_pos(c)-0.5,int_pos(c)+0.5,int_pos(c)+0.5,int_pos(c)-0.5],...
        [peak_int.FCz{c+26,13}-peak_int.FCz{c+32,13},peak_int.FCz{c+26,13}-peak_int.FCz{c+32,13},peak_int.FCz{c+26,13}+peak_int.FCz{c+32,13},peak_int.FCz{c+26,13}+peak_int.FCz{c+32,13}], ...
        [128/255, 201/255, 255/255], 'FaceAlpha', 0.3, 'EdgeColor', 'none')
    plot([int_pos(c)-0.5,int_pos(c)+0.5], [peak_int.FCz{c+26,13},peak_int.FCz{c+26,13}],'k')
end
title('FCz | auditory-only | N1')
ylim([-10,-5])
xticks([1,3,5,7,9])
xticklabels({'72','73','74','75','76'})
ylabel('mean peak [µV]')
xlabel('intensity [dB SPL]')

subplot(2,2,4) % A P2 peak
hold on
for c=1:5
    fill([int_pos(c)-0.5,int_pos(c)+0.5,int_pos(c)+0.5,int_pos(c)-0.5],...
        [peak_int.FCz{c+26,14}-peak_int.FCz{c+32,14},peak_int.FCz{c+26,14}-peak_int.FCz{c+32,14},peak_int.FCz{c+26,14}+peak_int.FCz{c+32,14},peak_int.FCz{c+26,14}+peak_int.FCz{c+32,14}],...
        [128/255, 201/255, 255/255], 'FaceAlpha', 0.3, 'EdgeColor', 'none')
    plot([int_pos(c)-0.5,int_pos(c)+0.5], [peak_int.FCz{c+26,14},peak_int.FCz{c+26,14}],'k')
end
title('FCz | auditory-only | P2')
ylim([2 10])
xticks([1,3,5,7,9])
xticklabels({'72','73','74','75','76'})
ylabel('mean peak [µV]')
xlabel('intensity [dB SPL]')

%cd('../Figures')
saveas(gcf, '2T_FCz_NPpeak.png')

% Fz
figure('Position', [150,100, 1200, 600])
subplot(2,2,1) % MA N1 peak
hold on
for c=1:5
    fill([int_pos(c)-0.5,int_pos(c)+0.5,int_pos(c)+0.5,int_pos(c)-0.5],...
        [peak_int.Fz{c+26,2}-peak_int.Fz{c+32,2},peak_int.Fz{c+26,2}-peak_int.Fz{c+32,2},peak_int.Fz{c+26,2}+peak_int.Fz{c+32,2},peak_int.Fz{c+26,2}+peak_int.Fz{c+32,2}], ...
        [128/255, 201/255, 255/255], 'FaceAlpha', 0.3,'EdgeColor', 'none')
    plot([int_pos(c)-0.5,int_pos(c)+0.5], [peak_int.Fz{c+26,2},peak_int.Fz{c+26,2}],'k')
end
% Signifikanzen
% % 72 vs. 75
% plot([1 7], [-6 -6], 'k')
% plot([1 1], [-6 -6.2], 'k')
% plot([7 7], [-6 -6.2], 'k')
% text(4,-5.8,{'*'}, 'Color', 'r', 'LineWidth', 1)

title('Fz | motor-auditory | N1')
ylim([-10,-5])
xticks([1,3,5,7,9])
xticklabels({'72','73','74','75','76'})
ylabel('mean peak [µV]')
xlabel('intensity [dB SPL]')

subplot(2,2,2) % MA P2 peak
hold on
for c=1:5
    fill([int_pos(c)-0.5,int_pos(c)+0.5,int_pos(c)+0.5,int_pos(c)-0.5],[peak_int.Fz{c+26,3}-peak_int.Fz{c+32,3},peak_int.Fz{c+26,3}-peak_int.Fz{c+32,3},peak_int.Fz{c+26,3}+peak_int.Fz{c+32,3},peak_int.Fz{c+26,3}+peak_int.Fz{c+32,3}],...
        [128/255, 201/255, 255/255], 'FaceAlpha', 0.3, 'EdgeColor', 'none')
    plot([int_pos(c)-0.5,int_pos(c)+0.5], [peak_int.Fz{c+26,3},peak_int.Fz{c+26,3}],'k')
end
% % Signifikanz
% % 72 vs. 73
% plot([1 3], [5.5 5.5], 'k')
% plot([1 1], [5.0 5.5], 'k')
% plot([3 3], [5.0 5.5], 'k')
% text(2,5.8,{'**'},'Color','r','LineWidth',1)
% % 72 vs. 74
% plot([1 5], [6.5 6.5], 'k')
% plot([1 1], [6.0 6.5], 'k')
% plot([5 5], [6.0 6.5], 'k')
% text(3,6.8,{'*'},'Color','r','LineWidth',1)
% % % 72 vs. 75
% % plot([1 7], [7.5 7.5], 'k')
% % plot([1 1], [7.0 7.5], 'k')
% % plot([7 7], [7.0 7.5], 'k')
% % text(4, 7.8, {'***'}, 'Color','r', 'LineWidth', 1)
% % % 72 vs. 76
% % plot([1 9], [8.5 8.5], 'k')
% % plot([1 1], [8.0 8.5], 'k')
% % plot([9 9], [8.0 8.5], 'k')
% % text(5,8.8,{'*'},'Color','r','LineWidth',1)

title('Fz | motor-auditory |P2')
ylim([0 10])
xlim([0 10])
xticks([1,3,5,7,9])
xticklabels({'72','73','74','75','76'})
ylabel('mean peak [µV]')
xlabel('intensity [dB SPL]')

subplot(2,2,3) % A N1 peak
hold on
for c=1:5
    fill([int_pos(c)-0.5,int_pos(c)+0.5,int_pos(c)+0.5,int_pos(c)-0.5],...
        [peak_int.Fz{c+26,13}-peak_int.Fz{c+32,13},peak_int.Fz{c+26,13}-peak_int.Fz{c+32,13},peak_int.Fz{c+26,13}+peak_int.Fz{c+32,13},peak_int.Fz{c+26,13}+peak_int.Fz{c+32,13}], ...
        [128/255, 201/255, 255/255], 'FaceAlpha', 0.3, 'EdgeColor', 'none')
    plot([int_pos(c)-0.5,int_pos(c)+0.5], [peak_int.Fz{c+26,13},peak_int.Fz{c+26,13}],'k')
end
title('Fz | auditory-only | N1')
ylim([-10,-5])
xticks([1,3,5,7,9])
xticklabels({'72','73','74','75','76'})
ylabel('mean peak [µV]')
xlabel('intensity [dB SPL]')

subplot(2,2,4) % A P2 peak
hold on
for c=1:5
    fill([int_pos(c)-0.5,int_pos(c)+0.5,int_pos(c)+0.5,int_pos(c)-0.5],...
        [peak_int.Fz{c+26,14}-peak_int.Fz{c+32,14},peak_int.Fz{c+26,14}-peak_int.Fz{c+32,14},peak_int.Fz{c+26,14}+peak_int.Fz{c+32,14},peak_int.Fz{c+26,14}+peak_int.Fz{c+32,14}],...
        [128/255, 201/255, 255/255], 'FaceAlpha', 0.3, 'EdgeColor', 'none')
    plot([int_pos(c)-0.5,int_pos(c)+0.5], [peak_int.Fz{c+26,14},peak_int.Fz{c+26,14}],'k')
end
title('Fz | auditory-only | P2')
ylim([2 10])
xticks([1,3,5,7,9])
xticklabels({'72','73','74','75','76'})
ylabel('mean peak [µV]')
xlabel('intensity [dB SPL]')

%cd('../Figures')
saveas(gcf, '2T_Fz_NPpeak.png')

% Cz
figure('Position', [150,100, 1200, 600])
subplot(2,2,1) % MA N1 peak
hold on
for c=1:5
    fill([int_pos(c)-0.5,int_pos(c)+0.5,int_pos(c)+0.5,int_pos(c)-0.5],...
        [peak_int.Cz{c+26,2}-peak_int.Cz{c+32,2},peak_int.Cz{c+26,2}-peak_int.Cz{c+32,2},peak_int.Cz{c+26,2}+peak_int.Cz{c+32,2},peak_int.Cz{c+26,2}+peak_int.Cz{c+32,2}], ...
        [128/255, 201/255, 255/255], 'FaceAlpha', 0.3,'EdgeColor', 'none')
    plot([int_pos(c)-0.5,int_pos(c)+0.5], [peak_int.Cz{c+26,2},peak_int.Cz{c+26,2}],'k')
end
% Signifikanzen


title('Cz | motor-auditory | N1')
ylim([-10,-5])
xticks([1,3,5,7,9])
xticklabels({'72','73','74','75','76'})
ylabel('mean peak [µV]')
xlabel('intensity [dB SPL]')

subplot(2,2,2) % MA P2 peak
hold on
for c=1:5
    fill([int_pos(c)-0.5,int_pos(c)+0.5,int_pos(c)+0.5,int_pos(c)-0.5],...
        [peak_int.Cz{c+26,3}-peak_int.Cz{c+32,3},peak_int.Cz{c+26,3}-peak_int.Cz{c+32,3},peak_int.Cz{c+26,3}+peak_int.Cz{c+32,3},peak_int.Cz{c+26,3}+peak_int.Cz{c+32,3}],...
        [128/255, 201/255, 255/255], 'FaceAlpha', 0.3, 'EdgeColor', 'none')
    plot([int_pos(c)-0.5,int_pos(c)+0.5], [peak_int.Cz{c+26,3},peak_int.Cz{c+26,3}],'k')
end
% % Signifikanz
% % 72 vs. 73
% plot([1 2.9], [8.0 8.0], 'k')
% plot([1 1], [7.5 8.0], 'k')
% plot([2.9 2.9], [7.5 8.0], 'k')
% text(2,8.3,{'*'},'Color','r','LineWidth',1)
% % % 72 vs. 75
% % plot([1 7], [9.0 9.0], 'k')
% % plot([1 1], [8.5 9.0], 'k')
% % plot([7 7], [8.5 9.0], 'k')
% % text(4, 9.3, {'***'}, 'Color','r', 'LineWidth', 1)
% % 73 vs. 76
% plot([3.1 9], [8.0 8.0], 'k')
% plot([3.1 3.1], [7.5 8.0], 'k')
% plot([9 9], [7.5 8.0], 'k')
% text(6,8.3,{'*'},'Color','r','LineWidth',1)

title('Cz | motor-auditory |P2')
ylim([2 10])
xticks([1,3,5,7,9])
xticklabels({'72','73','74','75','76'})
ylabel('mean peak [µV]')
xlabel('intensity [dB SPL]')

subplot(2,2,3) % A N1 peak
hold on
for c=1:5
    fill([int_pos(c)-0.5,int_pos(c)+0.5,int_pos(c)+0.5,int_pos(c)-0.5],...
        [peak_int.Cz{c+26,13}-peak_int.Cz{c+32,13},peak_int.Cz{c+26,13}-peak_int.Cz{c+32,13},peak_int.Cz{c+26,13}+peak_int.Cz{c+32,13},peak_int.Cz{c+26,13}+peak_int.Cz{c+32,13}], ...
        [128/255, 201/255, 255/255], 'FaceAlpha', 0.3, 'EdgeColor', 'none')
    plot([int_pos(c)-0.5,int_pos(c)+0.5], [peak_int.Cz{c+26,13},peak_int.Cz{c+26,13}],'k')
end
title('Cz | auditory-only | N1')
ylim([-10,-5])
xticks([1,3,5,7,9])
xticklabels({'72','73','74','75','76'})
ylabel('mean peak [µV]')
xlabel('intensity [dB SPL]')

subplot(2,2,4) % A P2 peak
hold on
for c=1:5
    fill([int_pos(c)-0.5,int_pos(c)+0.5,int_pos(c)+0.5,int_pos(c)-0.5],...
        [peak_int.Cz{c+26,14}-peak_int.Cz{c+32,14},peak_int.Cz{c+26,14}-peak_int.Cz{c+32,14},peak_int.Cz{c+26,14}+peak_int.Cz{c+32,14},peak_int.Cz{c+26,14}+peak_int.Cz{c+32,14}],...
        [128/255, 201/255, 255/255], 'FaceAlpha', 0.3, 'EdgeColor', 'none')
    plot([int_pos(c)-0.5,int_pos(c)+0.5], [peak_int.Cz{c+26,14},peak_int.Cz{c+26,14}],'k')
end
title('Cz | auditory-only | P2')
ylim([2 10])
xticks([1,3,5,7,9])
xticklabels({'72','73','74','75','76'})
ylabel('mean peak [µV]')
xlabel('intensity [dB SPL]')

%cd('../Figures')
saveas(gcf, '2T_Cz_NPpeak.png')
cd('../EEG')

% figure 2: ERP form
% - 2 subplots: oben MA, unten A
% - pro subplot: 5 Lautstärken
% - wenn Anova signifikant dann Hintermalung N1, P2
% - separat für Elektroden
channel = [21, 5, 14];
for el = 1:3
    elec = EEG_data{3,2}.EEG.chanlocs(channel(el)).labels

    % corrected mean, sem
    clear sm gm smgm ma a
    for sb = 1:Nsub
        sm.ma(sb,1:801) = mean([scd_tone{6,sb+1}{2,el+1}(end,:);scd_tone{6,sb+1}{3,el+1}(end,:);...
            scd_tone{6,sb+1}{4,el+1}(end,:);scd_tone{6,sb+1}{5,el+1}(end,:);scd_tone{6,sb+1}{6,el+1}(end,:)],1);
        sm.a(sb,1:801) = mean([scd_tone{4,sb+1}{2,el+1}(end,:);scd_tone{4,sb+1}{3,el+1}(end,:);...
            scd_tone{4,sb+1}{4,el+1}(end,:);scd_tone{4,sb+1}{5,el+1}(end,:);scd_tone{4,sb+1}{6,el+1}(end,:)],1);
    end
    gm.ma = mean(sm.ma,1);
    gm.a = mean(sm.a,1);
    smgm.ma = sm.ma - gm.ma;
    smgm.a = sm.a - gm.a;
    for ld = 1:length(loud)
        for sb = 1:Nsub
            % corrected values
            ma.(['L' num2str(loud(ld))]).corr(sb,:) = scd_tone{6,sb+1}{ld+1,el+1}(end,:) - smgm.ma(sb,:);
            a.(['L' num2str(loud(ld))]).corr(sb,:) = scd_tone{4,sb+1}{ld+1,el+1}(end,:) - smgm.a(sb,:);
        end
        % loudness mean, sem
        ma.(['L' num2str(loud(ld))]).mean = mean(ma.(['L' num2str(loud(ld))]).corr,1);
        ma.(['L' num2str(loud(ld))]).sem = std(ma.(['L' num2str(loud(ld))]).corr,1)/sqrt(Nsub);
        a.(['L' num2str(loud(ld))]).mean = mean(a.(['L' num2str(loud(ld))]).corr,1);
        a.(['L' num2str(loud(ld))]).sem = std(a.(['L' num2str(loud(ld))]).corr,1)/sqrt(Nsub);
    end
    
    col = 'yrmbg';
    figure('Position',[200, 110, 800, 640])
    subplot(2,1,1) % MA
    hold on
    plot([-200 400], [0 0], 'Color', [153/255, 153/255, 153/255])
    plot([0 0], [-15 15], 'Color', [153/255, 153/255, 153/255])

    % Signifikanz
    if peak_int.(elec){8,4} <= 0.05
        fill([peaks{11,3}-20,peaks{11,3}+20,peaks{11,3}+20,peaks{11,3}-20],[-15 -15 15 15], [180/255, 180/255, 180/255],'EdgeColor','none','FaceAlpha',0.3)
    end
    if peak_int.(elec){12,4} <= 0.05
        fill([peaks{12,3}-20,peaks{12,3}+20,peaks{12,3}+20,peaks{12,3}-20],[-15 -15 15 15], [180/255, 180/255, 180/255],'EdgeColor','none','FaceAlpha',0.3)
    end
    
    for ld = 1:length(loud)
        fill([EEG_data{el+6,7}, EEG_data{el+6,7}(end:-1:1)], [ma.(['L' num2str(loud(ld))]).mean - ma.(['L' num2str(loud(ld))]).sem, flip(ma.(['L' num2str(loud(ld))]).mean + ma.(['L' num2str(loud(ld))]).sem)],col(ld),'EdgeColor','none','FaceAlpha',0.3)
        p(ld) = plot(EEG_data{el+6,7}, ma.(['L' num2str(loud(ld))]).mean, col(ld),'LineWidth',1)
    end

    ylim([-15 15])
    xlim([-200 400])
    ylabel('mean amplitude [µV]')
    legend(p,{'72 dB SPL', '73 dB SPL','74 dB SPL','75 dB SPL','76 dB SPL'},'Location','northwest')
    title([elec ' | Motor-Auditory condition'])
    
    subplot(2,1,2) % A
    hold on
    plot([-200 400], [0 0], 'Color', [153/255, 153/255, 153/255])
    plot([0 0], [-15 15], 'Color', [153/255, 153/255, 153/255])

    % Signifikanz
    if peak_int.(elec){8,15} <= 0.05
        fill([peaks{11,3}-20,peaks{11,3}+20,peaks{11,3}+20,peaks{11,3}-20],[-15 -15 15 15], [180/255, 180/255, 180/255],'EdgeColor','none','FaceAlpha',0.3)
    end
    if peak_int.(elec){12,15} <= 0.05
        fill([peaks{12,3}-20,peaks{12,3}+20,peaks{12,3}+20,peaks{12,3}-20],[-15 -15 15 15], [180/255, 180/255, 180/255],'EdgeColor','none','FaceAlpha',0.3)
    end
    
    for ld = 1:length(loud)
        fill([EEG_data{el+6,7}, EEG_data{el+6,7}(end:-1:1)], [a.(['L' num2str(loud(ld))]).mean - a.(['L' num2str(loud(ld))]).sem, flip(a.(['L' num2str(loud(ld))]).mean + a.(['L' num2str(loud(ld))]).sem)],col(ld),'EdgeColor','none','FaceAlpha',0.3)
        p(ld) = plot(EEG_data{el+6,7}, a.(['L' num2str(loud(ld))]).mean, col(ld),'LineWidth',1);
    end

    ylim([-15 15])
    xlim([-200 400])
    ylabel('mean amplitude [µV]')
    xlabel('time relative to tone onset [ms]')
    %legend(p,{'72 dB SPL', '73 dB SPL','74 dB SPL','75 dB SPL','76 dB SPL'},'Location','northwest')
    title([elec ' | Auditory-Only condition'])
    
    %cd('../Figures')
    saveas(gcf, ['2T_' elec '.png'])
end

cd('../EEG')


% % M1
% figure('Position', [150,100, 1200, 600])
% subplot(2,2,1) % MA N1 peak
% hold on
% for c=1:5
%     fill([int_pos(c)-0.5,int_pos(c)+0.5,int_pos(c)+0.5,int_pos(c)-0.5],...
%         [peak_int.M1{c+26,2}-peak_int.M1{c+32,2},peak_int.M1{c+26,2}-peak_int.M1{c+32,2},peak_int.M1{c+26,2}+peak_int.M1{c+32,2},peak_int.M1{c+26,2}+peak_int.M1{c+32,2}], ...
%         [128/255, 201/255, 255/255], 'FaceAlpha', 0.3,'EdgeColor', 'none')
%     plot([int_pos(c)-0.5,int_pos(c)+0.5], [peak_int.M1{c+26,2},peak_int.M1{c+26,2}],'k')
% end
% % Signifikanzen
% 
% title('M1 | motor-auditory | N1')
% ylim([-5 0])
% xticks([1,3,5,7,9])
% xticklabels({'72','73','74','75','76'})
% ylabel('mean peak [µV]')
% xlabel('intensity [dB SPL]')
% 
% subplot(2,2,2) % MA P2 peak
% hold on
% for c=1:5
%     fill([int_pos(c)-0.5,int_pos(c)+0.5,int_pos(c)+0.5,int_pos(c)-0.5],...
%         [peak_int.M1{c+26,3}-peak_int.M1{c+32,3},peak_int.M1{c+26,3}-peak_int.M1{c+32,3},peak_int.M1{c+26,3}+peak_int.M1{c+32,3},peak_int.M1{c+26,3}+peak_int.M1{c+32,3}],...
%         [128/255, 201/255, 255/255], 'FaceAlpha', 0.3, 'EdgeColor', 'none')
%     plot([int_pos(c)-0.5,int_pos(c)+0.5], [peak_int.M1{c+26,3},peak_int.M1{c+26,3}],'k')
% end
% 
% title('M1 | motor-auditory |P2')
% ylim([0 5])
% xticks([1,3,5,7,9])
% xticklabels({'72','73','74','75','76'})
% ylabel('mean peak [µV]')
% xlabel('intensity [dB SPL]')
% 
% subplot(2,2,3) % A N1 peak
% hold on
% for c=1:5
%     fill([int_pos(c)-0.5,int_pos(c)+0.5,int_pos(c)+0.5,int_pos(c)-0.5],...
%         [peak_int.M1{c+26,13}-peak_int.M1{c+32,13},peak_int.M1{c+26,13}-peak_int.M1{c+32,13},peak_int.M1{c+26,13}+peak_int.M1{c+32,13},peak_int.M1{c+26,13}+peak_int.M1{c+32,13}], ...
%         [128/255, 201/255, 255/255], 'FaceAlpha', 0.3, 'EdgeColor', 'none')
%     plot([int_pos(c)-0.5,int_pos(c)+0.5], [peak_int.M1{c+26,13},peak_int.M1{c+26,13}],'k')
% end
% title('M1 | auditory-only | N1')
% ylim([-5, 0])
% xticks([1,3,5,7,9])
% xticklabels({'72','73','74','75','76'})
% ylabel('mean peak [µV]')
% xlabel('intensity [dB SPL]')
% 
% subplot(2,2,4) % A P2 peak
% hold on
% for c=1:5
%     fill([int_pos(c)-0.5,int_pos(c)+0.5,int_pos(c)+0.5,int_pos(c)-0.5],...
%         [peak_int.M1{c+26,14}-peak_int.M1{c+32,14},peak_int.M1{c+26,14}-peak_int.M1{c+32,14},peak_int.M1{c+26,14}+peak_int.M1{c+32,14},peak_int.M1{c+26,14}+peak_int.M1{c+32,14}],...
%         [128/255, 201/255, 255/255], 'FaceAlpha', 0.3, 'EdgeColor', 'none')
%     plot([int_pos(c)-0.5,int_pos(c)+0.5], [peak_int.M1{c+26,14},peak_int.M1{c+26,14}],'k')
% end
% title('M1 | auditory-only | P2')
% ylim([0 5])
% xticks([1,3,5,7,9])
% xticklabels({'72','73','74','75','76'})
% ylabel('mean peak [µV]')
% xlabel('intensity [dB SPL]')
% 
% cd('../Figures')
% saveas(gcf, '2T_M1_NPpeak.png')


% 1 figure for each electrode
% 2 subplots for each condition
% within subplots mean of intensity
% col = ['y','r','m','b','k'];
% for el = 1:length(channel)
%     figure('Position',  [200, 150, 800, 600])
%     subplot(2,1,1)
%     hold on
%     plot([-200 400],[0,0],'Color',[153/255, 153/255, 153/255]) % x-axis
%     plot([0 0], [-15 15], 'Color',[153/255, 153/255, 153/255]) %y-axis
%     for ld = 1:5
%         plot([scd_tone{2,2}], [scd_tone{8+ld,el+1}],'Color',col(ld))
%     end
%     ylim([-15 15])
%     xlim([-200 400])
%     ylabel('mean amplitude [µV]')
%     title([scd_tone{8,el+1} '| auditory-only'])
%     lgd=legend({'','','72','73','74','75','76'}, 'Location','northwest');
%     title(lgd,'intensity 2. tone [dB SPL]')
%     hold off
% 
%     subplot(2,1,2)
%     hold on
%     plot([-200 400],[0,0],'Color',[153/255, 153/255, 153/255]) % x-axis
%     plot([0 0], [-15 15], 'Color',[153/255, 153/255, 153/255]) %y-axis
%     for ld = 1:5
%         plot([scd_tone{2,2}], [scd_tone{15+ld,el+1}],'Color',col(ld))
%     end
%     ylim([-15 15])
%     xlim([-200 400])
%     ylabel('mean amplitude [µV]')
%     xlabel('time relative to tone onset [ms]')
%     title('motor-auditory condition')
%     hold off
%     
%     cd('../Figures')
%     saveas(gcf, ['ERP_2T_' scd_tone{8,el+1} '.png'])
% end
% cd('../EEG')
% % figure separated for subjects
% for sb = 1:Nsub
%     for el = 1:length(channel)
%         figure('Position',  [200, 150, 800, 600])
%         subplot(2,1,1)
%         hold on
%         plot([-200 400],[0,0],'Color',[153/255, 153/255, 153/255]) % x-axis
%         plot([0 0], [-15 15], 'Color',[153/255, 153/255, 153/255]) %y-axis
%         for ld = 1:5
%             plot([scd_tone{2,2}], [scd_tone{4,sb+1}{ld+1,el+1}(end,:)],'Color',col(ld))
%         end
%         ylim([-15 15])
%         xlim([-200 400])
%         ylabel('mean amplitude [µV]')
%         title([scd_tone{1,sb+1} ' | ' scd_tone{8,el+1} '| auditory-only'])
%         lgd=legend({'','','72','73','74','75','76'}, 'Location','northwest');
%         title(lgd,'intensity 2. tone [dB SPL]')
%         hold off
%     
%         subplot(2,1,2)
%         hold on
%         plot([-200 400],[0,0],'Color',[153/255, 153/255, 153/255]) % x-axis
%         plot([0 0], [-15 15], 'Color',[153/255, 153/255, 153/255]) %y-axis
%         for ld = 1:5
%             plot([scd_tone{2,2}], [scd_tone{6,sb+1}{ld+1,el+1}(end,:)],'Color',col(ld))
%         end
%         ylim([-15 15])
%         xlim([-200 400])
%         ylabel('mean amplitude [µV]')
%         xlabel('time relative to tone onset [ms]')
%         title('motor-auditory condition')
%         hold off
%         
%         cd('../Figures')
%         saveas(gcf, ['ERP_2T_' scd_tone{1,sb+1} '_' scd_tone{8,el+1} '.png'])
%     end
% end
% cd('../EEG')

%%%%% latency figure
for el = 1:3
    elec = scd_tone{8,el+1};
    clear nsm psm ngm pgm nsg psg corr72n corr72p corr73n corr73p corr74n corr74p corr75n corr75p corr76n corr76p
    % Varianzkorrektur
    for sb = 1:Nsub
        % 1. column = MA, 2. column = A
        nsm(sb,1) = mean([peak_int.(elec){2,4}(sb),peak_int.(elec){3,4}(sb),peak_int.(elec){4,4}(sb),peak_int.(elec){5,4}(sb),peak_int.(elec){6,4}(sb)]);
        nsm(sb,2) = mean([peak_int.(elec){2,15}(sb),peak_int.(elec){3,15}(sb),peak_int.(elec){4,15}(sb),peak_int.(elec){5,15}(sb),peak_int.(elec){6,15}(sb)]);
        psm(sb,1) = mean([peak_int.(elec){2,5}(sb),peak_int.(elec){3,5}(sb),peak_int.(elec){4,5}(sb),peak_int.(elec){5,5}(sb),peak_int.(elec){6,5}(sb)]);
        psm(sb,2) = mean([peak_int.(elec){2,16}(sb),peak_int.(elec){3,16}(sb),peak_int.(elec){4,16}(sb),peak_int.(elec){5,16}(sb),peak_int.(elec){6,16}(sb)]);
    end
    ngm = mean(nsm, 1);
    pgm = mean(psm, 1);

    for sb = 1:Nsub
        % SM-GM
        nsg(sb,1) = nsm(sb,1)-ngm(1);
        nsg(sb,2) = nsm(sb,2)-ngm(2);
        psg(sb,1) = psm(sb,1)-pgm(1);
        psg(sb,2) = psm(sb,2)-pgm(2);
        % corrigierte Werte
        corr72n(sb,:) = [peak_int.(elec){2,4}(sb)-nsg(sb,1), peak_int.(elec){2,15}(sb)-nsg(sb,2)];
        corr72p(sb,:) = [peak_int.(elec){2,5}(sb)-psg(sb,1), peak_int.(elec){2,16}(sb)-psg(sb,2)];
        corr73n(sb,:) = [peak_int.(elec){3,4}(sb)-nsg(sb,1), peak_int.(elec){3,15}(sb)-nsg(sb,2)];
        corr73p(sb,:) = [peak_int.(elec){3,5}(sb)-psg(sb,1), peak_int.(elec){3,16}(sb)-psg(sb,2)];
        corr74n(sb,:) = [peak_int.(elec){4,4}(sb)-nsg(sb,1), peak_int.(elec){4,15}(sb)-nsg(sb,2)];
        corr74p(sb,:) = [peak_int.(elec){4,5}(sb)-psg(sb,1), peak_int.(elec){4,16}(sb)-psg(sb,2)];
        corr75n(sb,:) = [peak_int.(elec){5,4}(sb)-nsg(sb,1), peak_int.(elec){5,15}(sb)-nsg(sb,2)];
        corr75p(sb,:) = [peak_int.(elec){5,5}(sb)-psg(sb,1), peak_int.(elec){5,16}(sb)-psg(sb,2)];
        corr76n(sb,:) = [peak_int.(elec){6,4}(sb)-nsg(sb,1), peak_int.(elec){6,15}(sb)-nsg(sb,2)];
        corr76p(sb,:) = [peak_int.(elec){6,5}(sb)-psg(sb,1), peak_int.(elec){6,16}(sb)-psg(sb,2)];
    end
    % mean + sem
    corr72n(end+1,:) = mean(corr72n,1);
    corr72n(end+1,:) = std(corr72n(1:end-1),1)/sqrt(Nsub);
    corr72p(end+1,:) = mean(corr72p,1);
    corr72p(end+1,:) = std(corr72p(1:end-1),1)/sqrt(Nsub);
    corr73n(end+1,:) = mean(corr73n,1);
    corr73n(end+1,:) = std(corr73n(1:end-1),1)/sqrt(Nsub);
    corr73p(end+1,:) = mean(corr73p,1);
    corr73p(end+1,:) = std(corr73p(1:end-1),1)/sqrt(Nsub);
    corr74n(end+1,:) = mean(corr74n,1);
    corr74n(end+1,:) = std(corr74n(1:end-1),1)/sqrt(Nsub);
    corr74p(end+1,:) = mean(corr74p,1);
    corr74p(end+1,:) = std(corr74p(1:end-1),1)/sqrt(Nsub);
    corr75n(end+1,:) = mean(corr75n,1);
    corr75n(end+1,:) = std(corr75n(1:end-1),1)/sqrt(Nsub);
    corr75p(end+1,:) = mean(corr75p,1);
    corr75p(end+1,:) = std(corr75p(1:end-1),1)/sqrt(Nsub);
    corr76n(end+1,:) = mean(corr76n,1);
    corr76n(end+1,:) = std(corr76n(1:end-1),1)/sqrt(Nsub);
    corr76p(end+1,:) = mean(corr76p,1);
    corr76p(end+1,:) = std(corr76p(1:end-1),1)/sqrt(Nsub);

    figure('Position', [200, 150, 800, 600])
    subplot(2,2,1) % MA, N1
    hold on
    fill([0.5 1.5 1.5 0.5], [corr72n(end-1,1)-corr72n(end,1), corr72n(end-1,1)-corr72n(end,1), corr72n(end-1,1)+corr72n(end,1), corr72n(end-1,1)+corr72n(end,1)], [128/255, 201/255, 255/255], 'EdgeColor', 'none', 'FaceAlpha', 0.3)
    plot([0.5 1.5], [corr72n(end-1,1), corr72n(end-1,1)], 'k', 'LineWidth', 1)
    fill([2.5 3.5 3.5 2.5], [corr73n(end-1,1)-corr73n(end,1), corr73n(end-1,1)-corr73n(end,1), corr73n(end-1,1)+corr73n(end,1), corr73n(end-1,1)+corr73n(end,1)], [128/255, 201/255, 255/255], 'EdgeColor', 'none', 'FaceAlpha', 0.3)
    plot([2.5 3.5], [corr73n(end-1,1), corr73n(end-1,1)], 'k', 'LineWidth', 1)
    fill([4.5 5.5 5.5 4.5], [corr74n(end-1,1)-corr74n(end,1), corr74n(end-1,1)-corr74n(end,1), corr74n(end-1,1)+corr74n(end,1), corr74n(end-1,1)+corr74n(end,1)], [128/255, 201/255, 255/255], 'EdgeColor', 'none', 'FaceAlpha', 0.3)
    plot([4.5 5.5], [corr74n(end-1,1), corr74n(end-1,1)], 'k', 'LineWidth', 1)
    fill([6.5 7.5 7.5 6.5], [corr75n(end-1,1)-corr75n(end,1), corr75n(end-1,1)-corr75n(end,1), corr75n(end-1,1)+corr75n(end,1), corr75n(end-1,1)+corr75n(end,1)], [128/255, 201/255, 255/255], 'EdgeColor', 'none', 'FaceAlpha', 0.3)
    plot([6.5 7.5], [corr75n(end-1,1), corr75n(end-1,1)], 'k', 'LineWidth', 1)
    fill([8.5 9.5 9.5 8.5], [corr76n(end-1,1)-corr76n(end,1), corr76n(end-1,1)-corr76n(end,1), corr76n(end-1,1)+corr76n(end,1), corr76n(end-1,1)+corr76n(end,1)], [128/255, 201/255, 255/255], 'EdgeColor', 'none', 'FaceAlpha', 0.3)
    plot([8.5 9.5], [corr76n(end-1,1), corr76n(end-1,1)], 'k', 'LineWidth', 1)

    ylim([260 280])
    xticks([1:2:9])
    xticklabels({'72dB','73dB','74dB','75dB','76dB'})
    ylabel('mean latency [ms]')
    title([elec ' | MA | N1'])

    subplot(2,2,2) % MA, P2
    hold on
    fill([0.5 1.5 1.5 0.5], [corr72p(end-1,1)-corr72p(end,1), corr72p(end-1,1)-corr72p(end,1), corr72p(end-1,1)+corr72p(end,1), corr72p(end-1,1)+corr72p(end,1)], [128/255, 201/255, 255/255], 'EdgeColor', 'none', 'FaceAlpha', 0.3)
    plot([0.5 1.5], [corr72p(end-1,1), corr72p(end-1,1)], 'k', 'LineWidth', 1)
    fill([2.5 3.5 3.5 2.5], [corr73p(end-1,1)-corr73p(end,1), corr73p(end-1,1)-corr73p(end,1), corr73p(end-1,1)+corr73p(end,1), corr73p(end-1,1)+corr73p(end,1)], [128/255, 201/255, 255/255], 'EdgeColor', 'none', 'FaceAlpha', 0.3)
    plot([2.5 3.5], [corr73p(end-1,1), corr73p(end-1,1)], 'k', 'LineWidth', 1)
    fill([4.5 5.5 5.5 4.5], [corr74p(end-1,1)-corr74p(end,1), corr74p(end-1,1)-corr74p(end,1), corr74p(end-1,1)+corr74p(end,1), corr74p(end-1,1)+corr74p(end,1)], [128/255, 201/255, 255/255], 'EdgeColor', 'none', 'FaceAlpha', 0.3)
    plot([4.5 5.5], [corr74p(end-1,1), corr74p(end-1,1)], 'k', 'LineWidth', 1)
    fill([6.5 7.5 7.5 6.5], [corr75p(end-1,1)-corr75p(end,1), corr75p(end-1,1)-corr75p(end,1), corr75p(end-1,1)+corr75p(end,1), corr75p(end-1,1)+corr75p(end,1)], [128/255, 201/255, 255/255], 'EdgeColor', 'none', 'FaceAlpha', 0.3)
    plot([6.5 7.5], [corr75p(end-1,1), corr75p(end-1,1)], 'k', 'LineWidth', 1)
    fill([8.5 9.5 9.5 8.5], [corr76p(end-1,1)-corr76p(end,1), corr76p(end-1,1)-corr76p(end,1), corr76p(end-1,1)+corr76p(end,1), corr76p(end-1,1)+corr76p(end,1)], [128/255, 201/255, 255/255], 'EdgeColor', 'none', 'FaceAlpha', 0.3)
    plot([8.5 9.5], [corr76p(end-1,1), corr76p(end-1,1)], 'k', 'LineWidth', 1)

    ylim([300 320])
    xticks([1:2:9])
    xticklabels({'72dB','73dB','74dB','75dB','76dB'})
    ylabel('mean latency [ms]')
    title([elec ' | MA | P2'])

    subplot(2,2,3) % A, N1
    hold on
    fill([0.5 1.5 1.5 0.5], [corr72n(end-1,2)-corr72n(end,2), corr72n(end-1,2)-corr72n(end,2), corr72n(end-1,2)+corr72n(end,2), corr72n(end-1,2)+corr72n(end,2)], [128/255, 201/255, 255/255], 'EdgeColor', 'none', 'FaceAlpha', 0.3)
    plot([0.5 1.5], [corr72n(end-1,2), corr72n(end-1,2)], 'k', 'LineWidth', 1)
    fill([2.5 3.5 3.5 2.5], [corr73n(end-1,2)-corr73n(end,2), corr73n(end-1,2)-corr73n(end,2), corr73n(end-1,2)+corr73n(end,2), corr73n(end-1,2)+corr73n(end,2)], [128/255, 201/255, 255/255], 'EdgeColor', 'none', 'FaceAlpha', 0.3)
    plot([2.5 3.5], [corr73n(end-1,2), corr73n(end-1,2)], 'k', 'LineWidth', 1)
    fill([4.5 5.5 5.5 4.5], [corr74n(end-1,2)-corr74n(end,2), corr74n(end-1,2)-corr74n(end,2), corr74n(end-1,2)+corr74n(end,2), corr74n(end-1,2)+corr74n(end,2)], [128/255, 201/255, 255/255], 'EdgeColor', 'none', 'FaceAlpha', 0.3)
    plot([4.5 5.5], [corr74n(end-1,2), corr74n(end-1,2)], 'k', 'LineWidth', 1)
    fill([6.5 7.5 7.5 6.5], [corr75n(end-1,2)-corr75n(end,2), corr75n(end-1,2)-corr75n(end,2), corr75n(end-1,2)+corr75n(end,2), corr75n(end-1,2)+corr75n(end,2)], [128/255, 201/255, 255/255], 'EdgeColor', 'none', 'FaceAlpha', 0.3)
    plot([6.5 7.5], [corr75n(end-1,2), corr75n(end-1,2)], 'k', 'LineWidth', 1)
    fill([8.5 9.5 9.5 8.5], [corr76n(end-1,2)-corr76n(end,2), corr76n(end-1,2)-corr76n(end,2), corr76n(end-1,2)+corr76n(end,2), corr76n(end-1,2)+corr76n(end,2)], [128/255, 201/255, 255/255], 'EdgeColor', 'none', 'FaceAlpha', 0.3)
    plot([8.5 9.5], [corr76n(end-1,2), corr76n(end-1,2)], 'k', 'LineWidth', 1)

    ylim([260 280])
    xticks([1:2:9])
    xticklabels({'72dB','73dB','74dB','75dB','76dB'})
    ylabel('mean latency [ms]')
    title([elec ' | A | N1'])

    subplot(2,2,4) % A, P2
    hold on
    fill([0.5 1.5 1.5 0.5], [corr72p(end-1,2)-corr72p(end,2), corr72p(end-1,2)-corr72p(end,2), corr72p(end-1,2)+corr72p(end,2), corr72p(end-1,2)+corr72p(end,2)], [128/255, 201/255, 255/255], 'EdgeColor', 'none', 'FaceAlpha', 0.3)
    plot([0.5 1.5], [corr72p(end-1,2), corr72p(end-1,2)], 'k', 'LineWidth', 1)
    fill([2.5 3.5 3.5 2.5], [corr73p(end-1,2)-corr73p(end,2), corr73p(end-1,2)-corr73p(end,2), corr73p(end-1,2)+corr73p(end,2), corr73p(end-1,2)+corr73p(end,2)], [128/255, 201/255, 255/255], 'EdgeColor', 'none', 'FaceAlpha', 0.3)
    plot([2.5 3.5], [corr73p(end-1,2), corr73p(end-1,2)], 'k', 'LineWidth', 1)
    fill([4.5 5.5 5.5 4.5], [corr74p(end-1,2)-corr74p(end,2), corr74p(end-1,2)-corr74p(end,2), corr74p(end-1,2)+corr74p(end,2), corr74p(end-1,2)+corr74p(end,2)], [128/255, 201/255, 255/255], 'EdgeColor', 'none', 'FaceAlpha', 0.3)
    plot([4.5 5.5], [corr74p(end-1,2), corr74p(end-1,2)], 'k', 'LineWidth', 1)
    fill([6.5 7.5 7.5 6.5], [corr75p(end-1,2)-corr75p(end,2), corr75p(end-1,2)-corr75p(end,2), corr75p(end-1,2)+corr75p(end,2), corr75p(end-1,2)+corr75p(end,2)], [128/255, 201/255, 255/255], 'EdgeColor', 'none', 'FaceAlpha', 0.3)
    plot([6.5 7.5], [corr75p(end-1,2), corr75p(end-1,2)], 'k', 'LineWidth', 1)
    fill([8.5 9.5 9.5 8.5], [corr76p(end-1,2)-corr76p(end,2), corr76p(end-1,2)-corr76p(end,2), corr76p(end-1,2)+corr76p(end,2), corr76p(end-1,2)+corr76p(end,2)], [128/255, 201/255, 255/255], 'EdgeColor', 'none', 'FaceAlpha', 0.3)
    plot([8.5 9.5], [corr76p(end-1,2), corr76p(end-1,2)], 'k', 'LineWidth', 1)

    ylim([300 320])
    xticks([1:2:9])
    xticklabels({'72dB','73dB','74dB','75dB','76dB'})
    ylabel('mean latency [ms]')
    title([elec ' | A | P2'])

    saveas(gcf, ['2T_Latency_' elec '.png'])
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. tone über dB mitteln und dann mit erstem Ton vergleichen
% pro SOA vergleichen
% boxplots
% pro Elektrode 2 subplots: N peak, P peak
% innerhalb subplots: A, verschiedene SOAs, 1. Ton, 2. Ton direkt
% nebeneinander (farblich verschieden)
clear n1 p1 n2 p2
for el = 1:3
    elec = scd_tone{8,el+1};

    t2_sort.(elec) = scd_tone(1,:);
    [t2_sort.(elec){2:11,1}] = deal('A','SOA 0','SOA 50','SOA 200','SOA 600','N/P A','N/P 0','N/P 50','N/P 200','N/P 600');
    [t2_sort.(elec){12:16,1}] = deal('N/P A corr','N/P 0 corr','N/P 50 corr','N/P 200 corr','N/P 600 corr');
    
    t1_peaks.(elec) = t2_sort.(elec)(1,:);
    [t1_peaks.(elec){2:6,1}] = deal('N/P A','N/P 0','N/P 50','N/P 200','N/P 600');
    [t1_peaks.(elec){7:11,1}] = deal('N/P A corr','N/P 0 corr','N/P 50 corr','N/P 200 corr','N/P 600 corr');
    
    for sb = 1:Nsub
        % A (hat nur SOA 0 --> alle trials rein, mitteln über dB)
        t2_sort.(elec){2,sb+1} = mean(...
            [scd_tone{4,sb+1}{2,el+1}(1:end-1,:);scd_tone{4,sb+1}{3,el+1}(1:end-1,:);...
            scd_tone{4,sb+1}{4,el+1}(1:end-1,:);scd_tone{4,sb+1}{5,el+1}(1:end-1,:);...
            scd_tone{4,sb+1}{6,el+1}(1:end-1,:)],1);
        % SOAs
        for ss = 1:4
            erp = [];
            for ld = 1:5
                i = find([scd_tone{7,sb+1}.MA{ld+1,el+1}]==ss);
                erp = vertcat(erp, scd_tone{6,sb+1}{ld+1,el+1}(i,:));
            end
            t2_sort.(elec){ss+2,sb+1} = mean(erp,1);

        end
        % peaks
        i1 = [2,10:13];
        for con = 1:5
            % 2. tone
            t2_sort.(elec){con+6,sb+1} = [min(t2_sort.(elec){con+1,sb+1}(peaks{11,6}(1):peaks{11,6}(2))),max(t2_sort.(elec){con+1,sb+1}(peaks{12,6}(1):peaks{12,6}(2)))];
            % 1. tone
            t1_peaks.(elec){con+1,sb+1} = [min(EEG_data{el+6,i1(con)}(sb,peaks{11,6}(1):peaks{11,6}(2))),max(EEG_data{el+6,i1(con)}(sb,peaks{12,6}(1):peaks{12,6}(2)))];
        end

        % Varianzkorrektur: bei sm alle conditions pro peak rein (1. Ton +
        % 2. Ton), sm1 = N, sm2 = P
        sm1(sb) = mean([t1_peaks.(elec){2,sb+1}(1),t1_peaks.(elec){3,sb+1}(1),t1_peaks.(elec){4,sb+1}(1),t1_peaks.(elec){5,sb+1}(1),t1_peaks.(elec){6,sb+1}(1),...
            t2_sort.(elec){7,sb+1}(1),t2_sort.(elec){8,sb+1}(1),t2_sort.(elec){9,sb+1}(1),t2_sort.(elec){10,sb+1}(1),t2_sort.(elec){11,sb+1}(1)]);
        sm2(sb) = mean([t1_peaks.(elec){2,sb+1}(2),t1_peaks.(elec){3,sb+1}(2),t1_peaks.(elec){4,sb+1}(2),t1_peaks.(elec){5,sb+1}(2),t1_peaks.(elec){6,sb+1}(2),...
            t2_sort.(elec){7,sb+1}(2),t2_sort.(elec){8,sb+1}(2),t2_sort.(elec){9,sb+1}(2),t2_sort.(elec){10,sb+1}(2),t2_sort.(elec){11,sb+1}(2)]); 
    end
    gm1 = mean(sm1);
    gm2 = mean(sm2);

    for sb = 1:Nsub
        smgm1(sb) = sm1(sb) - gm1;
        smgm2(sb) = sm2(sb) - gm2;
        
        for con = 1:5
            t1_peaks.(elec){con+6,sb+1} = [t1_peaks.(elec){con+1,sb+1}(1)-smgm1(sb),t1_peaks.(elec){con+1,sb+1}(2)-smgm2(sb)];
            t2_sort.(elec){con+11,sb+1} = [t2_sort.(elec){con+6,sb+1}(1)-smgm1(sb),t2_sort.(elec){con+1,sb+1}(2)-smgm2(sb)];
        end
    end
    % mean, sem
    [t1_peaks.(elec){6,Nsub+2:Nsub+3}] = deal('Mean','SEM');
    [t2_sort.(elec){11,Nsub+2:Nsub+3}] = deal('Mean','SEM');
    
    for con = 1:5
        for sb = 1:Nsub
            n1.(elec)(sb,con) = t1_peaks.(elec){con+6,sb+1}(1);
            p1.(elec)(sb,con) = t1_peaks.(elec){con+6,sb+1}(2);
            n2.(elec)(sb,con) = t2_sort.(elec){con+11,sb+1}(1);
            p2.(elec)(sb,con) = t2_sort.(elec){con+11,sb+1}(2);
        end
        t1_peaks.(elec){con+6,Nsub+2} = [mean(n1.(elec)(:,con)), mean(p1.(elec)(:,con))];
        t2_sort.(elec){con+11,Nsub+2} = [mean(n2.(elec)(:,con)), mean(p2.(elec)(:,con))];
        t1_peaks.(elec){con+6,Nsub+3} = [std(n1.(elec)(:,con))/sqrt(Nsub), std(p1.(elec)(:,con))/sqrt(Nsub)];
        t2_sort.(elec){con+11,Nsub+3} = [std(n2.(elec)(:,con))/sqrt(Nsub), std(p2.(elec)(:,con))/sqrt(Nsub)];
    end
    

    % Statistik
    % Anova innerhalb Ton, t-tests zwischen Tönen
    [stat_t12.(elec){1,1:4}] = deal('ANOVA T1 N', 'df', 'F', 'p');
    disp(elec)
    disp('Anova T1 N')
    T1n(:,1) = [n1.(elec)(:,1);n1.(elec)(:,2);n1.(elec)(:,3);n1.(elec)(:,4);n1.(elec)(:,5)];
    T1n(:,2) = [ones(Nsub,1);ones(Nsub,1)*2;ones(Nsub,1)*3;ones(Nsub,1)*4;ones(Nsub,1)*5];
    T1n(:,3) = [1:Nsub,1:Nsub,1:Nsub,1:Nsub,1:Nsub]';
    RMAOV1(T1n)
    
    [stat_t12.(elec){3,1:4}] = deal('ANOVA T1 P', 'df', 'F', 'p');
    disp('Anova T1 P')
    T1p(:,1) = [p1.(elec)(:,1);p1.(elec)(:,2);p1.(elec)(:,3);p1.(elec)(:,4);p1.(elec)(:,5)];
    T1p(:,2) = [ones(Nsub,1);ones(Nsub,1)*2;ones(Nsub,1)*3;ones(Nsub,1)*4;ones(Nsub,1)*5];
    T1p(:,3) = [1:Nsub,1:Nsub,1:Nsub,1:Nsub,1:Nsub]';
    RMAOV1(T1p)

    [stat_t12.(elec){5,1:4}] = deal('ANOVA T2 N', 'df', 'F', 'p');
    disp('Anova T2 N')
    T2n(:,1) = [n2.(elec)(:,1);n2.(elec)(:,2);n2.(elec)(:,3);n2.(elec)(:,4);n2.(elec)(:,5)];
    T2n(:,2) = [ones(Nsub,1);ones(Nsub,1)*2;ones(Nsub,1)*3;ones(Nsub,1)*4;ones(Nsub,1)*5];
    T2n(:,3) = [1:Nsub,1:Nsub,1:Nsub,1:Nsub,1:Nsub]';
    RMAOV1(T2n)
    
    [stat_t12.(elec){7,1:4}] = deal('ANOVA T2 P', 'df', 'F', 'p');
    disp('Anova T2 P')
    T2p(:,1) = [p2.(elec)(:,1);p2.(elec)(:,2);p2.(elec)(:,3);p2.(elec)(:,4);p2.(elec)(:,5)];
    T2p(:,2) = [ones(Nsub,1);ones(Nsub,1)*2;ones(Nsub,1)*3;ones(Nsub,1)*4;ones(Nsub,1)*5];
    T2p(:,3) = [1:Nsub,1:Nsub,1:Nsub,1:Nsub,1:Nsub]';
    RMAOV1(T2p)
    
    % ttests
    [stat_t12.(elec){9,1:3}] = deal('ttests','p N','p P');
    [stat_t12.(elec){10:14,1}] = deal('A','0','50','200','600');
    for con = 1:5
        [~,stat_t12.(elec){con+9,2}] = ttest(n1.(elec)(:,con),n2.(elec)(:,con));
        [~,stat_t12.(elec){con+9,3}] = ttest(p1.(elec)(:,con),p2.(elec)(:,con));
    end

    % 2way Anova
    [stat_t12.(elec){1,5:8}] = deal('2way Anova N1','df (IV 1, IV 2, interaction)','F (1,2,Inter)','p(1,2,inter)');
    [stat_t12.(elec){3,5:8}] = deal('2way Anova P2','df (IV 1, IV 2, interaction)','F (1,2,Inter)','p(1,2,inter)');

    T12N(:,1) = [T1n(:,1);T2n(:,1)];
    T12N(:,2) = [ones(size(T1n,1),1);ones(size(T2n,1),1)*2];
    T12N(:,3) = [T1n(:,2);T2n(:,2)];
    T12N(:,4) = [T1n(:,3);T2n(:,3)];
    disp(['2way ANOVA_T1vs.2_N_' elec])
    RMAOV2(T12N)

    T12P(:,1) = [T1p(:,1);T2p(:,1)];
    T12P(:,2) = [ones(size(T1p,1),1);ones(size(T2p,1),1)*2];
    T12P(:,3) = [T1p(:,2);T2p(:,2)];
    T12P(:,4) = [T1p(:,3);T2p(:,3)];
    disp(['2way ANOVA_T1vs.2_P_' elec])
    RMAOV2(T12P)
end

% Anova results
%FCz
[stat_t12.FCz{2,2:4}] = deal([4,64], 1.140, 0.3456);
[stat_t12.FCz{4,2:4}] = deal([4,64], 4.336, 0.0036);
[stat_t12.FCz{6,2:4}] = deal([4,64], 0.338, 0.8512);
[stat_t12.FCz{8,2:4}] = deal([4,64], 0.567, 0.6873);

[stat_t12.FCz{2,6:8}] = deal([1,16;4,64;4,64], [29.266;0.893;1.166], [0.0001;0.4731;0.3342]);
[stat_t12.FCz{4,6:8}] = deal([1,16;4,64;4,64], [50.212;2.710;4.278], [0.0000;0.0377;0.0040]);

%Fz
[stat_t12.Fz{2,2:4}] = deal([4,64], 1.891, 0.1229);
[stat_t12.Fz{4,2:4}] = deal([4,64], 1.523, 0.2059);
[stat_t12.Fz{6,2:4}] = deal([4,64], 0.165, 0.9554);
[stat_t12.Fz{8,2:4}] = deal([4,64], 0.594, 0.6680);

[stat_t12.Fz{2,6:8}] = deal([1,16;4,64;4,64], [14.591;1.128;2.367], [0.0015;0.3513;0.0620]);
[stat_t12.Fz{4,6:8}] = deal([1,16;4,64;4,64], [30.997;0.861;1.752], [0.0000;0.4921;0.1496]);

%Cz
[stat_t12.Cz{2,2:4}] = deal([4,64], 1.309, 0.2761);
[stat_t12.Cz{4,2:4}] = deal([4,64], 8.745, 0.0000);
[stat_t12.Cz{6,2:4}] = deal([4,64], 0.925, 0.4551);
[stat_t12.Cz{8,2:4}] = deal([4,64], 0.364, 0.8334);

[stat_t12.Cz{2,6:8}] = deal([1,16;4,64;4,64], [37.018;1.128;1.418], [0.0000;0.3511;0.2382]);
[stat_t12.Cz{4,6:8}] = deal([1,16;4,64;4,64], [65.132;5.827;8.457], [0.0000;0.0005;0.0000]);

% figure
%cd('../Figures')
col1 = [128/255, 201/255, 255/255];
col2 = [128/255, 255/255, 201/255];
pos1 = [1,6,11,16,21];
pos2 = [3,8,13,18,23];

for el = 1:3
    elec = scd_tone{8,el+1};
    figure('Position',[200, 150, 800, 600])
    subplot(2,1,1) % N peak
    hold on
    for c = 1:5 % conditions
        f1=fill([pos1(c)-0.5,pos1(c)+0.5,pos1(c)+0.5,pos1(c)-0.5], [t1_peaks.(elec){c+6,Nsub+2}(1)-t1_peaks.(elec){c+6,Nsub+3}(1),t1_peaks.(elec){c+6,Nsub+2}(1)-t1_peaks.(elec){c+6,Nsub+3}(1),t1_peaks.(elec){c+6,Nsub+2}(1)+t1_peaks.(elec){c+6,Nsub+3}(1),t1_peaks.(elec){c+6,Nsub+2}(1)+t1_peaks.(elec){c+6,Nsub+3}(1)],col1,'EdgeColor','none','FaceAlpha',0.3); % T1
        plot([pos1(c)-0.5,pos1(c)+0.5], [t1_peaks.(elec){c+6,Nsub+2}(1),t1_peaks.(elec){c+6,Nsub+2}(1)],'k','LineWidth',1)
        
        f2=fill([pos2(c)-0.5,pos2(c)+0.5,pos2(c)+0.5,pos2(c)-0.5], [t2_sort.(elec){c+11,Nsub+2}(1)-t2_sort.(elec){c+11,Nsub+3}(1),t2_sort.(elec){c+11,Nsub+2}(1)-t2_sort.(elec){c+11,Nsub+3}(1),t2_sort.(elec){c+11,Nsub+2}(1)+t2_sort.(elec){c+11,Nsub+3}(1),t2_sort.(elec){c+11,Nsub+2}(1)+t2_sort.(elec){c+11,Nsub+3}(1)],col2,'EdgeColor','none','FaceAlpha',0.3); % T2
        plot([pos2(c)-0.5,pos2(c)+0.5], [t2_sort.(elec){c+11,Nsub+2}(1),t2_sort.(elec){c+11,Nsub+2}(1)],'k','LineWidth',1)
    end
    xlim([0 24])
    ylim([-15 -5])
    xticks(2:5:22)
    xticklabels({'A','SOA 0', 'SOA 50', 'SOA 200', 'SOA 600'})
    %legend([f1 f2], {'1. tone', '2. tone'}, 'Location', 'southeast')
    ylabel('mean amplitude [µV]')
    title([elec '| N1 peak'])

    subplot(2,1,2) % P peak
    hold on
    for c = 1:5 % conditions
        f1=fill([pos1(c)-0.5,pos1(c)+0.5,pos1(c)+0.5,pos1(c)-0.5], [t1_peaks.(elec){c+6,Nsub+2}(2)-t1_peaks.(elec){c+6,Nsub+3}(2),t1_peaks.(elec){c+6,Nsub+2}(2)-t1_peaks.(elec){c+6,Nsub+3}(2),t1_peaks.(elec){c+6,Nsub+2}(2)+t1_peaks.(elec){c+6,Nsub+3}(2),t1_peaks.(elec){c+6,Nsub+2}(2)+t1_peaks.(elec){c+6,Nsub+3}(2)],col1,'EdgeColor','none','FaceAlpha',0.3); % T1
        plot([pos1(c)-0.5,pos1(c)+0.5], [t1_peaks.(elec){c+6,Nsub+2}(2),t1_peaks.(elec){c+6,Nsub+2}(2)],'k','LineWidth',1)
        
        f2=fill([pos2(c)-0.5,pos2(c)+0.5,pos2(c)+0.5,pos2(c)-0.5], [t2_sort.(elec){c+11,Nsub+2}(2)-t2_sort.(elec){c+11,Nsub+3}(2),t2_sort.(elec){c+11,Nsub+2}(2)-t2_sort.(elec){c+11,Nsub+3}(2),t2_sort.(elec){c+11,Nsub+2}(2)+t2_sort.(elec){c+11,Nsub+3}(2),t2_sort.(elec){c+11,Nsub+2}(2)+t2_sort.(elec){c+11,Nsub+3}(2)],col2,'EdgeColor','none','FaceAlpha',0.3); % T2
        plot([pos2(c)-0.5,pos2(c)+0.5], [t2_sort.(elec){c+11,Nsub+2}(2),t2_sort.(elec){c+11,Nsub+2}(2)],'k','LineWidth',1)
    end
    xlim([0 24])
    ylim([0 15])
    xticks(2:5:22)
    xticklabels({'A','SOA 0', 'SOA 50', 'SOA 200', 'SOA 600'})
    legend([f1 f2], {'1. tone', '2. tone'},'Location','northwest')
    ylabel('mean amplitude [µV]')
    title([elec '| P2 peak'])

    saveas(gcf, ['comT1T2_' elec '.png'])
end
cd('../EEG')
%% sonstiges
% - duration of N1, P2 deflection depending on SOA?
% - onset different? / time of peak different for different SOAs
% - shift on time axis


%% reaction times?
% es gibt schon den Ordner RT, aber es fehlen noch von 10 und 13
% muss noch rauskriegen/überlegen, wie sie RTs rausgezogen hat


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% ------------- 5.0 Übersicht Elektroden für A ---------------------- %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% - für auditory-only Bedingung ERP über Probanden mitteln
% - subplot für jede Elektrode
channel = 1:31;
for sb = 1:Nsub
    ErrTr = ErrorTrials(subject{sb});
    [out1,out2,out3,EEGtime,N,SD] = AnalyzeEEG_XL(subject{sb},channel,ErrTr);
    for el = 1:length(channel)
       A_oview(1).(EEG_data{3,sb+1}.EEG.chanlocs(el).labels)(sb,:) = [out1(el,:)]; % ERP
       A_oview(2).(EEG_data{3,sb+1}.EEG.chanlocs(el).labels)(sb,:) = [SD.np(el,:)]; % SD
       A_oview(3).(EEG_data{3,sb+1}.EEG.chanlocs(el).labels)(sb) = N.np; % N    

       MA_oview(1).(EEG_data{3,sb+1}.EEG.chanlocs(el).labels)(sb,:) = [out3(el,:)]-[out2(el,:)]; % ERP
       MA_oview(2).(EEG_data{3,sb+1}.EEG.chanlocs(el).labels)(sb,:) = [SD.s0(el,:)]; % SD
       MA_oview(3).(EEG_data{3,sb+1}.EEG.chanlocs(el).labels)(sb) = N.s0; % N

       M_oview(1).(EEG_data{3,sb+1}.EEG.chanlocs(el).labels)(sb,:) = [out2(el,:)]; % ERP
       M_oview(2).(EEG_data{3,sb+1}.EEG.chanlocs(el).labels)(sb,:) = [SD.ns(el,:)]; % SD
       M_oview(3).(EEG_data{3,sb+1}.EEG.chanlocs(el).labels)(sb) = N.ns; % N
    end
end

% auditory-only
figure('Position', [50, 50, 1400, 700])
for el = 1:31
    chn = EEG_data{3,2}.EEG.chanlocs(el).labels;
    % SEM
    sd = std([A_oview(1).(chn)],1);
    n = size([A_oview(1).(chn)],1);
    sem = sd/sqrt(n);

    subplot(4,8,el)
    hold on
    plot([-200 400], [0,0], 'Color', [153/255, 153/255, 153/255]) % x-line
    plot([0,0], [-15,15], 'Color', [153/255, 153/255, 153/255]) % y-line
    fill([EEGtime,EEGtime(end:-1:1)], [mean([A_oview(1).(chn)],1)-sem, flip(mean([A_oview(1).(chn)],1)+sem)],'k','EdgeColor', 'none','FaceAlpha',0.2)
    plot(EEGtime, mean([A_oview(1).(chn)],1),'r')
    xlim([-200 400])
    ylim([-15 15])
    title(chn)
end
%cd('../Figures')
saveas(gcf, 'AllChannels_Overview_A.png')

% motor-only
figure('Position', [50, 50, 1400, 700])
for el = 1:31
    chn = EEG_data{3,2}.EEG.chanlocs(el).labels;
    % SEM
    sd = std([M_oview(1).(chn)],1);
    n = size([M_oview(1).(chn)],1);
    sem = sd/sqrt(n);

    subplot(4,8,el)
    hold on
    plot([-200 400], [0,0], 'Color', [153/255, 153/255, 153/255]) % x-line
    plot([0,0], [-15,15], 'Color', [153/255, 153/255, 153/255]) % y-line
    fill([EEGtime,EEGtime(end:-1:1)], [mean([M_oview(1).(chn)],1)-sem, flip(mean([M_oview(1).(chn)],1)+sem)],'k','EdgeColor', 'none','FaceAlpha',0.2)
    plot(EEGtime, mean([M_oview(1).(chn)],1),'r')
    xlim([-200 400])
    ylim([-15 15])
    title(chn)
end

saveas(gcf, 'AllChannels_Overview_M.png')

% motor-auditory
figure('Position', [50, 50, 1400, 700])
for el = 1:31
    chn = EEG_data{3,2}.EEG.chanlocs(el).labels;
    % SEM
    sd = std([MA_oview(1).(chn)],1);
    n = size([MA_oview(1).(chn)],1);
    sem = sd/sqrt(n);

    subplot(4,8,el)
    hold on
    plot([-200 400], [0,0], 'Color', [153/255, 153/255, 153/255]) % x-line
    plot([0,0], [-15,15], 'Color', [153/255, 153/255, 153/255]) % y-line
    fill([EEGtime,EEGtime(end:-1:1)], [mean([MA_oview(1).(chn)],1)-sem, flip(mean([MA_oview(1).(chn)],1)+sem)],'k','EdgeColor', 'none','FaceAlpha',0.2)
    plot(EEGtime, mean([MA_oview(1).(chn)],1),'r')
    xlim([-200 400])
    ylim([-15 15])
    title(chn)
end
saveas(gcf, 'AllChannels_Overview_MA.png')
cd('../EEG')


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% ------------------------- 6.0 Latency ----------------------------- %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% "bar" plot for peak and latency
% for auditory-only, different SOAs
% Anova, post-hoc t-test
electrodes = EEG_data(7:9,1);
elec = 7:9; % index of electrodes in EEG_data

% for each electrode and peak own figure
n1 = figure('Position', [200, 150, 1000, 600]);
n2 = figure('Position', [200, 150, 1000, 600]);
n3 = figure('Position', [200, 150, 1000, 600]);
%n4 = figure('Position', [200, 150, 1000, 600]);
p1 = figure('Position', [200, 150, 1000, 600]);
p2 = figure('Position', [200, 150, 1000, 600]);
p3 = figure('Position', [200, 150, 1000, 600]);
%p4 = figure('Position', [200, 150, 1000, 600]);
figs = [n1,n2,n3;p1,p2,p3];

for el = 1:3
    % N1, crit = 1
    pn = peaks{11,6}; 
    Nint.(electrodes{el}(1:end-5)) = Analyze_PeakLatency(Nsub, elec(el), pn, EEG_data, 1);
    % P2, crit = 2
    pp = peaks{12,6};
    Pint.(electrodes{el}(1:end-5)) = Analyze_PeakLatency(Nsub, elec(el), pp, EEG_data, 2);

    % Anova: column 1 = min/latency, column 2 = condition, column 3 =  subject
    % N1
    anv(:,1) = [Nint.(electrodes{el}(1:end-5)).A.local.value';Nint.(electrodes{el}(1:end-5)).S0.local.value';...
        Nint.(electrodes{el}(1:end-5)).S5.local.value';Nint.(electrodes{el}(1:end-5)).S2.local.value';Nint.(electrodes{el}(1:end-5)).S6.local.value'];
    anv(:,2) = [ones(Nsub,1);ones(Nsub,1)*2;ones(Nsub,1)*3;ones(Nsub,1)*4;ones(Nsub,1)*5];
    anv(:,3) = [[1:Nsub]';[1:Nsub]';[1:Nsub]';[1:Nsub]';[1:Nsub]'];
    
    disp(['N_amplitude_' (electrodes{el}(1:end-5))])
    RMAOV1(anv)
    
    % post-hoc two-tailed paired t-tests
    [~, Nint.(electrodes{el}(1:end-5)).ttestPeak.A0] = ttest([Nint.(electrodes{el}(1:end-5)).A.local.value],[Nint.(electrodes{el}(1:end-5)).S0.local.value]);
    [~, Nint.(electrodes{el}(1:end-5)).ttestPeak.A5] = ttest([Nint.(electrodes{el}(1:end-5)).A.local.value],[Nint.(electrodes{el}(1:end-5)).S5.local.value]);
    [~, Nint.(electrodes{el}(1:end-5)).ttestPeak.A2] = ttest([Nint.(electrodes{el}(1:end-5)).A.local.value],[Nint.(electrodes{el}(1:end-5)).S2.local.value]);
    [~, Nint.(electrodes{el}(1:end-5)).ttestPeak.A6] = ttest([Nint.(electrodes{el}(1:end-5)).A.local.value],[Nint.(electrodes{el}(1:end-5)).S6.local.value]);
    [~, Nint.(electrodes{el}(1:end-5)).ttestPeak.S05] = ttest([Nint.(electrodes{el}(1:end-5)).S0.local.value],[Nint.(electrodes{el}(1:end-5)).S5.local.value]);
    [~, Nint.(electrodes{el}(1:end-5)).ttestPeak.S02] = ttest([Nint.(electrodes{el}(1:end-5)).S0.local.value],[Nint.(electrodes{el}(1:end-5)).S2.local.value]);
    [~, Nint.(electrodes{el}(1:end-5)).ttestPeak.S06] = ttest([Nint.(electrodes{el}(1:end-5)).S0.local.value],[Nint.(electrodes{el}(1:end-5)).S6.local.value]);
    [~, Nint.(electrodes{el}(1:end-5)).ttestPeak.S52] = ttest([Nint.(electrodes{el}(1:end-5)).S5.local.value],[Nint.(electrodes{el}(1:end-5)).S2.local.value]);
    [~, Nint.(electrodes{el}(1:end-5)).ttestPeak.S56] = ttest([Nint.(electrodes{el}(1:end-5)).S5.local.value],[Nint.(electrodes{el}(1:end-5)).S6.local.value]);
    [~, Nint.(electrodes{el}(1:end-5)).ttestPeak.S26] = ttest([Nint.(electrodes{el}(1:end-5)).S2.local.value],[Nint.(electrodes{el}(1:end-5)).S6.local.value]);
    Nint.(electrodes{el}(1:end-5)).ttestPeak.Bonf = 0.05/10;
    

    % P2
    anv(:,1) = [Pint.(electrodes{el}(1:end-5)).A.local.value';Pint.(electrodes{el}(1:end-5)).S0.local.value';...
        Pint.(electrodes{el}(1:end-5)).S5.local.value';Pint.(electrodes{el}(1:end-5)).S2.local.value';Pint.(electrodes{el}(1:end-5)).S6.local.value'];
    anv(:,2) = [ones(Nsub,1);ones(Nsub,1)*2;ones(Nsub,1)*3;ones(Nsub,1)*4;ones(Nsub,1)*5];
    anv(:,3) = [[1:Nsub]';[1:Nsub]';[1:Nsub]';[1:Nsub]';[1:Nsub]'];
    
    disp(['P_amplitude_' (electrodes{el}(1:end-5))])
    RMAOV1(anv);

    % post-hoc two-tailed paired t-tests
    [~, Pint.(electrodes{el}(1:end-5)).ttestPeak.A0] = ttest([Pint.(electrodes{el}(1:end-5)).A.local.value],[Pint.(electrodes{el}(1:end-5)).S0.local.value]);
    [~, Pint.(electrodes{el}(1:end-5)).ttestPeak.A5] = ttest([Pint.(electrodes{el}(1:end-5)).A.local.value],[Pint.(electrodes{el}(1:end-5)).S5.local.value]);
    [~, Pint.(electrodes{el}(1:end-5)).ttestPeak.A2] = ttest([Pint.(electrodes{el}(1:end-5)).A.local.value],[Pint.(electrodes{el}(1:end-5)).S2.local.value]);
    [~, Pint.(electrodes{el}(1:end-5)).ttestPeak.A6] = ttest([Pint.(electrodes{el}(1:end-5)).A.local.value],[Pint.(electrodes{el}(1:end-5)).S6.local.value]);
    [~, Pint.(electrodes{el}(1:end-5)).ttestPeak.S05] = ttest([Pint.(electrodes{el}(1:end-5)).S0.local.value],[Pint.(electrodes{el}(1:end-5)).S5.local.value]);
    [~, Pint.(electrodes{el}(1:end-5)).ttestPeak.S02] = ttest([Pint.(electrodes{el}(1:end-5)).S0.local.value],[Pint.(electrodes{el}(1:end-5)).S2.local.value]);
    [~, Pint.(electrodes{el}(1:end-5)).ttestPeak.S06] = ttest([Pint.(electrodes{el}(1:end-5)).S0.local.value],[Pint.(electrodes{el}(1:end-5)).S6.local.value]);
    [~, Pint.(electrodes{el}(1:end-5)).ttestPeak.S52] = ttest([Pint.(electrodes{el}(1:end-5)).S5.local.value],[Pint.(electrodes{el}(1:end-5)).S2.local.value]);
    [~, Pint.(electrodes{el}(1:end-5)).ttestPeak.S56] = ttest([Pint.(electrodes{el}(1:end-5)).S5.local.value],[Pint.(electrodes{el}(1:end-5)).S6.local.value]);
    [~, Pint.(electrodes{el}(1:end-5)).ttestPeak.S26] = ttest([Pint.(electrodes{el}(1:end-5)).S2.local.value],[Pint.(electrodes{el}(1:end-5)).S6.local.value]);
    Pint.(electrodes{el}(1:end-5)).ttestPeak.Bonf = 0.05/10;
    

    % N1 latency
    anv(:,1) = [Nint.(electrodes{el}(1:end-5)).A.local.latency';Nint.(electrodes{el}(1:end-5)).S0.local.latency';Nint.(electrodes{el}(1:end-5)).S5.local.latency';Nint.(electrodes{el}(1:end-5)).S2.local.latency';Nint.(electrodes{el}(1:end-5)).S6.local.latency'];
    anv(:,2) = [ones(Nsub,1);ones(Nsub,1)*2;ones(Nsub,1)*3;ones(Nsub,1)*4;ones(Nsub,1)*5];
    anv(:,3) = [[1:Nsub]';[1:Nsub]';[1:Nsub]';[1:Nsub]';[1:Nsub]'];
    
    disp(['N_latency_' electrodes{el}(1:end-5)])
    RMAOV1(anv)

    % post-hoc two-tailed paired t-tests
    [~, Nint.(electrodes{el}(1:end-5)).ttestLat.A0] = ttest([Nint.(electrodes{el}(1:end-5)).A.local.latency],[Nint.(electrodes{el}(1:end-5)).S0.local.latency]);
    [~, Nint.(electrodes{el}(1:end-5)).ttestLat.A5] = ttest([Nint.(electrodes{el}(1:end-5)).A.local.latency],[Nint.(electrodes{el}(1:end-5)).S5.local.latency]);
    [~, Nint.(electrodes{el}(1:end-5)).ttestLat.A2] = ttest([Nint.(electrodes{el}(1:end-5)).A.local.latency],[Nint.(electrodes{el}(1:end-5)).S2.local.latency]);
    [~, Nint.(electrodes{el}(1:end-5)).ttestLat.A6] = ttest([Nint.(electrodes{el}(1:end-5)).A.local.latency],[Nint.(electrodes{el}(1:end-5)).S6.local.latency]);
    [~, Nint.(electrodes{el}(1:end-5)).ttestLat.S05] = ttest([Nint.(electrodes{el}(1:end-5)).S0.local.latency],[Nint.(electrodes{el}(1:end-5)).S5.local.latency]);
    [~, Nint.(electrodes{el}(1:end-5)).ttestLat.S02] = ttest([Nint.(electrodes{el}(1:end-5)).S0.local.latency],[Nint.(electrodes{el}(1:end-5)).S2.local.latency]);
    [~, Nint.(electrodes{el}(1:end-5)).ttestLat.S06] = ttest([Nint.(electrodes{el}(1:end-5)).S0.local.latency],[Nint.(electrodes{el}(1:end-5)).S6.local.latency]);
    [~, Nint.(electrodes{el}(1:end-5)).ttestLat.S52] = ttest([Nint.(electrodes{el}(1:end-5)).S5.local.latency],[Nint.(electrodes{el}(1:end-5)).S2.local.latency]);
    [~, Nint.(electrodes{el}(1:end-5)).ttestLat.S56] = ttest([Nint.(electrodes{el}(1:end-5)).S5.local.latency],[Nint.(electrodes{el}(1:end-5)).S6.local.latency]);
    [~, Nint.(electrodes{el}(1:end-5)).ttestLat.S26] = ttest([Nint.(electrodes{el}(1:end-5)).S2.local.latency],[Nint.(electrodes{el}(1:end-5)).S6.local.latency]);
    Nint.(electrodes{el}(1:end-5)).ttestLat.Bonf = 0.05/10;

    
    % P2 latency
    anv(:,1) = [Pint.(electrodes{el}(1:end-5)).A.local.latency';Pint.(electrodes{el}(1:end-5)).S0.local.latency';...
        Pint.(electrodes{el}(1:end-5)).S5.local.latency';Pint.(electrodes{el}(1:end-5)).S2.local.latency';Pint.(electrodes{el}(1:end-5)).S6.local.latency'];
    anv(:,2) = [ones(Nsub,1);ones(Nsub,1)*2;ones(Nsub,1)*3;ones(Nsub,1)*4;ones(Nsub,1)*5];
    anv(:,3) = [[1:Nsub]';[1:Nsub]';[1:Nsub]';[1:Nsub]';[1:Nsub]'];
    
    disp(['P_latency_' electrodes{el}(1:end-5)])
    RMAOV1(anv)
    
    % post-hoc two-tailed paired t-tests
    [~, Pint.(electrodes{el}(1:end-5)).ttestLat.A0] = ttest([Pint.(electrodes{el}(1:end-5)).A.local.latency],[Pint.(electrodes{el}(1:end-5)).S0.local.latency]);
    [~, Pint.(electrodes{el}(1:end-5)).ttestLat.A5] = ttest([Pint.(electrodes{el}(1:end-5)).A.local.latency],[Pint.(electrodes{el}(1:end-5)).S5.local.latency]);
    [~, Pint.(electrodes{el}(1:end-5)).ttestLat.A2] = ttest([Pint.(electrodes{el}(1:end-5)).A.local.latency],[Pint.(electrodes{el}(1:end-5)).S2.local.latency]);
    [~, Pint.(electrodes{el}(1:end-5)).ttestLat.A6] = ttest([Pint.(electrodes{el}(1:end-5)).A.local.latency],[Pint.(electrodes{el}(1:end-5)).S6.local.latency]);
    [~, Pint.(electrodes{el}(1:end-5)).ttestLat.S05] = ttest([Pint.(electrodes{el}(1:end-5)).S0.local.latency],[Pint.(electrodes{el}(1:end-5)).S5.local.latency]);
    [~, Pint.(electrodes{el}(1:end-5)).ttestLat.S02] = ttest([Pint.(electrodes{el}(1:end-5)).S0.local.latency],[Pint.(electrodes{el}(1:end-5)).S2.local.latency]);
    [~, Pint.(electrodes{el}(1:end-5)).ttestLat.S06] = ttest([Pint.(electrodes{el}(1:end-5)).S0.local.latency],[Pint.(electrodes{el}(1:end-5)).S6.local.latency]);
    [~, Pint.(electrodes{el}(1:end-5)).ttestLat.S52] = ttest([Pint.(electrodes{el}(1:end-5)).S5.local.latency],[Pint.(electrodes{el}(1:end-5)).S2.local.latency]);
    [~, Pint.(electrodes{el}(1:end-5)).ttestLat.S56] = ttest([Pint.(electrodes{el}(1:end-5)).S5.local.latency],[Pint.(electrodes{el}(1:end-5)).S6.local.latency]);
    [~, Pint.(electrodes{el}(1:end-5)).ttestLat.S26] = ttest([Pint.(electrodes{el}(1:end-5)).S2.local.latency],[Pint.(electrodes{el}(1:end-5)).S6.local.latency]);
    Pint.(electrodes{el}(1:end-5)).ttestLat.Bonf = 0.05/10;


    % figures N1
    set(0, 'CurrentFigure', figs(1,el))
    subplot(1,2,1) % peak
    hold on
    fill([0.5 1.5 1.5 0.5], [Nint.(electrodes{el}(1:end-5)).A.peakmean - Nint.(electrodes{el}(1:end-5)).A.peaksem, ...
        Nint.(electrodes{el}(1:end-5)).A.peakmean - Nint.(electrodes{el}(1:end-5)).A.peaksem, ...
        Nint.(electrodes{el}(1:end-5)).A.peakmean + Nint.(electrodes{el}(1:end-5)).A.peaksem, ...
        Nint.(electrodes{el}(1:end-5)).A.peakmean + Nint.(electrodes{el}(1:end-5)).A.peaksem], [128/255, 201/255, 255/255], 'FaceAlpha', 0.3, 'EdgeColor', 'none')
    plot([0.5 1.5], [Nint.(electrodes{el}(1:end-5)).A.peakmean,Nint.(electrodes{el}(1:end-5)).A.peakmean], 'k')
    fill([2.5 3.5 3.5 2.5], [Nint.(electrodes{el}(1:end-5)).S0.peakmean - Nint.(electrodes{el}(1:end-5)).S0.peaksem, ...
        Nint.(electrodes{el}(1:end-5)).S0.peakmean - Nint.(electrodes{el}(1:end-5)).S0.peaksem, ...
        Nint.(electrodes{el}(1:end-5)).S0.peakmean + Nint.(electrodes{el}(1:end-5)).S0.peaksem, ...
        Nint.(electrodes{el}(1:end-5)).S0.peakmean + Nint.(electrodes{el}(1:end-5)).S0.peaksem], [128/255, 201/255, 255/255], 'FaceAlpha', 0.3, 'EdgeColor', 'none')
    plot([2.5 3.5], [Nint.(electrodes{el}(1:end-5)).S0.peakmean,Nint.(electrodes{el}(1:end-5)).S0.peakmean], 'k')
    fill([4.5 5.5 5.5 4.5], [Nint.(electrodes{el}(1:end-5)).S5.peakmean - Nint.(electrodes{el}(1:end-5)).S5.peaksem,...
        Nint.(electrodes{el}(1:end-5)).S5.peakmean - Nint.(electrodes{el}(1:end-5)).S5.peaksem, ...
        Nint.(electrodes{el}(1:end-5)).S5.peakmean + Nint.(electrodes{el}(1:end-5)).S5.peaksem, ...
        Nint.(electrodes{el}(1:end-5)).S5.peakmean + Nint.(electrodes{el}(1:end-5)).S5.peaksem], [128/255, 201/255, 255/255], 'FaceAlpha', 0.3, 'EdgeColor', 'none')
    plot([4.5 5.5], [Nint.(electrodes{el}(1:end-5)).S5.peakmean,Nint.(electrodes{el}(1:end-5)).S5.peakmean], 'k')
    fill([6.5 7.5 7.5 6.5], [Nint.(electrodes{el}(1:end-5)).S2.peakmean - Nint.(electrodes{el}(1:end-5)).S2.peaksem, ...
        Nint.(electrodes{el}(1:end-5)).S2.peakmean - Nint.(electrodes{el}(1:end-5)).S2.peaksem, ...
        Nint.(electrodes{el}(1:end-5)).S2.peakmean + Nint.(electrodes{el}(1:end-5)).S2.peaksem, ...
        Nint.(electrodes{el}(1:end-5)).S2.peakmean + Nint.(electrodes{el}(1:end-5)).S2.peaksem], [128/255, 201/255, 255/255], 'FaceAlpha', 0.3, 'EdgeColor', 'none')
    plot([6.5 7.5], [Nint.(electrodes{el}(1:end-5)).S2.peakmean,Nint.(electrodes{el}(1:end-5)).S2.peakmean], 'k')
    fill([8.5 9.5 9.5 8.5], [Nint.(electrodes{el}(1:end-5)).S6.peakmean - Nint.(electrodes{el}(1:end-5)).S6.peaksem, ...
        Nint.(electrodes{el}(1:end-5)).S6.peakmean - Nint.(electrodes{el}(1:end-5)).S6.peaksem, ...
        Nint.(electrodes{el}(1:end-5)).S6.peakmean + Nint.(electrodes{el}(1:end-5)).S6.peaksem, ...
        Nint.(electrodes{el}(1:end-5)).S6.peakmean + Nint.(electrodes{el}(1:end-5)).S6.peaksem], [128/255, 201/255, 255/255], 'FaceAlpha', 0.3, 'EdgeColor', 'none')
    plot([8.5 9.5], [Nint.(electrodes{el}(1:end-5)).S6.peakmean,Nint.(electrodes{el}(1:end-5)).S6.peakmean], 'k')
    
    xlim([0,10])
    ylim([-15 -5])
    xticks([1:2:9])
    xticklabels({'Auditory-only','SOA 0','SOA 50','SOA 200', 'SOA 600'})
    ylabel('mean amplitude [µV]')
    xlabel('condition')
    title([EEG_data{el+6,1}(1:end-5) ' | N1 amplitude'])
    
    subplot(1,2,2) % latency
    hold on
    fill([0.5 1.5 1.5 0.5], [Nint.(electrodes{el}(1:end-5)).A.latmean - Nint.(electrodes{el}(1:end-5)).A.latsem, ....
        Nint.(electrodes{el}(1:end-5)).A.latmean - Nint.(electrodes{el}(1:end-5)).A.latsem, ...
        Nint.(electrodes{el}(1:end-5)).A.latmean + Nint.(electrodes{el}(1:end-5)).A.latsem, ...
        Nint.(electrodes{el}(1:end-5)).A.latmean + Nint.(electrodes{el}(1:end-5)).A.latsem], [128/255, 201/255, 255/255], 'FaceAlpha', 0.3, 'EdgeColor', 'none')
    plot([0.5 1.5], [Nint.(electrodes{el}(1:end-5)).A.latmean,Nint.(electrodes{el}(1:end-5)).A.latmean], 'k')
    fill([2.5 3.5 3.5 2.5], [Nint.(electrodes{el}(1:end-5)).S0.latmean - Nint.(electrodes{el}(1:end-5)).S0.latsem, ...
        Nint.(electrodes{el}(1:end-5)).S0.latmean - Nint.(electrodes{el}(1:end-5)).S0.latsem, ...
        Nint.(electrodes{el}(1:end-5)).S0.latmean + Nint.(electrodes{el}(1:end-5)).S0.latsem, ...
        Nint.(electrodes{el}(1:end-5)).S0.latmean + Nint.(electrodes{el}(1:end-5)).S0.latsem], [128/255, 201/255, 255/255], 'FaceAlpha', 0.3, 'EdgeColor', 'none')
    plot([2.5 3.5], [Nint.(electrodes{el}(1:end-5)).S0.latmean,Nint.(electrodes{el}(1:end-5)).S0.latmean], 'k')
    fill([4.5 5.5 5.5 4.5], [Nint.(electrodes{el}(1:end-5)).S5.latmean - Nint.(electrodes{el}(1:end-5)).S5.latsem, ...
        Nint.(electrodes{el}(1:end-5)).S5.latmean - Nint.(electrodes{el}(1:end-5)).S5.latsem, ...
        Nint.(electrodes{el}(1:end-5)).S5.latmean + Nint.(electrodes{el}(1:end-5)).S5.latsem, ...
        Nint.(electrodes{el}(1:end-5)).S5.latmean + Nint.(electrodes{el}(1:end-5)).S5.latsem], [128/255, 201/255, 255/255], 'FaceAlpha', 0.3, 'EdgeColor', 'none')
    plot([4.5 5.5], [Nint.(electrodes{el}(1:end-5)).S5.latmean,Nint.(electrodes{el}(1:end-5)).S5.latmean], 'k')
    fill([6.5 7.5 7.5 6.5], [Nint.(electrodes{el}(1:end-5)).S2.latmean - Nint.(electrodes{el}(1:end-5)).S2.latsem, ...
        Nint.(electrodes{el}(1:end-5)).S2.latmean - Nint.(electrodes{el}(1:end-5)).S2.latsem, ...
        Nint.(electrodes{el}(1:end-5)).S2.latmean + Nint.(electrodes{el}(1:end-5)).S2.latsem, ...
        Nint.(electrodes{el}(1:end-5)).S2.latmean + Nint.(electrodes{el}(1:end-5)).S2.latsem], [128/255, 201/255, 255/255], 'FaceAlpha', 0.3, 'EdgeColor', 'none')
    plot([6.5 7.5], [Nint.(electrodes{el}(1:end-5)).S2.latmean,Nint.(electrodes{el}(1:end-5)).S2.latmean], 'k')
    fill([8.5 9.5 9.5 8.5], [Nint.(electrodes{el}(1:end-5)).S6.latmean - Nint.(electrodes{el}(1:end-5)).S6.latsem, ...
        Nint.(electrodes{el}(1:end-5)).S6.latmean - Nint.(electrodes{el}(1:end-5)).S6.latsem, ...
        Nint.(electrodes{el}(1:end-5)).S6.latmean + Nint.(electrodes{el}(1:end-5)).S6.latsem, ...
        Nint.(electrodes{el}(1:end-5)).S6.latmean + Nint.(electrodes{el}(1:end-5)).S6.latsem], [128/255, 201/255, 255/255], 'FaceAlpha', 0.3, 'EdgeColor', 'none')
    plot([8.5 9.5], [Nint.(electrodes{el}(1:end-5)).S6.latmean,Nint.(electrodes{el}(1:end-5)).S6.latmean], 'k')
    
    xlim([0,10])
    ylim([100 200])
    xticks([1:2:9])
    xticklabels({'Auditory-only','SOA 0','SOA 50','SOA 200', 'SOA 600'})
    ylabel('mean latency [ms]')
    xlabel('condition')
    title([EEG_data{el+6,1}(1:end-5) ' | N1 latency'])

    % figures P2
    set(0, 'CurrentFigure', figs(2,el))
    subplot(1,2,1) % peak
    hold on
    fill([0.5 1.5 1.5 0.5], [Pint.(electrodes{el}(1:end-5)).A.peakmean - Pint.(electrodes{el}(1:end-5)).A.peaksem, ...
        Pint.(electrodes{el}(1:end-5)).A.peakmean - Pint.(electrodes{el}(1:end-5)).A.peaksem, ...
        Pint.(electrodes{el}(1:end-5)).A.peakmean + Pint.(electrodes{el}(1:end-5)).A.peaksem, ...
        Pint.(electrodes{el}(1:end-5)).A.peakmean + Pint.(electrodes{el}(1:end-5)).A.peaksem], [128/255, 201/255, 255/255], 'FaceAlpha', 0.3, 'EdgeColor', 'none')
    plot([0.5 1.5], [Pint.(electrodes{el}(1:end-5)).A.peakmean,Pint.(electrodes{el}(1:end-5)).A.peakmean], 'k')
    fill([2.5 3.5 3.5 2.5], [Pint.(electrodes{el}(1:end-5)).S0.peakmean - Pint.(electrodes{el}(1:end-5)).S0.peaksem, ...
        Pint.(electrodes{el}(1:end-5)).S0.peakmean - Pint.(electrodes{el}(1:end-5)).S0.peaksem, ...
        Pint.(electrodes{el}(1:end-5)).S0.peakmean + Pint.(electrodes{el}(1:end-5)).S0.peaksem, ...
        Pint.(electrodes{el}(1:end-5)).S0.peakmean + Pint.(electrodes{el}(1:end-5)).S0.peaksem], [128/255, 201/255, 255/255], 'FaceAlpha', 0.3, 'EdgeColor', 'none')
    plot([2.5 3.5], [Pint.(electrodes{el}(1:end-5)).S0.peakmean,Pint.(electrodes{el}(1:end-5)).S0.peakmean], 'k')
    fill([4.5 5.5 5.5 4.5], [Pint.(electrodes{el}(1:end-5)).S5.peakmean - Pint.(electrodes{el}(1:end-5)).S5.peaksem,...
        Pint.(electrodes{el}(1:end-5)).S5.peakmean - Pint.(electrodes{el}(1:end-5)).S5.peaksem, ...
        Pint.(electrodes{el}(1:end-5)).S5.peakmean + Pint.(electrodes{el}(1:end-5)).S5.peaksem, ...
        Pint.(electrodes{el}(1:end-5)).S5.peakmean + Pint.(electrodes{el}(1:end-5)).S5.peaksem], [128/255, 201/255, 255/255], 'FaceAlpha', 0.3, 'EdgeColor', 'none')
    plot([4.5 5.5], [Pint.(electrodes{el}(1:end-5)).S5.peakmean,Pint.(electrodes{el}(1:end-5)).S5.peakmean], 'k')
    fill([6.5 7.5 7.5 6.5], [Pint.(electrodes{el}(1:end-5)).S2.peakmean - Pint.(electrodes{el}(1:end-5)).S2.peaksem, ...
        Pint.(electrodes{el}(1:end-5)).S2.peakmean - Pint.(electrodes{el}(1:end-5)).S2.peaksem, ...
        Pint.(electrodes{el}(1:end-5)).S2.peakmean + Pint.(electrodes{el}(1:end-5)).S2.peaksem, ...
        Pint.(electrodes{el}(1:end-5)).S2.peakmean + Pint.(electrodes{el}(1:end-5)).S2.peaksem], [128/255, 201/255, 255/255], 'FaceAlpha', 0.3, 'EdgeColor', 'none')
    plot([6.5 7.5], [Pint.(electrodes{el}(1:end-5)).S2.peakmean,Pint.(electrodes{el}(1:end-5)).S2.peakmean], 'k')
    fill([8.5 9.5 9.5 8.5], [Pint.(electrodes{el}(1:end-5)).S6.peakmean - Pint.(electrodes{el}(1:end-5)).S6.peaksem, ...
        Pint.(electrodes{el}(1:end-5)).S6.peakmean - Pint.(electrodes{el}(1:end-5)).S6.peaksem, ...
        Pint.(electrodes{el}(1:end-5)).S6.peakmean + Pint.(electrodes{el}(1:end-5)).S6.peaksem, ...
        Pint.(electrodes{el}(1:end-5)).S6.peakmean + Pint.(electrodes{el}(1:end-5)).S6.peaksem], [128/255, 201/255, 255/255], 'FaceAlpha', 0.3, 'EdgeColor', 'none')
    plot([8.5 9.5], [Pint.(electrodes{el}(1:end-5)).S6.peakmean,Pint.(electrodes{el}(1:end-5)).S6.peakmean], 'k')
    
    xlim([0,10])
    ylim([0 15])
    xticks([1:2:9])
    xticklabels({'Auditory-only','SOA 0','SOA 50','SOA 200', 'SOA 600'})
    ylabel('mean amplitude [µV]')
    xlabel('condition')
    title([EEG_data{el+6,1}(1:end-5) ' | P2 amplitude'])
    
    subplot(1,2,2) % latency
    hold on
    fill([0.5 1.5 1.5 0.5], [Pint.(electrodes{el}(1:end-5)).A.latmean - Pint.(electrodes{el}(1:end-5)).A.latsem, ....
        Pint.(electrodes{el}(1:end-5)).A.latmean - Pint.(electrodes{el}(1:end-5)).A.latsem, ...
        Pint.(electrodes{el}(1:end-5)).A.latmean + Pint.(electrodes{el}(1:end-5)).A.latsem, ...
        Pint.(electrodes{el}(1:end-5)).A.latmean + Pint.(electrodes{el}(1:end-5)).A.latsem], [128/255, 201/255, 255/255], 'FaceAlpha', 0.3, 'EdgeColor', 'none')
    plot([0.5 1.5], [Pint.(electrodes{el}(1:end-5)).A.latmean,Pint.(electrodes{el}(1:end-5)).A.latmean], 'k')
    fill([2.5 3.5 3.5 2.5], [Pint.(electrodes{el}(1:end-5)).S0.latmean - Pint.(electrodes{el}(1:end-5)).S0.latsem, ...
        Pint.(electrodes{el}(1:end-5)).S0.latmean - Pint.(electrodes{el}(1:end-5)).S0.latsem, ...
        Pint.(electrodes{el}(1:end-5)).S0.latmean + Pint.(electrodes{el}(1:end-5)).S0.latsem, ...
        Pint.(electrodes{el}(1:end-5)).S0.latmean + Pint.(electrodes{el}(1:end-5)).S0.latsem], [128/255, 201/255, 255/255], 'FaceAlpha', 0.3, 'EdgeColor', 'none')
    plot([2.5 3.5], [Pint.(electrodes{el}(1:end-5)).S0.latmean,Pint.(electrodes{el}(1:end-5)).S0.latmean], 'k')
    fill([4.5 5.5 5.5 4.5], [Pint.(electrodes{el}(1:end-5)).S5.latmean - Pint.(electrodes{el}(1:end-5)).S5.latsem, ...
        Pint.(electrodes{el}(1:end-5)).S5.latmean - Pint.(electrodes{el}(1:end-5)).S5.latsem, ...
        Pint.(electrodes{el}(1:end-5)).S5.latmean + Pint.(electrodes{el}(1:end-5)).S5.latsem, ...
        Pint.(electrodes{el}(1:end-5)).S5.latmean + Pint.(electrodes{el}(1:end-5)).S5.latsem], [128/255, 201/255, 255/255], 'FaceAlpha', 0.3, 'EdgeColor', 'none')
    plot([4.5 5.5], [Pint.(electrodes{el}(1:end-5)).S5.latmean,Pint.(electrodes{el}(1:end-5)).S5.latmean], 'k')
    fill([6.5 7.5 7.5 6.5], [Pint.(electrodes{el}(1:end-5)).S2.latmean - Pint.(electrodes{el}(1:end-5)).S2.latsem, ...
        Pint.(electrodes{el}(1:end-5)).S2.latmean - Pint.(electrodes{el}(1:end-5)).S2.latsem, ...
        Pint.(electrodes{el}(1:end-5)).S2.latmean + Pint.(electrodes{el}(1:end-5)).S2.latsem, ...
        Pint.(electrodes{el}(1:end-5)).S2.latmean + Pint.(electrodes{el}(1:end-5)).S2.latsem], [128/255, 201/255, 255/255], 'FaceAlpha', 0.3, 'EdgeColor', 'none')
    plot([6.5 7.5], [Pint.(electrodes{el}(1:end-5)).S2.latmean,Pint.(electrodes{el}(1:end-5)).S2.latmean], 'k')
    fill([8.5 9.5 9.5 8.5], [Pint.(electrodes{el}(1:end-5)).S6.latmean - Pint.(electrodes{el}(1:end-5)).S6.latsem, ...
        Pint.(electrodes{el}(1:end-5)).S6.latmean - Pint.(electrodes{el}(1:end-5)).S6.latsem, ...
        Pint.(electrodes{el}(1:end-5)).S6.latmean + Pint.(electrodes{el}(1:end-5)).S6.latsem, ...
        Pint.(electrodes{el}(1:end-5)).S6.latmean + Pint.(electrodes{el}(1:end-5)).S6.latsem], [128/255, 201/255, 255/255], 'FaceAlpha', 0.3, 'EdgeColor', 'none')
    plot([8.5 9.5], [Pint.(electrodes{el}(1:end-5)).S6.latmean,Pint.(electrodes{el}(1:end-5)).S6.latmean], 'k')
    
    xlim([0,10])
    ylim([150 300])
    xticks([1:2:9])
    xticklabels({'Auditory-only','SOA 0','SOA 50','SOA 200', 'SOA 600'})
    ylabel('mean latency [ms]')
    xlabel('condition')
    title([EEG_data{el+6,1}(1:end-5) ' | P2 latency'])
end
  
Nint.FCz.AnovaPeak.df = [4,64];
Nint.FCz.AnovaPeak.F = 1.140;
Nint.FCz.AnovaPeak.p = 0.3456;

Pint.FCz.AnovaPeak.df = [4,64];
Pint.FCz.AnovaPeak.F = 4.336;
Pint.FCz.AnovaPeak.p = 0.0036;

Nint.FCz.AnovaLat.df = [4,64];
Nint.FCz.AnovaLat.F = 2.671;
Nint.FCz.AnovaLat.p = 0.0399;

Pint.FCz.AnovaLat.df = [4,64];
Pint.FCz.AnovaLat.F = 0.767;
Pint.FCz.AnovaLat.p = 0.5506;

Nint.Fz.AnovaPeak.df = [4,64];
Nint.Fz.AnovaPeak.F = 1.891;
Nint.Fz.AnovaPeak.p = 0.1229;

Pint.Fz.AnovaPeak.df = [4,64];
Pint.Fz.AnovaPeak.F = 1.523;
Pint.Fz.AnovaPeak.p = 0.2059;

Nint.Fz.AnovaLat.df = [4,64];
Nint.Fz.AnovaLat.F = 2.369;
Nint.Fz.AnovaLat.p = 0.0618;

Pint.Fz.AnovaLat.df = [4,64];
Pint.Fz.AnovaLat.F = 1.642;
Pint.Fz.AnovaLat.p = 0.1746;

Nint.Cz.AnovaPeak.df = [4,64];
Nint.Cz.AnovaPeak.F = 1.309;
Nint.Cz.AnovaPeak.p = 0.2761;

Pint.Cz.AnovaPeak.df = [4,64];
Pint.Cz.AnovaPeak.F = 8.745;
Pint.Cz.AnovaPeak.p = 0.0000;

Nint.Cz.AnovaLat.df = [4,64];
Nint.Cz.AnovaLat.F = 6.657;
Nint.Cz.AnovaLat.p = 0.0002;

Pint.Cz.AnovaLat.df = [4,64];
Pint.Cz.AnovaLat.F = 1.536;
Pint.Cz.AnovaLat.p = 0.2025;

% Nint.M1.AnovaPeak.df = [4,52];
% Nint.M1.AnovaPeak.F = 0.611;
% Nint.M1.AnovaPeak.p = 0.6563;
% 
% Pint.M1.AnovaPeak.df = [4,52];
% Pint.M1.AnovaPeak.F = 1.542;
% Pint.M1.AnovaPeak.p = 0.2038;
% 
% Nint.M1.AnovaLat.df = [4,52];
% Nint.M1.AnovaLat.F = 0.827;
% Nint.M1.AnovaLat.p = 0.5142;
% 
% Pint.M1.AnovaLat.df = [4,52];
% Pint.M1.AnovaLat.F = 1.579;
% Pint.M1.AnovaLat.p = 0.1937;

% Signifikanzen
% set(0, 'CurrentFigure', n1) % N FCz

% N amplitude
% n.s., A vs. 600 Trend (unkorrigiert)
% subplot(1,2,1)
% hold on

% N latency
% A vs. 0
% subplot(1,2,2)
% hold on
% plot([1 1], [160 162], 'k')
% plot([2.9 2.9], [160 162], 'k')
% plot([1 2.9], [162 162], 'k')
% text(2, 163.5, {'*'}, 'center', 'Color', 'r', 'LineWidth', 1)
% % 0 vs. 50
% plot([3.1 3.1], [160 162], 'k')
% plot([5 5], [160 162], 'k')
% plot([3.1 5], [162 162], 'k')
% text(4, 163.5, {'*'}, 'center', 'Color', 'r', 'LineWidth', 1)
% % 0 vs. 200
% plot([3 3], [166 168], 'k')
% plot([7 7], [166 168], 'k')
% plot([3 7], [168 168], 'k')
% text(5, 169.5, {'*'}, 'center', 'Color', 'r', 'LineWidth', 1)
% % 0 vs. 600
% plot([3 3], [173 175], 'k')
% plot([9 9], [173 175], 'k')
% plot([3 9], [175 175], 'k')
% text(6, 176.5, {'**'}, 'center', 'Color', 'r', 'LineWidth', 1)

%set(0, 'CurrentFigure', n2) % N Fz
% amplitude
% n.s.

% Latency
% 0 vs. 200: Trend

% set(0, 'CurrentFigure', n3) % N Cz
% subplot(1,2,1)
% hold on
% % amplitude
% % A vs. 600
% plot([1 9], [-6 -6], 'k')
% plot([1 1], [-6.2 -6], 'k')
% plot([9 9], [-6.2 -6], 'k')
% text(5, -5.8, {'*'}, 'center', 'Color', 'r', 'LineWidth', 1)
% 
% % Latency
% % 0 vs. 200: Trend
% % 0 vs. 50
% subplot(1,2,2)
% hold on
% plot([3 5], [162 162], 'k')
% plot([3 3], [159 162], 'k')
% plot([5 5], [159 162], 'k')
% text(4, 163.5, {'*'}, 'center', 'Color', 'r', 'LineWidth', 1)
% % 0 vs. 600
% plot([3 9], [171 171], 'k')
% plot([3 3], [169 171], 'k')
% plot([9 9], [169 171], 'k')
% text(6, 172.5, {'*'}, 'center', 'Color', 'r', 'LineWidth', 1)
% 
% 
% % set(0, 'CurrentFigure', p1) % P FCz
% % subplot(1,2,1)
% % hold on
% % amplitude
% % 50 vs. 200: Trend
% 
% % subplot(1,2,2)
% % hold on
% % Latency
% % 0 vs. 50: Trend
% 
% 
% % set(0, 'CurrentFigure', p2) % P Fz
% % amplitude
% % subplot(1,2,1)
% % hold on
% % n.s.
% 
% % Latency
% % subplot(1,2,2)
% % hold on
% % 0 vs. 50: Trend
% 
% set(0, 'CurrentFigure', p3) % P Cz
% % amplitude
% % 0 vs. 200: Trend
% % 0 vs. 600: Trend
% % 50 vs. 600: Trend
% % 50 vs. 200:
% subplot(1,2,1)
% hold on
% plot([5 7], [11 11], 'k')
% plot([5 5], [10.5 11], 'k')
% plot([7 7], [10.5 11], 'k')
% text(6, 11.2, {'*'}, 'center', 'Color', 'r', 'LineWidth', 1)
% 
% 
% % Latency
% % A vs. 0: Trend
% % 50 vs. 200: Trend
% % 0 vs. 600:
% subplot(1,2,2)
% hold on
% plot([3 9], [253 253], 'k')
% plot([3 3], [250 253], 'k')
% plot([9 9], [250 253], 'k')
% text(6, 254.5, {'*'}, 'center', 'Color', 'r', 'LineWidth', 1)
% % 50 vs. 600:
% plot([5 9], [242 242], 'k')
% plot([5 5], [239 242], 'k')
% plot([9 9], [239 242], 'k')
% text(7, 243.5, {'*'}, 'center', 'Color', 'r', 'LineWidth', 1)
% 
% set(0, 'CurrentFigure', n4) % M1
% subplot(1,2,1)
% ylim([-10 0])
% 
% set(0, 'CurrentFigure', p4) % M1
% subplot(1,2,1)
% ylim([0 10])

%cd('../Figures')
saveas(n1, 'PeakLatency_N1_FCz.png')
saveas(n2, 'PeakLatency_N1_Fz.png')
saveas(n3, 'PeakLatency_N1_Cz.png')
saveas(p1, 'PeakLatency_P2_FCz.png')
saveas(p2, 'PeakLatency_P2_Fz.png')
saveas(p3, 'PeakLatency_P2_Cz.png')
% 
% saveas(n4, 'PeakLatency_N1_M1.png')
% saveas(p4, 'PeakLatency_P2_M1.png')

set(0, 'CurrentFigure', n1)
hold on
scatter([ones(1,Nsub)], [Nint.FCz.A.local.latency],25,  [128/255, 201/255, 255/255])
scatter([ones(1,Nsub)*3], [Nint.FCz.S0.local.latency],25,  [128/255, 201/255, 255/255])
scatter([ones(1,Nsub)*5], [Nint.FCz.S5.local.latency],25,  [128/255, 201/255, 255/255])
scatter([ones(1,Nsub)*7], [Nint.FCz.S2.local.latency],25,  [128/255, 201/255, 255/255])
scatter([ones(1,Nsub)*9], [Nint.FCz.S6.local.latency],25,  [128/255, 201/255, 255/255])
saveas(n1, 'PeakLatency_mitpeaks_N1_FCz.png')
set(0, 'CurrentFigure', n2)
hold on
scatter([ones(1,Nsub)], [Nint.Fz.A.local.latency],25,  [128/255, 201/255, 255/255])
scatter([ones(1,Nsub)*3], [Nint.Fz.S0.local.latency],25,  [128/255, 201/255, 255/255])
scatter([ones(1,Nsub)*5], [Nint.Fz.S5.local.latency],25,  [128/255, 201/255, 255/255])
scatter([ones(1,Nsub)*7], [Nint.Fz.S2.local.latency],25,  [128/255, 201/255, 255/255])
scatter([ones(1,Nsub)*9], [Nint.Fz.S6.local.latency],25,  [128/255, 201/255, 255/255])
saveas(n2, 'PeakLatency_mitpeaks_N1_Fz.png')
set(0, 'CurrentFigure', n3)
hold on
scatter([ones(1,Nsub)], [Nint.Cz.A.local.latency],25,  [128/255, 201/255, 255/255])
scatter([ones(1,Nsub)*3], [Nint.Cz.S0.local.latency],25,  [128/255, 201/255, 255/255])
scatter([ones(1,Nsub)*5], [Nint.Cz.S5.local.latency],25,  [128/255, 201/255, 255/255])
scatter([ones(1,Nsub)*7], [Nint.Cz.S2.local.latency],25,  [128/255, 201/255, 255/255])
scatter([ones(1,Nsub)*9], [Nint.Cz.S6.local.latency],25,  [128/255, 201/255, 255/255])
saveas(n3, 'PeakLatency_mitpeaks_N1_Cz.png')
cd('../EEG')



%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% --------------------- 8.0 Regressionen ---------------------------- %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% - 2 Methoden der Regression ausprobieren
% - jeweils für N1 und P2


%%% ------------------------ 8.1 PSE, JND ----------------------------- %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PSE0_MA, PSE50_MA, PSE200_MA, PSE600_MA, PSE_A
% erstmal nur für FCz
pers_peak = zeros(5*Nsub,2); % personal N peak +  p peak for each SOA + A (erst A dann SOAs, alles pro Proband zusammen)
pred_pse =  zeros(5*Nsub,Nsub+1);
pred_jnd =  zeros(5*Nsub,Nsub+1);

idx = 1:5:(5*Nsub);
for sb = 1:Nsub
    pers_peak(idx(sb),1) = Nint.Fz.A.local.value(sb);
    pers_peak(idx(sb)+1,1) = Nint.Fz.S0.local.value(sb);
    pers_peak(idx(sb)+2,1) = Nint.Fz.S5.local.value(sb);
    pers_peak(idx(sb)+3,1) = Nint.Fz.S2.local.value(sb);
    pers_peak(idx(sb)+4,1) = Nint.Fz.S6.local.value(sb);
    
    pers_peak(idx(sb),2) = Pint.Fz.A.local.value(sb);
    pers_peak(idx(sb)+1,2) = Pint.Fz.S0.local.value(sb);
    pers_peak(idx(sb)+2,2) = Pint.Fz.S5.local.value(sb);
    pers_peak(idx(sb)+3,2) = Pint.Fz.S2.local.value(sb);
    pers_peak(idx(sb)+4,2) = Pint.Fz.S6.local.value(sb);

    pred_pse(idx(sb),1) = PSE_A(sb);
    pred_pse(idx(sb)+1,1) = PSE0_MA(sb);
    pred_pse(idx(sb)+2,1) = PSE50_MA(sb);
    pred_pse(idx(sb)+3,1) = PSE200_MA(sb);
    pred_pse(idx(sb)+4,1) = PSE600_MA(sb);
    
    pred_pse(idx(sb),sb+1) = 1;
    pred_pse(idx(sb)+1,sb+1) = 1;
    pred_pse(idx(sb)+2,sb+1) = 1;
    pred_pse(idx(sb)+3,sb+1) = 1;
    pred_pse(idx(sb)+4,sb+1) = 1;

    pred_jnd(idx(sb),1) = JND_A(sb);
    pred_jnd(idx(sb)+1,1) = JND0_MA(sb);
    pred_jnd(idx(sb)+2,1) = JND50_MA(sb);
    pred_jnd(idx(sb)+3,1) = JND200_MA(sb);
    pred_jnd(idx(sb)+4,1) = JND600_MA(sb);

    pred_jnd(idx(sb),sb+1) = 1;
    pred_jnd(idx(sb)+1,sb+1) = 1;
    pred_jnd(idx(sb)+2,sb+1) = 1;
    pred_jnd(idx(sb)+3,sb+1) = 1;
    pred_jnd(idx(sb)+4,sb+1) = 1;
end
% regression with dummies and uncorrected data
% !!!!!!!!!! VERALTET !!!!!!!!!!!!!!!!
[regressions{1,1:4}] = deal('PSE,N', 'b', 'r', 'stats(R², F, p)'); % b = coefficients, r = residuals, stats  (R²,F,p,estimate of error variance)
[regressions{3,1:4}] = deal('PSE,P', 'b', 'r', 'stats(R², F, p)'); % b = coefficients, r = residuals
[regressions{5,1:4}] = deal('JND,N', 'b', 'r', 'stats(R², F, p)'); % b = coefficients, r = residuals
[regressions{7,1:4}] = deal('JND,P', 'b', 'r', 'stats(R², F, p)'); % b = coefficients, r = residuals
% PSE, N1
[regressions{2,2}, ~, regressions{2,3}, ~, regressions{2,4}] = regress(pers_peak(:,1),pred_pse);

% PSE, P2
[regressions{4,2}, ~, regressions{4,3}, ~, regressions{4,4}] = regress(pers_peak(:,2),pred_pse);

% JND, N1
[regressions{6,2}, ~, regressions{6,3}, ~, regressions{6,4}] = regress(pers_peak(:,1),pred_jnd);

% JND, P2
[regressions{8,2}, ~, regressions{8,3}, ~, regressions{8,4}] = regress(pers_peak(:,2),pred_jnd);
% !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

% Varianzkorrektur peak
% N1
pers_peak(1,4) = 1;
% SM
pers_peak(1,5:4+Nsub) = [mean(pers_peak(1:5,1)),mean(pers_peak(6:10,1)),mean(pers_peak(11:15,1)),...
    mean(pers_peak(16:20,1)),mean(pers_peak(21:25,1)),mean(pers_peak(26:30,1)),...
    mean(pers_peak(32:36,1)),mean(pers_peak(37:40,1)),mean(pers_peak(41:45,1)),...
    mean(pers_peak(46:50,1)),mean(pers_peak(51:55,1)),mean(pers_peak(56:60,1)),...
    mean(pers_peak(61:65,1)),mean(pers_peak(66:70,1)),mean(pers_peak(71:75,1)),...
    mean(pers_peak(76:80,1)),mean(pers_peak(81:85,1)),mean(pers_peak(86:90,1)),...
    mean(pers_peak(91:95,1)),mean(pers_peak(96:100,1)),mean(pers_peak(101:105,1))];
% GM
pers_peak(2,5) = mean(pers_peak(1,5:end));
% SM-GM
pers_peak(3,5:4+Nsub) = pers_peak(1,5:4+Nsub) - pers_peak(2,5);

% P2
pers_peak(4,4) = 2;
pers_peak(4,5:4+Nsub) = [mean(pers_peak(1:5,2)),mean(pers_peak(6:10,2)),mean(pers_peak(11:15,2)),...
    mean(pers_peak(16:20,2)),mean(pers_peak(21:25,2)),mean(pers_peak(26:30,2)),...
    mean(pers_peak(32:36,2)),mean(pers_peak(37:40,2)),mean(pers_peak(41:45,2)),...
    mean(pers_peak(46:50,2)),mean(pers_peak(51:55,2)),mean(pers_peak(56:60,2)),...
    mean(pers_peak(61:65,2)),mean(pers_peak(66:70,2)),mean(pers_peak(71:75,2)),...
    mean(pers_peak(76:80,2)),mean(pers_peak(81:85,2)),mean(pers_peak(86:90,2)),...
    mean(pers_peak(91:95,2)),mean(pers_peak(96:100,2)),mean(pers_peak(101:105,2))];
% GM
pers_peak(5,5) = mean(pers_peak(4,5:4+Nsub));
%SM - GM
pers_peak(6,5:4+Nsub) = pers_peak(4,5:4+Nsub) - pers_peak(5,5);

pers_peakcorr = zeros(size(pers_peak,1),2);
for sb = 1:Nsub
    pers_peakcorr(idx(sb):idx(sb)+4,1) = pers_peak(idx(sb):idx(sb)+4,1) - pers_peak(3,sb+4); % N peak amplitude correction
    pers_peakcorr(idx(sb):idx(sb)+4,2) = pers_peak(idx(sb):idx(sb)+4,2) - pers_peak(6,sb+4); % P peak amplitude correction
end

% regression with corrected data + 1er Reihe
[regressions{9,1:4}] = deal('PSE,Ncorr', 'b', 'r', 'stats(R², F, p)'); % b = coefficients, r = residuals, stats 
[regressions{11,1:4}] = deal('PSE,Pcorr', 'b', 'r', 'stats(R², F, p)'); % b = coefficients, r = residuals
[regressions{13,1:4}] = deal('JND,Ncorr', 'b', 'r', 'stats(R², F, p)'); % b = coefficients, r = residuals
[regressions{15,1:4}] = deal('JND,Pcorr', 'b', 'r', 'stats(R², F, p)'); % b = coefficients, r = residuals
% PSE, N1
[regressions{10,2}, ~, regressions{10,3}, ~, regressions{10,4}] = regress(pers_peakcorr(:,1),[pred_pse(:,1),ones(Nsub*5,1)]);

% PSE, P2
[regressions{12,2}, ~, regressions{12,3}, ~, regressions{12,4}] = regress(pers_peakcorr(:,2),[pred_pse(:,1),ones(Nsub*5,1)]);

% JND, N1
[regressions{14,2}, ~, regressions{14,3}, ~, regressions{14,4}] = regress(pers_peakcorr(:,1),[pred_jnd(:,1),ones(Nsub*5,1)]);

% JND, P2
[regressions{16,2}, ~, regressions{16,3}, ~, regressions{16,4}] = regress(pers_peakcorr(:,2),[pred_jnd(:,1),ones(Nsub*5,1)]);



% Figures
figure('Position', [200, 150, 800, 600]) % PSE
subplot(2,1,1) % N peak
hold on
for sb = 1:Nsub
    scatter(pred_pse(idx(sb):idx(sb)+4,1),pers_peak(idx(sb):idx(sb)+4,1)-pers_peak(3,4+sb),'b')
end
ylabel('personal peak [µV]')
xlabel('PSE [db SPL]')
title('N1 peak | all SOAs | all subjects')
subplot(2,1,2)
hold on
for sb = 1:Nsub
    scatter(pred_pse(idx(sb):idx(sb)+4,1),pers_peak(idx(sb):idx(sb)+4,2)-pers_peak(6,4+sb),'b')
end
ylabel('personal peak [µV]')
xlabel('PSE [db SPL]')
title('P2 peak | all SOAs | all subjects')

%cd('../Figures')
saveas(gcf, 'regression_peakPSE_Fz.png')

figure('Position', [200, 150, 800, 600]) % PSE
subplot(2,1,1) % N peak
hold on
for sb = 1:Nsub
    scatter(pred_jnd(idx(sb):idx(sb)+4,1),pers_peak(idx(sb):idx(sb)+4,1)-pers_peak(3,4+sb),'b')
end
ylabel('personal peak amplitude [µV]')
xlabel('JND [db SPL]')
title('N1 peak | all SOAs | all subjects')
subplot(2,1,2)
hold on
for sb=1:Nsub
    scatter(pred_jnd(idx(sb):idx(sb)+4,1),pers_peak(idx(sb):idx(sb)+4,2)-pers_peak(6,4+sb),'b')
end
ylabel('personal peak amplitude [µV]')
xlabel('JND [db SPL]')
title('P2 peak | all SOAs | all subjects')

saveas(gcf, 'regression_peakJND_Fz.png')
cd('../EEG')


% peak differenz korrelieren mit pse differenz zwischen MA und A
% soa 0 vs. soa 600 self vs. external differenzen psychohysik vs. elektro
% keine Varianzkorrektur nötig, da durch Differenz schon normiert(?)
[diff_regressions{1,2:4}] = deal('FCz', 'Fz', 'Cz');
[diff_regressions{2:9,1}] = deal('PSE MA-A', 'PSE 0-600', 'JND MA-A', 'JND 0-600', 'N MA-A', 'N 0-600', 'P MA-A', 'P 0-600');
[diff_regressions{10:18,1}] = deal('Regressions (R²,F,p)','PSE vs N cond', 'PSE vs. N soa', 'PSE vs P cond', 'PSE vs. P soa', 'JND vs N cond', 'JND vs. N soa', 'JND vs P cond', 'JND vs. P soa');
   
for el = 1:3
    elec = electrodes{el}(1:end-5);
    for sb = 1:Nsub
        % Psycho
        diff_regressions{2,el+1}(sb) = PSE0_MA(sb)-PSE_A(sb);
        diff_regressions{3,el+1}(sb) = PSE0_MA(sb)-PSE600_MA(sb);
        diff_regressions{4,el+1}(sb) = JND0_MA(sb)-JND_A(sb);
        diff_regressions{5,el+1}(sb) = JND0_MA(sb)-JND600_MA(sb);
        % N peak
        diff_regressions{6,el+1}(sb) = Nint.(elec).S0.local.value(sb)-Nint.(elec).A.local.value(sb);
        diff_regressions{7,el+1}(sb) = Nint.(elec).S0.local.value(sb)-Nint.(elec).S6.local.value(sb);
        diff_regressions{8,el+1}(sb) = Pint.(elec).S0.local.value(sb)-Pint.(elec).A.local.value(sb);
        diff_regressions{9,el+1}(sb) = Pint.(elec).S0.local.value(sb)-Pint.(elec).S6.local.value(sb);
    end
    % Regressionen
    [~,~,~,~,diff_regressions{11,el+1}] = regress(diff_regressions{6,el+1}', [diff_regressions{2,el+1}',ones(Nsub,1)]);
    [~,~,~,~,diff_regressions{12,el+1}] = regress(diff_regressions{7,el+1}', [diff_regressions{3,el+1}',ones(Nsub,1)]);
    [~,~,~,~,diff_regressions{13,el+1}] = regress(diff_regressions{8,el+1}', [diff_regressions{2,el+1}',ones(Nsub,1)]);
    [~,~,~,~,diff_regressions{14,el+1}] = regress(diff_regressions{9,el+1}', [diff_regressions{3,el+1}',ones(Nsub,1)]);
    [~,~,~,~,diff_regressions{15,el+1}] = regress(diff_regressions{6,el+1}', [diff_regressions{4,el+1}',ones(Nsub,1)]);
    [~,~,~,~,diff_regressions{16,el+1}] = regress(diff_regressions{7,el+1}', [diff_regressions{5,el+1}',ones(Nsub,1)]);
    [~,~,~,~,diff_regressions{17,el+1}] = regress(diff_regressions{8,el+1}', [diff_regressions{4,el+1}',ones(Nsub,1)]);
    [~,~,~,~,diff_regressions{18,el+1}] = regress(diff_regressions{9,el+1}', [diff_regressions{5,el+1}',ones(Nsub,1)]); 
    
    % figure
%     figure()
%     subplot(2,2,1) % PSE vs. N MA vs. A 

end


%%% ---------------------- 8.1 Agency Rating -------------------------- %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pro SOA 1 agency rating, 1 N peak, 1 P peak
% -> pro subject 4 values (A separate?)
% corrected gor variance

% N1, P2 peak ohne A
cd('../Figures')
idx = 1:4:(4*Nsub);
channel = [21,5,14];
for el = 1:3
    elec = EEG_data{3,2}.EEG.chanlocs(channel(el)).labels;
    regAGpeak.(elec)(idx+1,1) = subjects(1,2:end);
    [regAGpeak.(elec){1,2:7}] = deal('N peak', 'P peak', 'Agency Rating', 'N corr', 'P corr', 'AR corr');

    for sb = 1:Nsub
        regAGpeak.(elec){idx(sb)+1,2} = Nint.(elec).S0.local.value(sb);
        regAGpeak.(elec){idx(sb)+2,2} = Nint.(elec).S5.local.value(sb);
        regAGpeak.(elec){idx(sb)+3,2} = Nint.(elec).S2.local.value(sb);
        regAGpeak.(elec){idx(sb)+4,2} = Nint.(elec).S6.local.value(sb);
    
        smn(sb) = mean([regAGpeak.(elec){idx(sb)+1:idx(sb)+4,2}]);
    
        regAGpeak.(elec){idx(sb)+1,3} = Pint.(elec).S0.local.value(sb);
        regAGpeak.(elec){idx(sb)+2,3} = Pint.(elec).S5.local.value(sb);
        regAGpeak.(elec){idx(sb)+3,3} = Pint.(elec).S2.local.value(sb);
        regAGpeak.(elec){idx(sb)+4,3} = Pint.(elec).S6.local.value(sb);
    
        smp(sb) = mean([regAGpeak.(elec){idx(sb)+1:idx(sb)+4,3}]);
        
        regAGpeak.(elec){idx(sb)+1,4} = agency_rating{5,sb+1};
        regAGpeak.(elec){idx(sb)+2,4} = agency_rating{7,sb+1};
        regAGpeak.(elec){idx(sb)+3,4} = agency_rating{9,sb+1};
        regAGpeak.(elec){idx(sb)+4,4} = agency_rating{11,sb+1};
        
        regAGpeak.(elec){idx(sb)+1,7} = agency_rating{16,sb+1};
        regAGpeak.(elec){idx(sb)+2,7} = agency_rating{17,sb+1};
        regAGpeak.(elec){idx(sb)+3,7} = agency_rating{18,sb+1};
        regAGpeak.(elec){idx(sb)+4,7} = agency_rating{19,sb+1};
    end
    
    gmn = mean(smn);
    gmp = mean(smp);
    smgmn = smn - gmn;
    smgmp = smp - gmp;
    
    for sb = 1:Nsub
        for ss = 1:4
            regAGpeak.(elec){idx(sb)+ss,5} = regAGpeak.(elec){idx(sb)+ss,2} - smgmn(sb);
            regAGpeak.(elec){idx(sb)+ss,6} = regAGpeak.(elec){idx(sb)+ss,3} - smgmp(sb);
        end
    end
    
    [regAGpeak.(elec){1,8:11}] = deal('reg N', 'b', 'r', 'stats(R², F, p)'); % b = coefficients, r = residuals
    [regAGpeak.(elec){3,8:11}] = deal('reg P', 'b', 'r', 'stats(R², F, p)'); % b = coefficients, r = residuals
    
    % PSE, N1
    [regAGpeak.(elec){2,9}, ~, regAGpeak.(elec){2,10}, ~, regAGpeak.(elec){2,11}] = regress([regAGpeak.(elec){2:end,5}]',[[regAGpeak.(elec){2:end,7}]',ones(Nsub*4,1)]);
    [regAGpeak.(elec){4,9}, ~, regAGpeak.(elec){4,10}, ~, regAGpeak.(elec){4,11}] = regress([regAGpeak.(elec){2:end,6}]',[[regAGpeak.(elec){2:end,7}]',ones(Nsub*4,1)]);
    
    % figure
    figure('Position', [200, 150, 800, 600])
    subplot(2,1,1)
    scatter([regAGpeak.(elec){2:end,7}],[regAGpeak.(elec){2:end,5}],'b')
    title([elec '| N1 peak'])
    ylabel('personal peak amplitude [µV]')
    xlabel('agency rating')
    xlim([0 8])
    ylim([-15 -5])

    subplot(2,1,2) % P
    scatter([regAGpeak.(elec){2:end,7}],[regAGpeak.(elec){2:end,6}],'b')
    title([elec '| P2 peak'])
    ylabel('personal peak amplitude [µV]')
    xlabel('agency rating')
    xlim([0 8])
    ylim([0 15])

    saveas(gcf, ['Regression_PeakAgency_' elec '.png'])
end
cd('../EEG')





%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% ------------ 7.0 gleicher Ton, unterschiedliche Antwort ----------- %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
db74 = subjects(1,:);
[db74{2:3,1}] = deal('MA 1/2', 'A 1/2');
[db74{4:12,1}] = deal('FCz','outS', 'outA','Fz','outS', 'outA','Cz','outS', 'outA');

for sb = 1:Nsub
    % MA
    errMA = find([subjects{2,sb+1}.trial.valid] == 0);
    db74{2, sb+1}{1} = find([subjects{2,sb+1}.trial.valid] == 1 & [subjects{2,sb+1}.trial.level] == 74 & [subjects{2,sb+1}.trial.decision] == 0);
    db74{2, sb+1}{2} = find([subjects{2,sb+1}.trial.valid] == 1 & [subjects{2,sb+1}.trial.level] == 74 & [subjects{2,sb+1}.trial.decision] == 1);
   
    if isempty(errMA) == 0 % wenn es Fehler trials gab wurde die trial Nummerierung normal weitergeführt und ist dann um die error trials verschoben verglichen mit den EEG trials
        for r = 1:length(errMA)-1
            t1 = find(db74{2,sb+1}{1,1}(1,:) > errMA(r) & db74{2,sb+1}{1,1}(1,:) <= errMA(r+1));
            if isempty(t1) == 0 % wenn es keine trials zwischen 2 error trials gibt, wird das einfach übersprungen
                db74{2,sb+1}{1}(2,t1) = db74{2,sb+1}{1}(1,t1) - r;
            end

            t2 = find(db74{2,sb+1}{1,2}(1,:) > errMA(r) & db74{2,sb+1}{1,2}(1,:) <= errMA(r+1));
            if isempty(t2) == 0
                db74{2,sb+1}{2}(2,t2) = db74{2,sb+1}{2}(1,t2) - r;
            end

        end
        db74{2,sb+1}{1,1}(2,db74{2,sb+1}{1,1}(1,:)>errMA(end)) = db74{2,sb+1}{1,1}(1,db74{2,sb+1}{1,1}(1,:)>errMA(end))-length(errMA); % die Indizes nach dem letzten Fehlertrial
        db74{2,sb+1}{1,2}(2,db74{2,sb+1}{1,2}(1,:)>errMA(end)) = db74{2,sb+1}{1,2}(1,db74{2,sb+1}{1,2}(1,:)>errMA(end))-length(errMA);

        db74{2,sb+1}{1,1}(2,db74{2,sb+1}{1,1}(1,:)<=errMA(1)) = db74{2,sb+1}{1,1}(1,db74{2,sb+1}{1,1}(1,:)<=errMA(1)); % die Indizes vor dem ersten error trial bleiben gleich
        db74{2,sb+1}{1,2}(2,db74{2,sb+1}{1,2}(1,:)<=errMA(1)) = db74{2,sb+1}{1,2}(1,db74{2,sb+1}{1,2}(1,:)<=errMA(1));
    else
        db74{2,sb+1}{1,1}(2,:) = db74{2,sb+1}{1,1}(1,:);
        db74{2,sb+1}{1,2}(2,:) = db74{2,sb+1}{1,2}(1,:);
    end
    
    error.MA{sb} = errMA;

    % A
    errA = find([subjects{3,sb+1}.trial.valid] == 0);
    db74{3, sb+1}{1} = find([subjects{3,sb+1}.trial.valid] == 1 & [subjects{3,sb+1}.trial.level] == 74 & [subjects{3,sb+1}.trial.decision] == 0);
    db74{3, sb+1}{2} = find([subjects{3,sb+1}.trial.valid] == 1 & [subjects{3,sb+1}.trial.level] == 74 & [subjects{3,sb+1}.trial.decision] == 1);
    
    if isempty(errA) == 0 % wenn es Fehler trials gab wurde die trial Nummerierung normal weitergeführt und ist dann um die error trials verschoben verglichen mit den EEG trials
        for r = 1:length(errA)-1
            t1 = find(db74{3,sb+1}{1,1}(1,:) > errA(r) & db74{3,sb+1}{1,1}(1,:) <= errA(r+1));
            if isempty(t1) == 0 % wenn es keine trials zwischen 2 error trials gibt, wird das einfach übersprungen
                db74{3,sb+1}{1}(2,t1) = db74{3,sb+1}{1}(1,t1) - r;
            end

            t2 = find(db74{3,sb+1}{1,2}(1,:) > errA(r) & db74{3,sb+1}{1,2}(1,:) <= errA(r+1));
            if isempty(t2) == 0
                db74{3,sb+1}{2}(2,t2) = db74{3,sb+1}{2}(1,t2) - r;
            end

        end
        db74{3,sb+1}{1,1}(2,db74{3,sb+1}{1,1}(1,:)>errA(end)) = db74{3,sb+1}{1,1}(1,db74{3,sb+1}{1,1}(1,:)>errA(end))-length(errA); % die Indizes nach dem letzten Fehlertrial
        db74{3,sb+1}{1,2}(2,db74{3,sb+1}{1,2}(1,:)>errA(end)) = db74{3,sb+1}{1,2}(1,db74{3,sb+1}{1,2}(1,:)>errA(end))-length(errA);

        db74{3,sb+1}{1,1}(2,db74{3,sb+1}{1,1}(1,:)<=errA(1)) = db74{3,sb+1}{1,1}(1,db74{3,sb+1}{1,1}(1,:)<=errA(1)); % die Indizes vor dem ersten error trial bleiben gleich
        db74{3,sb+1}{1,2}(2,db74{3,sb+1}{1,2}(1,:)<=errA(1)) = db74{3,sb+1}{1,2}(1,db74{3,sb+1}{1,2}(1,:)<=errA(1));
    else
        db74{3,sb+1}{1,1}(2,:) = db74{3,sb+1}{1,1}(1,:);
        db74{3,sb+1}{1,2}(2,:) = db74{3,sb+1}{1,2}(1,:);
        
    end

    error.A{sb} = errA;
    
    % EEG data
    ErrTr = ErrorTrials(subject{sb});
    trS = {db74{2,sb+1}{1,1}(2,:), db74{2,sb+1}{1,2}(2,:)};
    trA = {db74{3,sb+1}{1,1}(2,:), db74{3,sb+1}{1,2}(2,:)};
    %FCz
    [outA, outS, EEGtime, N, SD] = Analyze_db74(21, subject{sb}, ErrTr, trA, trS);
    [db74{5:6,sb+1}] = deal(outS, outA);
    % mean per subject, for MA and A
    db74{5,sb+1}.mu1 = mean(db74{5,sb+1}.t1,1);
    db74{5,sb+1}.mu2 = mean(db74{5,sb+1}.t2,1);
    db74{6,sb+1}.mu1 = mean(db74{6,sb+1}.t1,1);
    db74{6,sb+1}.mu2 = mean(db74{6,sb+1}.t2,1);
    % peak + latency
    [db74{5,sb+1}.peakn1,i] = min(db74{5,sb+1}.mu1(peaks{11,6}(1):peaks{11,6}(2)));
    db74{5,sb+1}.latn1 = EEGtime(i+peaks{11,6}(1));
    [db74{5,sb+1}.peakn2,i] = min(db74{5,sb+1}.mu2(peaks{11,6}(1):peaks{11,6}(2)));
    db74{5,sb+1}.latn2 = EEGtime(i+peaks{11,6}(1));
    [db74{5,sb+1}.peakp1,i] = max(db74{5,sb+1}.mu1(peaks{12,6}(1):peaks{12,6}(2)));
    db74{5,sb+1}.latp1 = EEGtime(i+peaks{12,6}(1));
    [db74{5,sb+1}.peakp2,i] = max(db74{5,sb+1}.mu2(peaks{12,6}(1):peaks{12,6}(2)));
    db74{5,sb+1}.latp2 = EEGtime(i+peaks{12,6}(1));

    [db74{6,sb+1}.peakn1,i] = min(db74{6,sb+1}.mu1(peaks{11,6}(1):peaks{11,6}(2)));
    db74{6,sb+1}.latn1 = EEGtime(i+peaks{11,6}(1));
    [db74{6,sb+1}.peakn2,i] = min(db74{6,sb+1}.mu2(peaks{11,6}(1):peaks{11,6}(2)));
    db74{6,sb+1}.latn2 = EEGtime(i+peaks{11,6}(1));
    [db74{6,sb+1}.peakp1,i] = max(db74{6,sb+1}.mu1(peaks{12,6}(1):peaks{12,6}(2)));
    db74{6,sb+1}.latp1 = EEGtime(i+peaks{12,6}(1));
    [db74{6,sb+1}.peakp2,i] = max(db74{6,sb+1}.mu2(peaks{12,6}(1):peaks{12,6}(2)));
    db74{6,sb+1}.latp2 = EEGtime(i+peaks{12,6}(1));

    % Fz
    [outA, outS, EEGtime, N, SD] = Analyze_db74(5, subject{sb}, ErrTr, trA, trS);
    [db74{8:9,sb+1}] = deal(outS, outA);
    % mean per subject, for MA and A
    db74{8,sb+1}.mu1 = mean(db74{8,sb+1}.t1,1);
    db74{8,sb+1}.mu2 = mean(db74{8,sb+1}.t2,1);
    db74{9,sb+1}.mu1 = mean(db74{9,sb+1}.t1,1);
    db74{9,sb+1}.mu2 = mean(db74{9,sb+1}.t2,1);
    % peak + latency
    [db74{8,sb+1}.peakn1,i] = min(db74{8,sb+1}.mu1(peaks{11,6}(1):peaks{11,6}(2)));
    db74{8,sb+1}.latn1 = EEGtime(i+peaks{11,6}(1));
    [db74{8,sb+1}.peakn2,i] = min(db74{8,sb+1}.mu2(peaks{11,6}(1):peaks{11,6}(2)));
    db74{8,sb+1}.latn2 = EEGtime(i+peaks{11,6}(1));
    [db74{8,sb+1}.peakp1,i] = max(db74{8,sb+1}.mu1(peaks{12,6}(1):peaks{12,6}(2)));
    db74{8,sb+1}.latp1 = EEGtime(i+peaks{12,6}(1));
    [db74{8,sb+1}.peakp2,i] = max(db74{8,sb+1}.mu2(peaks{12,6}(1):peaks{12,6}(2)));
    db74{8,sb+1}.latp2 = EEGtime(i+peaks{12,6}(1));

    [db74{9,sb+1}.peakn1,i] = min(db74{9,sb+1}.mu1(peaks{11,6}(1):peaks{11,6}(2)));
    db74{9,sb+1}.latn1 = EEGtime(i+peaks{11,6}(1));
    [db74{9,sb+1}.peakn2,i] = min(db74{9,sb+1}.mu2(peaks{11,6}(1):peaks{11,6}(2)));
    db74{9,sb+1}.latn2 = EEGtime(i+peaks{11,6}(1));
    [db74{9,sb+1}.peakp1,i] = max(db74{9,sb+1}.mu1(peaks{12,6}(1):peaks{12,6}(2)));
    db74{9,sb+1}.latp1 = EEGtime(i+peaks{12,6}(1));
    [db74{9,sb+1}.peakp2,i] = max(db74{9,sb+1}.mu2(peaks{12,6}(1):peaks{12,6}(2)));
    db74{9,sb+1}.latp2 = EEGtime(i+peaks{12,6}(1));

    % Cz
    [outA, outS, EEGtime, N, SD] = Analyze_db74(14, subject{sb}, ErrTr, trA, trS);
    [db74{11:12,sb+1}] = deal(outS, outA);
    % mean per subject, for MA and A
    db74{11,sb+1}.mu1 = mean(db74{11,sb+1}.t1,1);
    db74{11,sb+1}.mu2 = mean(db74{11,sb+1}.t2,1);
    db74{12,sb+1}.mu1 = mean(db74{12,sb+1}.t1,1);
    db74{12,sb+1}.mu2 = mean(db74{12,sb+1}.t2,1);
    % peak + latency
    [db74{11,sb+1}.peakn1,i] = min(db74{11,sb+1}.mu1(peaks{11,6}(1):peaks{11,6}(2)));
    db74{11,sb+1}.latn1 = EEGtime(i+peaks{11,6}(1));
    [db74{11,sb+1}.peakn2,i] = min(db74{11,sb+1}.mu2(peaks{11,6}(1):peaks{11,6}(2)));
    db74{11,sb+1}.latn2 = EEGtime(i+peaks{11,6}(1));
    [db74{11,sb+1}.peakp1,i] = max(db74{11,sb+1}.mu1(peaks{12,6}(1):peaks{12,6}(2)));
    db74{11,sb+1}.latp1 = EEGtime(i+peaks{12,6}(1));
    [db74{11,sb+1}.peakp2,i] = max(db74{11,sb+1}.mu2(peaks{12,6}(1):peaks{12,6}(2)));
    db74{11,sb+1}.latp2 = EEGtime(i+peaks{12,6}(1));

    [db74{12,sb+1}.peakn1,i] = min(db74{12,sb+1}.mu1(peaks{11,6}(1):peaks{11,6}(2)));
    db74{12,sb+1}.latn1 = EEGtime(i+peaks{11,6}(1));
    [db74{12,sb+1}.peakn2,i] = min(db74{12,sb+1}.mu2(peaks{11,6}(1):peaks{11,6}(2)));
    db74{12,sb+1}.latn2 = EEGtime(i+peaks{11,6}(1));
    [db74{12,sb+1}.peakp1,i] = max(db74{12,sb+1}.mu1(peaks{12,6}(1):peaks{12,6}(2)));
    db74{12,sb+1}.latp1 = EEGtime(i+peaks{12,6}(1));
    [db74{12,sb+1}.peakp2,i] = max(db74{12,sb+1}.mu2(peaks{12,6}(1):peaks{12,6}(2)));
    db74{12,sb+1}.latp2 = EEGtime(i+peaks{12,6}(1));
end

[db74{4,Nsub+2:Nsub+7}] = deal('Mean ERP','SEM ERP', 'Mean Peak', 'SEM Peak', 'Mean Latency','SEM latency');
elidx = [4,7,10];
for el = 1:3
    for con = 1:2 % MA, A
        clear sm gm p1 p2 l1 l2 m1 m2
        for sb = 1:Nsub
            % A
            mu1(sb,:) = db74{elidx(el)+con,sb+1}.mu1;
            mu2(sb,:) = db74{elidx(el)+con,sb+1}.mu2;
            peak1(sb,:) = [db74{elidx(el)+con,sb+1}.peakn1, db74{elidx(el)+con,sb+1}.peakp1]; % N peak, P peak for 1. tone
            peak2(sb,:) = [db74{elidx(el)+con,sb+1}.peakn2, db74{elidx(el)+con,sb+1}.peakp2]; % N peak, P peak for 2. tone
            lat1(sb,:) = [db74{elidx(el)+con,sb+1}.latn1, db74{elidx(el)+con,sb+1}.latp1]; % N latency, P latency for 1. tone
            lat2(sb,:) = [db74{elidx(el)+con,sb+1}.latn2, db74{elidx(el)+con,sb+1}.latp2]; % N latency, P latency for 2. tone

            % Varianzkorrektur
            sm.erp(sb,:) = mean([mu1(sb,:);mu2(sb,:)],1);
            sm.peakn(sb) = mean([peak1(sb,1),peak2(sb,1)]);
            sm.peakp(sb) = mean([peak1(sb,2),peak2(sb,2)]);
            sm.latn(sb) = mean([lat1(sb,1),lat2(sb,1)]);
            sm.latp(sb) = mean([lat1(sb,2),lat2(sb,2)]);
        end
        %GM
        gm.erp = mean(sm.erp,1);
        gm.peakn = mean(sm.peakn);
        gm.peakp = mean(sm.peakp);
        gm.latn = mean(sm.latn);
        gm.latp = mean(sm.latp);
        for sb = 1:Nsub
        %SM-GM
            corr.erp(sb,:) = sm.erp(sb,:)-gm.erp;
            corr.peakn(sb) = sm.peakn(sb)-gm.peakn;
            corr.peakp(sb) = sm.peakp(sb)-gm.peakp;
            corr.latn(sb) = sm.latn(sb)-gm.latn;
            corr.latp(sb) = sm.latp(sb)-gm.latp;

            m1(sb,:) = mu1(sb,:)-corr.erp(sb,:);
            m2(sb,:) = mu2(sb,:)-corr.erp(sb,:);
            p1(sb,:) = [peak1(sb,1)-corr.peakn(sb),peak1(sb,2)-corr.peakp(sb)];
            p2(sb,:) = [peak2(sb,1)-corr.peakn(sb),peak2(sb,2)-corr.peakp(sb)];
            l1(sb,:) = [lat1(sb,1)-corr.latn(sb),lat1(sb,2)-corr.latp(sb)];
            l2(sb,:) = [lat2(sb,1)-corr.latn(sb),lat2(sb,2)-corr.latp(sb)];
        end           

        % mean 
        db74{elidx(el)+con,Nsub+2} = [mean(m1,1); mean(m2,1)];
        db74{elidx(el)+con,Nsub+3} = [std(m1,1)/sqrt(Nsub); std(m2,1)/sqrt(Nsub)];
        db74{elidx(el)+con,Nsub+4} = [mean(p1,1);mean(p2,1)]; % row 1 = mean N peak, P peak 1. tone, row 2 = mean N, P 2. tone
        db74{elidx(el)+con,Nsub+5} = [std(p1,1)/sqrt(Nsub);std(p2,1)/sqrt(Nsub)]; % row 1 = mean N peak, P peak 1. tone, row 2 = mean N, P 2. tone
        db74{elidx(el)+con,Nsub+6} = [mean(l1,1);mean(l2,1)]; % row 1 = mean N peak, P peak 1. tone, row 2 = mean N, P 2. tone
        db74{elidx(el)+con,Nsub+7} = [std(l1,1)/sqrt(Nsub);std(l2,1)/sqrt(Nsub)]; % row 1 = mean N peak, P peak 1. tone, row 2 = mean N, P 2. tone
        
        % Shapiro Wilks Peaks
        disp([el con])
        [H, shapN1, ~] = swtest(peak1(:,1),0.01) % fcz: ma: 0.87, a: 0.80, fz: ma: 0.58, a: 0.13, cz: ma: 0.58, a: 0.51
        [H, shapN2, ~] = swtest(peak2(:,1),0.01) % fcz: ma: 0.34, a: 0.44, fz: ma: 0.45, a: 0.93, cz: ma: 0.40, a: 0.56
        [H, shapP1, ~] = swtest(peak1(:,2),0.01) % fcz: ma: 0.93, a: 0.05, fz: ma: 0.96, a: 0.69, cz: ma: 0.90, a: 0.013
        [H, shapP2, ~] = swtest(peak2(:,2),0.01) % fcz: ma: 0.35, a: 0.56, fz: ma: 0.89, a: 0.41, cz: ma: 0.31, a: 0.99
        % normalverteilt --> ANova passt
        
        % Anova peaks
        disp([db74{elidx(el),1} '_' num2str(con) '_N peak'])
        Npeak(1:Nsub,1:2) = [peak1(:,1),ones(Nsub,1)];
        Npeak(Nsub+1:2*Nsub,1:2) = [peak2(:,1),ones(Nsub,1)*2];
        Npeak(:,3) = [1:Nsub,1:Nsub]';
        RMAOV1(Npeak)
        
        disp([db74{elidx(el),1} '_' num2str(con) '_P peak'])
        Ppeak(1:Nsub,1:2) = [peak1(:,2),ones(Nsub,1)];
        Ppeak(Nsub+1:2*Nsub,1:2) = [peak2(:,2),ones(Nsub,1)*2];
        Ppeak(:,3) = [1:Nsub,1:Nsub]';
        RMAOV1(Ppeak)

        % Anova latency
        disp([db74{elidx(el),1} '_' num2str(con) '_N latency'])
        Nlat(1:Nsub,1:2) = [lat1(:,1),ones(Nsub,1)];
        Nlat(Nsub+1:2*Nsub,1:2) = [lat2(:,1),ones(Nsub,1)*2];
        Nlat(:,3) = [1:Nsub,1:Nsub]';
        RMAOV1(Nlat)
        
        disp([db74{elidx(el),1} '_' num2str(con) '_P latency'])
        Plat(1:Nsub,1:2) = [lat1(:,2),ones(Nsub,1)];
        Plat(Nsub+1:2*Nsub,1:2) = [lat2(:,2),ones(Nsub,1)*2];
        Plat(:,3) = [1:Nsub,1:Nsub]';
        RMAOV1(Plat)

        % ttests (anstatt Anova??)
        %disp(['el_' num2str(el) '_condi_' num2str(con)])
        [db74{elidx(el)+con,27}(1), db74{elidx(el)+con,28}(1), ~, db74{elidx(el)+con,29}(1)] = ttest(peak1(:,1),peak2(:,1))
        [db74{elidx(el)+con,27}(2), db74{elidx(el)+con,28}(2), ~, db74{elidx(el)+con,29}(2)] = ttest(peak1(:,2),peak2(:,2))
        
    end
end

[db74{4,27:29}] = deal('ttest h', 'p', 'stats');
[db74{4,25:26}] = deal('Anova Peak', 'Anova Lat'); % nur p
[db74{5,25:26}] = deal([0.1128, 0.0750],[0.4450, 0.4526]); % FCz, MA, N dann P, erst Peak dann latency
[db74{6,25:26}] = deal([0.9957, 0.1122],[0.7763, 0.8608]); % FCz, A, N dann P
[db74{8,25:26}] = deal([0.1190, 0.2227],[0.5512, 0.3748]); % Fz, MA, N dann P, erst Peak dann latency
[db74{9,25:26}] = deal([0.9930, 0.0847],[0.7085, 0.6969]); % Fz, A, N dann P
[db74{11,25:26}] = deal([0.1523, 0.0482],[0.6666, 0.6641]); % Fz, MA, N dann P, erst Peak dann latency
[db74{12,25:26}] = deal([0.6801, 0.1608],[0.9377, 0.1980]); % Fz, A, N dann P


% FCz MA N peak: F(1,16) = 2.815, p = 0.1128
% FCz MA P peak: F(1,16) = 3.627, p = 0.0750
% FCz MA N lat: F(1,16) = 0.613, p = 0.4450
% FCz MA P lat: F(1,16) = 0.593, p = 0.4526

% FCz A N peak: F(1,16) = 0.000, p = 0.9957
% FCz A P peak: F(1,16) = 2.826, p = 0.1122
% FCz A N lat: F(1,16) = 0.083, p = 0.7763
% FCz A P lat: F(1,16) = 0.032, p = 0.8608

% Fz MA N peak: F(1,16) = 2.714, p = 0.1190
% Fz MA P peak: F(1,16) = 1.610, p = 0.2227
% Fz MA N lat: F(1,16) = 0.371, p = 0.5512
% Fz MA P lat: F(1,16) = 0.834, p = 0.3748

% Fz A N peak: F(1,16) = 0.000, p = 0.9930
% Fz A P peak: F(1,16) = 3.377, p = 0.0847
% Fz A N lat: F(1,16) = 0.145, p = 0.7085
% Fz A P lat: F(1,16) = 0.157, p = 0.6969

% Cz MA N peak: F(1,16) = 2.260, p = 0.1523
% Cz MA P peak: F(1,16) = 4.573, p = 0.0482
% Cz MA N lat: F(1,16) = 0.193, p = 0.6666
% Cz MA P lat: F(1,16) = 0.196, p = 0.6641

% Cz A N peak: F(1,16) = 0.176, p = 0.6801
% Cz A P peak: F(1,16) = 2.162, p = 0.1608
% Cz A N lat: F(1,16) = 0.006, p = 0.9377
% Cz A P lat: F(1,16) = 1.804, p = 0.1980

% getrennt für Elektroden
% pro MA / A tone 1 und tone 2 vergleichen
% peak und latency
cd('../Figures')
for el = 1:3
    % ERP Form, subplot 1 = MA, subplot 2 = A
    % nur amplitude relevant
    figure('Position',[200, 150, 800, 600])
    subplot(2,1,1) % MA
    hold on
    plot([-200 400], [0 0], 'Color', [153/255, 153/255, 153/255])
    plot([0 0], [-15 15], 'Color', [153/255, 153/255, 153/255])
    
    if db74{elidx(el)+1,25}(1) < 0.05 % N peak amplitude
        fill([peaks{11,3}-20, peaks{11,3}+20,peaks{11,3}+20,peaks{11,3}-20],[-15 -15 15 15],...
            [180/255, 180/255, 180/255], 'EdgeColor','none','FaceAlpha',0.3)
    end
    if db74{elidx(el)+1,25}(2) < 0.05 % P peak amplitude
        fill([peaks{12,3}-20, peaks{12,3}+20,peaks{12,3}+20,peaks{12,3}-20],[-15 -15 15 15],...
            [180/255, 180/255, 180/255], 'EdgeColor','none','FaceAlpha',0.3)
    end
    
    fill([EEG_data{7,7},EEG_data{7,7}(end:-1:1)], [db74{elidx(el)+1,19}(1,:)-db74{elidx(el)+1,20}(1,:),flip(db74{elidx(el)+1,19}(1,:)+db74{elidx(el)+1,20}(1,:))],'b','EdgeColor','none','FaceAlpha',0.3)
    p1=plot(EEG_data{7,7},db74{elidx(el)+1,19}(1,:),'Color','b'); % 1. tone
    %plot(db74{elidx(el)+1,23}(1,:),db74{elidx(el)+1,21}(1,:),'bo')
    fill([EEG_data{7,7},EEG_data{7,7}(end:-1:1)], [db74{elidx(el)+1,19}(2,:)-db74{elidx(el)+1,20}(2,:),flip(db74{elidx(el)+1,19}(2,:)+db74{elidx(el)+1,20}(2,:))],'g','EdgeColor','none','FaceAlpha',0.3)
    p2=plot(EEG_data{7,7},db74{elidx(el)+1,19}(2,:),'Color','g'); % 2. tone
    %plot(db74{elidx(el)+1,23}(2,:),db74{elidx(el)+1,21}(2,:),'go')
    
    xlim([-200 400])
    ylim([-15 15])
    legend([p1 p2],{'1. tone louder','2. tone louder'},'Location','northwest')
    title([db74{elidx(el),1} ' | Motor-Auditory condition'])
    ylabel('mean amplitude [µV]')
    

    subplot(2,1,2) % A
    hold on
    plot([-200 400], [0 0], 'Color', [153/255, 153/255, 153/255])
    plot([0 0], [-15 15], 'Color', [153/255, 153/255, 153/255])
    
    if db74{elidx(el)+2,25}(1) < 0.05 % N peak amplitude
        fill([mean(db74{elidx(el)+2,21}(:,1))-20, mean(db74{elidx(el)+2,21}(:,1))+20,mean(db74{elidx(el)+2,21}(:,1))+20,mean(db74{elidx(el)+2,21}(:,1))-20],[-15 -15 15 15],...
            [180/255, 180/255, 180/255], 'EdgeColor','none','FaceAlpha',0.3)
    end
    if db74{elidx(el)+2,25}(2) < 0.05 % P peak amplitude
        fill([mean(db74{elidx(el)+2,21}(:,2))-20, mean(db74{elidx(el)+2,21}(:,2))+20,mean(db74{elidx(el)+2,21}(:,2))+20,mean(db74{elidx(el)+2,21}(:,2))-20],[-15 -15 15 15],...
            [180/255, 180/255, 180/255], 'EdgeColor','none','FaceAlpha',0.3)
    end
    
    fill([EEG_data{7,7},EEG_data{7,7}(end:-1:1)], [db74{elidx(el)+2,19}(1,:)-db74{elidx(el)+2,20}(1,:),flip(db74{elidx(el)+2,19}(1,:)+db74{elidx(el)+2,20}(1,:))],'b','EdgeColor','none','FaceAlpha',0.3)
    p1=plot(EEG_data{7,7},db74{elidx(el)+2,19}(1,:),'Color','b'); % 1. tone
    %plot(db74{elidx(el)+2,23}(1,:),db74{elidx(el)+2,21}(1,:),'bo')
    fill([EEG_data{7,7},EEG_data{7,7}(end:-1:1)], [db74{elidx(el)+2,19}(2,:)-db74{elidx(el)+2,20}(2,:),flip(db74{elidx(el)+2,19}(2,:)+db74{elidx(el)+2,20}(2,:))],'g','EdgeColor','none','FaceAlpha',0.3)
    p2=plot(EEG_data{7,7},db74{elidx(el)+2,19}(2,:),'Color','g'); % 2. tone
    %plot(db74{elidx(el)+2,23}(2,:),db74{elidx(el)+2,21}(2,:),'go')
    
    xlim([-200 400])
    ylim([-15 15])
    legend([p1 p2],{'1. tone louder','2. tone louder'},'Location','northwest')
    title([db74{elidx(el),1} ' | Auditory-Only condition'])
    ylabel('mean amplitude [µV]')
    xlabel('time relative to tone onset [ms]')
    
    saveas(gcf,['T74_ERP_' db74{elidx(el),1} '.png'])
    
    % Boxplots, 2 figures für MA und A
    % 1. row = amplitude N, P
    % 2. row = latency N, P
    for con = 1:2 % MA / A
        figure('Position',[150,100, 1200, 600])
        subplot(2,2,1) % N peak, amplitude
        hold on
        fill([0.5 1.5 1.5 0.5],[db74{elidx(el)+con,21}(1,1)-db74{elidx(el)+con,22}(1,1),db74{elidx(el)+con,21}(1,1)-db74{elidx(el)+con,22}(1,1),db74{elidx(el)+con,21}(1,1)+db74{elidx(el)+con,22}(1,1),db74{elidx(el)+con,21}(1,1)+db74{elidx(el)+con,22}(1,1)],'b','EdgeColor','none','FaceAlpha',0.3) % tone 1
        plot([0.5 1.5], [db74{elidx(el)+con,21}(1,1),db74{elidx(el)+con,21}(1,1)],'k','LineWidth',1)
        fill([2.5 3.5 3.5 2.5],[db74{elidx(el)+con,21}(2,1)-db74{elidx(el)+con,22}(2,1),db74{elidx(el)+con,21}(2,1)-db74{elidx(el)+con,22}(2,1),db74{elidx(el)+con,21}(2,1)+db74{elidx(el)+con,22}(2,1),db74{elidx(el)+con,21}(2,1)+db74{elidx(el)+con,22}(2,1)],'g','EdgeColor','none','FaceAlpha',0.3) % tone 2
        plot([2.5 3.5], [db74{elidx(el)+con,21}(2,1),db74{elidx(el)+con,21}(2,1)],'k','LineWidth',1)
        
        xlim([0 4])
        ylim([-15 -5])
        xticks([1 3])
        xticklabels({'1. tone', '2. tone'})
        %legend([f1 f2], {'1. tone louder', '2. tone louder'})
        title([db74{elidx(el),1} ' | ' db74{con+1,1}(1:end-4) ' | N1 amplitude'])
        ylabel('mean amplitude [µV]')
        xlabel('decision "tone louder"')
        

        subplot(2,2,2) % P peak, amplitude
        hold on
        fill([0.5 1.5 1.5 0.5],[db74{elidx(el)+con,21}(1,2)-db74{elidx(el)+con,22}(1,2),db74{elidx(el)+con,21}(1,2)-db74{elidx(el)+con,22}(1,2),db74{elidx(el)+con,21}(1,2)+db74{elidx(el)+con,22}(1,2),db74{elidx(el)+con,21}(1,2)+db74{elidx(el)+con,22}(1,2)],'b','EdgeColor','none','FaceAlpha',0.3) % tone 1
        plot([0.5 1.5], [db74{elidx(el)+con,21}(1,2),db74{elidx(el)+con,21}(1,2)],'k','LineWidth',1)
        fill([2.5 3.5 3.5 2.5],[db74{elidx(el)+con,21}(2,2)-db74{elidx(el)+con,22}(2,2),db74{elidx(el)+con,21}(2,2)-db74{elidx(el)+con,22}(2,2),db74{elidx(el)+con,21}(2,2)+db74{elidx(el)+con,22}(2,2),db74{elidx(el)+con,21}(2,2)+db74{elidx(el)+con,22}(2,2)],'g','EdgeColor','none','FaceAlpha',0.3) % tone 2
        plot([2.5 3.5], [db74{elidx(el)+con,21}(2,2),db74{elidx(el)+con,21}(2,2)],'k','LineWidth',1)
        
        xlim([0 4])
        ylim([0 15])
        xticks([1 3])
        xticklabels({'1. tone', '2. tone'})
        %legend([f1 f2], {'1. tone louder', '2. tone louder'})
        title([db74{elidx(el),1} ' | ' db74{con+1,1}(1:end-4) ' | P2 amplitude'])
        ylabel('mean amplitude [µV]')
        xlabel('decision "tone louder"')
        

        subplot(2,2,3) % N peak, latency
        hold on
        fill([0.5 1.5 1.5 0.5],[db74{elidx(el)+con,23}(1,1)-db74{elidx(el)+con,24}(1,1),db74{elidx(el)+con,23}(1,1)-db74{elidx(el)+con,24}(1,1),db74{elidx(el)+con,23}(1,1)+db74{elidx(el)+con,24}(1,1),db74{elidx(el)+con,23}(1,1)+db74{elidx(el)+con,24}(1,1)],'b','EdgeColor','none','FaceAlpha',0.3) % tone 1
        plot([0.5 1.5], [db74{elidx(el)+con,23}(1,1),db74{elidx(el)+con,23}(1,1)],'k','LineWidth',1)
        fill([2.5 3.5 3.5 2.5],[db74{elidx(el)+con,23}(2,1)-db74{elidx(el)+con,24}(2,1),db74{elidx(el)+con,23}(2,1)-db74{elidx(el)+con,24}(2,1),db74{elidx(el)+con,23}(2,1)+db74{elidx(el)+con,24}(2,1),db74{elidx(el)+con,23}(2,1)+db74{elidx(el)+con,24}(2,1)],'g','EdgeColor','none','FaceAlpha',0.3) % tone 2
        plot([2.5 3.5], [db74{elidx(el)+con,23}(2,1),db74{elidx(el)+con,23}(2,1)],'k','LineWidth',1)
        
        xlim([0 4])
        ylim([130 180])
        xticks([1 3])
        xticklabels({'1. tone', '2. tone'})
        %legend([f1 f2], {'1. tone louder', '2. tone louder'})
        title([db74{elidx(el),1} ' | ' db74{con+1,1}(1:end-4) ' | N1 latency'])
        ylabel('mean latency [ms]')
        xlabel('decision "tone louder"')

        
        subplot(2,2,4) % P peak, latency
        hold on
        fill([0.5 1.5 1.5 0.5],[db74{elidx(el)+con,23}(1,2)-db74{elidx(el)+con,24}(1,2),db74{elidx(el)+con,23}(1,2)-db74{elidx(el)+con,24}(1,2),db74{elidx(el)+con,23}(1,2)+db74{elidx(el)+con,24}(1,2),db74{elidx(el)+con,23}(1,2)+db74{elidx(el)+con,24}(1,2)],'b','EdgeColor','none','FaceAlpha',0.3) % tone 1
        plot([0.5 1.5], [db74{elidx(el)+con,23}(1,2),db74{elidx(el)+con,23}(1,2)],'k','LineWidth',1)
        fill([2.5 3.5 3.5 2.5],[db74{elidx(el)+con,23}(2,2)-db74{elidx(el)+con,24}(2,2),db74{elidx(el)+con,23}(2,2)-db74{elidx(el)+con,24}(2,2),db74{elidx(el)+con,23}(2,2)+db74{elidx(el)+con,24}(2,2),db74{elidx(el)+con,23}(2,2)+db74{elidx(el)+con,24}(2,2)],'g','EdgeColor','none','FaceAlpha',0.3) % tone 2
        plot([2.5 3.5], [db74{elidx(el)+con,23}(2,2),db74{elidx(el)+con,23}(2,2)],'k','LineWidth',1)
        
        xlim([0 4])
        ylim([200 250])
        xticks([1 3])
        xticklabels({'1. tone', '2. tone'})
        %legend([f1 f2], {'1. tone louder', '2. tone louder'})
        title([db74{elidx(el),1} ' | ' db74{con+1,1}(1:end-4) ' | P2 latency'])
        ylabel('mean latency [ms]')
        xlabel('decision "tone louder"')

        saveas(gcf, ['T74_Box_' db74{elidx(el),1} '_' db74{elidx(el)+con,1} '.png'])
    end
end

