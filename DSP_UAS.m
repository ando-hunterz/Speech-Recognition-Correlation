close all;

fs=24000;
recorder = audiorecorder(fs,8,1);
disp('Start speaking.')
recordblocking(recorder,2);
disp('Stop Speaking.')
disp('Audio Playing.')
myRecording = getaudiodata(recorder);
figure(1)
plot(myRecording);
yx = fft(myRecording);
xx = linspace(0,fs,length(myRecording));
figure(2);
plot(xx(1:length(yx)/2),abs(yx(1:length(yx)/2)));
sound(myRecording,fs);

fc1 = 300;
fc2 = 4000;
b = fir1(48,[fc1 fc2]/(fs/2),'bandpass');
fvtool(b,1);
z = filter(b,1,myRecording);

zx = fft(z);
figure(3);
plot(xx(1:length(yx)/2),abs(zx(1:length(zx)/2)));
sound(z,fs);
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

