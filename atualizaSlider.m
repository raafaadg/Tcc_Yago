global varSlider
global varTheta
global ard

varSlider(1) = readVoltage(ard,'A7');
varSlider(2) = readVoltage(ard,'A9');
varSlider(3) = readVoltage(ard,'A12');
varSlider(4) = readVoltage(ard,'A15');
varSlider(5) = readVoltage(ard,'A6');
varSlider(6) = readVoltage(ard,'A7');

varTheta = (varSlider(:).*42.8572)-21.4286;
% varTheta(1)=pi/2;%current angle position joint 1
% varTheta(2)=pi/2;%current angle position joint 2
% varTheta(3)=-pi/2;%current angle position joint 3
% varTheta(4)=pi*0.2;%current angle position joint 4
% varTheta(5)=-pi*0.2;%current angle position joint 5
% varTheta(6)=-pi*0.2;%current angle position joint 6

D(1) = Link([ 0 0 0.3 varSlider(1) 0], 'standard');
D(2) = Link([ 0 0 0.3 varSlider(2) 0], 'standard');
D(3) = Link([ 0 0 0.3 varSlider(3) 0], 'standard');
D(4) = Link([ 0 0 0.3 varSlider(4) 0], 'standard');
D(5) = Link([ 0 0 0.3 varSlider(5) 0], 'standard');
D(6) = Link([ 0 0 0.3 varSlider(6) 0], 'standard');



set(handles.edit1,'String', varSlider(1));
set(handles.edit2,'String', varSlider(2));
set(handles.edit3,'String', varSlider(3));
set(handles.edit4,'String', varSlider(4));
set(handles.edit5,'String', varSlider(5));
set(handles.edit6,'String', varSlider(6));

R=SerialLink(D,'name','Robo COMAU TCC');

R.plot([varTheta(1) varTheta(2) varTheta(3) varTheta(4) varTheta(5) varTheta(6)])