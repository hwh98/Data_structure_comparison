classdef bloomFilter
    properties
        X; % the input array
        %fpr; % acceptable fp rate
        bsize;  % size of bit array % optimal size of bit array (calculate from FPR and # of element) %ceil((length(X) * log(p)) / log(1/log(20^2)));
        bitarr; % construct a bit array  
        hash_num; % number of hash function 
    end

    methods
        function obj = bloomFilter(X, bsize, hashnum)
            obj.X = X;
            obj.bsize = bsize;
            obj.hash_num = hashnum;
            obj.bitarr = zeros(1, bsize, 'logical'); % and initiazlize bit array as all 0
        end % end function

        function obj = addelement(obj)
        %loop though add all element in the filter
            for i= 1:length(obj.X)
                element = obj.X(i);
                %loop through all hash function in bloomfilter
                for hcount = 1:obj.hash_num
                    hashIndex = obj.hashingbloom(element, obj.bsize, hcount); % get index from the n-th hash function

                    obj.bitarr(hashIndex+1) = 1;
                end % end for
            end % end for
        end % end function

        function index = hashingbloom(obj, element, bsize, hcount) % get the index from hashing
            % input: element(String) is the element to hash, bsize(int) is the size of bitarray, 
            % hcount(int) is the order number of the hash function to identify diferrent hash function 
            import java.lang.*;
            import java.security.*;
            messaged = MessageDigest.getInstance('MD5');
            hashing = string(abs(messaged.digest(double(char(element)) + hcount))); % plus the hcount to identify each hash function.
            hashing = [hashing{:}];
            index = mod(str2num(hashing), bsize);
        end 

        function found = search(obj, lookup) % search whether the lookup element exist in the bloom filter
            % input: lookup(char) is the item we want to check 
            correct_index = 0; % to count the number bit of bit is set to 1.
            for hcount = 1:obj.hash_num % loop through to get the index from each hashing function
                    lookuphashing = obj.hashingbloom(lookup, obj.bsize, hcount);
                    if obj.bitarr(lookuphashing+1) == 1
                        correct_index = correct_index + 1;
                    end
            end % end for
            
            if correct_index == obj.hash_num % the number of set value is the number of hash then the element might exist
                found = true;
            else 
                found = false;
            end % end if 
        end
    end %end method
end