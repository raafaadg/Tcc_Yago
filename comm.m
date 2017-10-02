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
    end    
    methods
        function obj = set.outputdata(obj,val)
           if ((val(1)<0)||(val(2)<0)||(val(3)<0)) 
               warning('impossivel de assumir valores negativos')
           end
        end
        function obj = comm()
            obj.verifica=0;
            obj.envio = 'false';
        end
        function obj = conecta(obj)
            try
                obj.hCom = serial(obj.NomePorta); %Estabelece conex�o com a porta serial
            catch 
                error('Erro ao estabelecer conex�o com a porta.');
            end
            disp('Porta Serial Conectada!')
            obj.verifica = 1;
            obj.hCom.Timeout = 2; %Seta o timeout tando da leitura como escrita
        end
        function obj = desconecta(obj)
            if(isvalid(obj.hCom))   %Se a porta existir
                try
                    delete(obj.hCom)    %Interrompe a comunica��o serial
                catch
                    error('Erro ao fechar dispositivo.');
                end
            end
        end
        function obj = envia(obj)
            obj.BufferEnvia = obj.outputdata;
%             BufferEnvia_bits = dec2bin(BufferEnvia); %Converte valores de x,y,z para bits
%             BufferEnvia_bits = horzcat(BufferEnvia_bits(1,:),...
%                 BufferEnvia_bits(2,:),BufferEnvia_bits(3,:)); %Ordena valores recebi
            try
            fwrite(obj,obj.BufferEnvia);    %Envia informa��o em string             
%             fwrite(obj,BufferEnvia_bits); %Envia informa��o em bits
            catch
                waring('Erro ao enviar Arquivo');
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
