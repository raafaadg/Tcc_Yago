global com

if(~isempty(com.ard))
    com.varSlider(1) = readVoltage(com.ard,'A15');
    com.varSlider(2) = readVoltage(com.ard,'A15');
    com.varSlider(3) = readVoltage(com.ard,'A15');
    com.varSlider(4) = readVoltage(com.ard,'A15');
    com.varSlider(5) = readVoltage(com.ard,'A15');
    com.varSlider(6) = readVoltage(com.ard,'A15');
    com.varTheta = (com.varSlider(:).*42.8572)-21.4286;

    % com.varTheta(1)=pi/2;%current angle position joint 1
    % com.varTheta(2)=pi/2;%current angle position joint 2
    % com.varTheta(3)=-pi/2;%current angle position joint 3
    % com.varTheta(4)=pi*0.2;%current angle position joint 4
    % com.varTheta(5)=-pi*0.2;%current angle position joint 5
    % com.varTheta(6)=-pi*0.2;%current angle position joint 6

    D(1) = Link([ 0 0 0.3 com.varSlider(1) 0], 'standard');
    D(2) = Link([ 0 0 0.3 com.varSlider(2) 0], 'standard');
    D(3) = Link([ 0 0 0.3 com.varSlider(3) 0], 'standard');
    D(4) = Link([ 0 0 0.3 com.varSlider(4) 0], 'standard');
    D(5) = Link([ 0 0 0.3 com.varSlider(5) 0], 'standard');
    D(6) = Link([ 0 0 0.3 com.varSlider(6) 0], 'standard');

    R=SerialLink(D,'name','Robo COMAU TCC');

    R.plot([com.varTheta(1) com.varTheta(2) com.varTheta(3) com.varTheta(4) com.varTheta(5) com.varTheta(6)])
    com.outputdata = DH_Met(com.varSlider);
    
    disp(com.outputdata);
    disp(com.varSlider);
end