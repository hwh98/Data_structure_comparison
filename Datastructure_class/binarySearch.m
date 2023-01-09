classdef binarySearch
    properties
        sortX % the sorted array
        lookup % item to lookup
    end

    methods
        function obj = binarySearch(lookup, unsortarr) % constructor for set up 
            obj.sortX = sort(unsortarr);
            obj.lookup = lookup;
        end

        % binary search function %return[(true/false), (index)] %input % parameter:the key item we want to find and the 'sorted' array.
        function found = search(obj)
            upper = length(obj.sortX);
            lower = 1;
            found =false;
            % searching 
            while lower<=upper
                middle = ceil((upper + lower)/2);
                if obj.sortX(middle) == obj.lookup
                    found = true;
                    return;
                elseif obj.sortX(middle) <= obj.lookup
                    lower = middle + 1;
                else 
                    upper = middle - 1;
                end
            end % end while
            found = false;
        end % end function 

    end
end