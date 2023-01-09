classdef linearSearch
    
    properties
        X % the array
        lookup % item to lookup
    end
    
    methods
        function obj = linearSearch(X, lookup) % constructor.
            obj.X = X;
            obj.lookup = lookup;
        end
        
        %linear search function. %return[ (true/false), index] %parameter: the key item to find and the array to lookup
        function found = search(obj)
        
            for i = 1:length(obj.X)
                if obj.X(i)== obj.lookup
                    found = true;
                    return;
                end
            end % end for
            found = false;
        end % end function

    end
end