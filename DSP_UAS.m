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



frame=[];
countz = 1;
for h=1:1000:length(z)
    disp(h);
    frame(countz) = mean(abs(z(h:h+999)));
    countz = countz + 1;
end

figure(13);
plot(frame);

silence_remove = [];
count = 1;

for k=1:1000:length(z)
    h = (k+999)/1000;
    disp(h);
    if(frame(h) > 0.0015)
        for lent=k:k+999
            silence_remove(count) = z(lent);
            count = count + 1;
        end
    end
end

figure(5);
plot(silence_remove);


recorder = audiorecorder(fs,16,1);
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

frame2=[];
countz = 1;
for h=1:1000:length(z2)
    disp(h);
    frame2(countz) = mean(abs(z2(h:h+999)));
    countz = countz + 1;
end

figure(14);
plot(frame2);

silence_remove_2 = [];
count = 1;

for k=1:1000:length(z2)
    h = (k+999)/1000;
    disp(h);
    if(frame2(h) > 0.0015)
        for lent=k:k+999
            silence_remove_2(count) = z2(lent);
            count = count + 1;
        end
    end
end

figure(10);
plot(silence_remove_2);

figure(11);
plot(xcorr(silence_remove,silence_remove_2));


