classdef Network
   
    %   自定义的路网类 s_V起始点，s_T目的点，vLIST点集合，eList边集合，所有variable使用int数值
    
    properties
        
        v_S = 1;
        v_T = 4;
        vList = [1,2,3,4];
        eList = [[1001;1;2],[1002;1;3],[1003;2;3],[1003;2;4],[1003;3;4]];

    end
    
    methods
        function obj = Network(G,s,v)
            %Network构造方法
            obj.v_S = G.v_S;
            obj.v_T = G.v_T;
            obj.vList =  G.vList;
            obj.eList = G.eList;
            %METHOD1 从s到达v
            obj.v_S=v;
            %删除与结点s有关的所有边
            [m,n]=find(obj.eList==s);
            obj.eList(:,n)=[];

        end
      
    end
end

