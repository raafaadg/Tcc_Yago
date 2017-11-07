classdef comm
    properties
        NomePorta = 'COM12';
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
                if(isvalid(obj.hCom))
                    disp('Porta Serial - Comunicação aberta!');
                end
            catch
                warning('Erro ao abrir comunicação serial com o robo.')
            end
            
        end
        function obj = descomunica(obj)
            try
                fclose(obj.hCom);
                disp('Porta Serial - Comunicação Fechada!');
            catch
                warning('Erro ao fechar comunicação serial com o robo.')
            end
        end
        function obj = conectaArduino(obj)
            try
                obj.ard = arduino;
                disp('Arduino Conectado')
            catch 
                warning('Erro ao conectar com o Arduino ');
            end
        end
        function obj = envia(obj)
            obj.BufferEnvia = obj.outputdata;
            if isnumeric(obj.BufferEnvia)
             obj.BufferEnvia = ['<' num2str(obj.outputdata(1)) ','...
                 num2str(obj.outputdata(2)) ',' num2str(obj.outputdata(3)) '>'];
            end
            try
                fprintf(obj.hCom,obj.BufferEnvia);
            catch
                warning('Erro ao enviar Arquivo');
            end
            obj.envio = true;           
        end
        function obj = recebe(obj)
            if (strcmp(obj.hCom.Status, 'closed'))
                 obj.comunica;
            end
            try
                [BufferRecebe_aux, TamResposta_aux] = fscanf(obj.hCom);
                if(size(BufferRecebe_aux)>0)
                obj.BufferRecebe = char(BufferRecebe_aux);
                obj.TamResposta = TamResposta_aux;
                obj.resposta = 1;
                end
                if(size(BufferRecebe_aux)<0)
                    obj.resposta = 0;
                end
            catch
                warning('Erro ao receber mensagem');
            end
            
            if (strcmp(obj.hCom.Status, 'open'))
                 obj.descomunica;
            end
        end
    end
end
