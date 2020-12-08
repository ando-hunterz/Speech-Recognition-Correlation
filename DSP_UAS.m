close all;

fs=24000;
recorder = audiorecorder(fs,16,1);
disp('Start speaking.')
recordblocking(recorder,2);
disp('Stop Speaking.')
disp('Audio Playing.')
myRecording = getaudiodata(recorder);
figure(1)
plot(myRecording);
y = fft(myRecording);
x = linspace(0,fs,length(myRecording));
figure(2);
plot(x(1:length(y)/2),abs(y(1:length(y)/2)));
%sound(myRecording,fs);

fc1 = 500;
fc2 = 4000;
b = fir1(48,[fc1 fc2]/(fs/2),'bandpass');
fvtool(b,1);
z = filter(b,1,myRecording);

z_fft = fft(z);
figure(3);
plot(x(1:length(y)/2),abs(z_fft(1:length(z_fft)/2)));
%sound(z,fs);
figure(4);
plot(z);

silence_remove = [];
count = 1;
for k=1:length(z)
    if(z(k) ~= 0)
        silence_remove(count) = z(k);
        count = count + 1;
    end
end

figure(5);
plot(silence_remove);


recorder = audiorecorder(fs,8,1);
disp('Start speaking.')
recordblocking(recorder,2);
disp('Stop Speaking.')
disp('Audio Playing.')
myRecording2 = getaudiodata(recorder);
figure(6)
plot(myRecording2);
y = fft(myRecording2);
x = linspace(0,fs,length(myRecording2));
figure(7);
plot(x(1:length(y)/2),abs(y(1:length(y)/2)));
%sound(myRecording2,fs);

z2 = filter(b,1,myRecording2);

z2_fft = fft(z2);
figure(8);
plot(x(1:length(y)/2),abs(z2_fft(1:length(z2_fft)/2)));
%sound(z2,fs);
figure(9);
plot(z2);

silence_remove_2 = [];
count = 1;
for k=1:length(z2)
    if(z2(k) ~= 0)
        silence_remove_2(count) = z2(k);
        count = count + 1;
    end
end

figure(10);
plot(silence_remove_2);


figure(11);
plot(xcorr(silence_remove,silence_remove_2));


