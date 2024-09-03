close all; clear; clc;
%Andrius Sviglinskas PS-2/1 GR06
disp('Andrius Sviglinskas PS-2/1 GR06')
notes = ["C" "C/D" "D" "D/E" "E" "F" "F/G" "G" "G/A" "A" "A/B" "B"];
allFreq = [16.35 32.70 65.41 130.81 261.63 523.25 1046.50 2093.00 4186.01;%C
          17.32 34.65 69.30 138.59 277.18 554.37 1108.73 2217.46 4434.92;%C/D
          18.35 36.71 73.42 146.83 293.66 587.33 1174.66 2349.32 4698.63;%D
          19.45 38.89 77.78 155.56 311.13 622.25 1244.51 2489.02 4978.03;%D/E
          20.60 41.20 82.41 164.81 329.63 659.25 1318.51 2637.02 5274.04;%E
          21.83 43.65 87.31 174.61 349.23 698.46 1396.91 2793.83 5587.65;%F
          23.12 46.25 92.50 185.00 369.99 739.99 1479.98 2959.96 5919.91;%F/G
          24.50 49.00 98.00 196.00 392.00 783.99 1567.98 3135.96 6271.93;%G
          25.96 51.91 103.83 207.65 415.30 830.61 1661.22 3322.44 6644.88;%G/A
          27.50 55.00 110.00 220.00 440.00 880.00 1760.00 3520.00 7040.00;%A
          29.14 58.27 116.54 233.08 466.16 932.33 1864.66 3729.31 7458.62;%A/B
          30.87 61.74 123.47 246.94 493.88 987.77 1975.53 3951.07 7902.13;%B
];
selectedFreq = [];
index = 1;
%User chooses audio file from selected file types
[currentFolder,~,~] = fileparts(mfilename('fullpath'));
folderName = currentFolder + "\Audio Files\";
folderName = convertStringsToChars(folderName);
file = uigetfile({'*.flac;*.wav;*.mp3','Audio files (*.flac,*.wav,*.mp3)'},'Select file', folderName);
if(file == 0)
    disp("No file chosen");
else
    disp("User chosen audio file - " + file);
    [y, fs] = audioread("Audio Files/" + file);
    %plot audio waves
    t = linspace(0,length(y)/fs,length(y));%seconds vector
    p = tiledlayout(2,1);
    p.Padding = 'loose';
    p.TileSpacing = 'loose';
    nexttile
    plot(t,y)
    xlabel('Seconds');
    ylabel('Amplitude');
    title('Waves from music file');
    %plot FFT graph
    wave_fft = fft(y);
    L = length(y);
    f = fs*(0:(L/5))/L;%freq vector
    fullSpec = abs(wave_fft/L);%get normal numbers from complex
    leftSpec = fullSpec(1:floor(L/5+1));%get only postive frequencies
    leftSpec(2:end-1) = 2*leftSpec(2:end-1);%multiply all by 2 except firs
    nexttile
    plot(f,leftSpec)
    xlabel('Hz');
    ylabel('Amplitude');
    title('FFT graph');
    %extracting unique notes
    ampLimit = max(leftSpec) / 2;
    for i = 1:1:length(f)
        if(leftSpec(i) >= ampLimit)
            selectedFreq(index) = fix(f(i));
            index = index + 1;
        end
    end
    if(length(selectedFreq) > 1)
        selectedFreq = removeSame(selectedFreq);
        for j = 1:1:length(selectedFreq)
            findNote(selectedFreq(j),notes,allFreq);
        end
    else
        disp('Given audio file have not detected any notes');
    end
end

