function[] = findNote(freq, notes, allFreq)
%function that finds if given frequency belongs to a note and displays it
%   freq - given frequency to check
%   notes - array of notes
%   allFreq - matrix of all frequencies, collumns are are octaves, 
%   rows are are notes
testFreqs = allFreq;
for i = 1:1:12
    for j = 1:1:9
        if(fix(testFreqs(i,j)) == freq)
            disp("Chord has note " + notes(i) + " in octave " + (j - 1) + " that belongs to frequency " + allFreq(i,j));
        end
    end
end
%displays each time, need system for only displaying one each
