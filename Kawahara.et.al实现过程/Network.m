classdef Network
   
    %   �Զ����·���� s_V��ʼ�㣬s_TĿ�ĵ㣬vLIST�㼯�ϣ�eList�߼��ϣ�����variableʹ��int��ֵ
    
    properties
        
        v_S = 1;
        v_T = 4;
        vList = [1,2,3,4];
        eList = [[1001;1;2],[1002;1;3],[1003;2;3],[1003;2;4],[1003;3;4]];

    end
    
    methods
        function obj = Network(G,s,v)
            %Network���췽��
            obj.v_S = G.v_S;
            obj.v_T = G.v_T;
            obj.vList =  G.vList;
            obj.eList = G.eList;
            %METHOD1 ��s����v
            obj.v_S=v;
            %ɾ������s�йص����б�
            [m,n]=find(obj.eList==s);
            obj.eList(:,n)=[];

        end
      
    end
end

