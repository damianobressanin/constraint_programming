:- lib(fd).

mapcoloring([V1, V2, V3, V4, V5]):- % VARIABILI
        [V1, V2, V3, V4, V5] :: [red,blue,green,yellow], % DOMINI
        
        % VINCOLI
        
        V1 #\= V2,
        V1 #\= V3,
        V1 #\= V4,
        V1 #\= V5,
        
        V2 #\= V3,
        V2 #\= V4,
        V2 #\= V5,
        
        V3 #\= V4,
        
        V4 #\= V5.
        
        %labeling([V1, V2, V3, V4, V5]).