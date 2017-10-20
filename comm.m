classdef comm
    properties
        NomePorta = 'COM1';
        BytesLidos = 0;
        verifica
        envio
        resposta
        hCom
        outputdata
        BufferEnvia
        BufferRecebe
        TamResposta
        ard
        varSlider
        varTheta
        FlagResposta = false;
    end    
    methods
       % function obj = set.outputdata(obj,val)
        %   if ((val(1)<0)||(val(2)<0)||(val(3)<0)) 
         %      warning('impossivel de assumir valores negativos')
          % end
        %end
        function obj = comm()
            obj.verifica=0;
            obj.envio = 'false';
        end
        function obj = conecta(obj)
            try
                obj.hCom = serial(obj.NomePorta); %Estabelece conexão com a porta serial
            catch 
                warning('Erro ao estabelecer conexão com a porta.');
            end
            disp('Porta Serial Conectada!')
            obj.verifica = 1;
            obj.hCom.Timeout = 2; %Seta o timeout tando da leitura como escrita
        end
        function obj = desconecta(obj)
            if(isvalid(obj.hCom))   %Se a porta existir
                try
                    delete(obj.hCom)    %Interrompe a comunicação serial
                catch
                    error('Erro ao fechar dispositivo.');
                end
            end
        end
        function obj = comunica(obj)
            try
                fopen(obj.hCom);
            catch
                warning('Erro ao abrir comunicação serial com o robo.')
            end
            if(isvalid(com.hCom))
                disp('Porta Serial Conectada!')
            end
        end
        function obj = descomunica(obj)
            try
                fclose(obj.hCom);
            catch
                warning('Erro ao fechar comunicação serial com o robo.')
            end
        end
        function obj = conectaArduino(obj)
            try
                obj.ard = arduino();
                disp('Arduino Conectado')
            catch 
                warning('Erro ao conectar com o Arduino ');
            end
        end
        function obj = envia(obj)
            obj.BufferEnvia = num2str(obj.outputdata');
%             BufferEnvia_bits = dec2bin(BufferEnvia); %Converte valores de x,y,z para bits
%             BufferEnvia_bits = horzcat(BufferEnvia_bits(1,:),...
%                 BufferEnvia_bits(2,:),BufferEnvia_bits(3,:)); %Ordena valores recebi
            try
                fprintf(obj.hCom,'%s',obj.BufferEnvia);
%             fwrite(obj,obj.BufferEnvia);    %Envia informação em string             
%             fwrite(obj,BufferEnvia_bits); %Envia informação em bits
            catch
                warning('Erro ao enviar Arquivo');
            end
            obj.envio = true;           
        end
        function obj = recebe(obj)
            try
                [BufferRecebe_aux, TamResposta_aux] = fread(obj.hCom);
            catch
                warning('Erro ao receber mensagem');
            end
            if(size(BufferRecebe_aux)>0)
                obj.BufferRecebe = BufferRecebe_aux;
                obj.TamResposta = TamResposta_aux;
                obj.resposta = 1;
            end
            if(size(BufferRecebe_aux)<0)
                obj.resposta = 0;
            end
        end
    end
end
