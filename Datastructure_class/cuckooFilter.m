classdef cuckooFilter
    properties
        X; % the input array
        bitnum; % number of bit of the hashing value.
        arrsize; % the size of the array is defined by the number of bit of the hashing output value.
        bucketarr; % the bucket array.
        maxkick; % the maximum time of kicking item, otherwise stop finding other site for the kicked item because the bucket array is full.
        fullyadd; % whether add all the item of X into bucket.
    end
    methods
        function obj = cuckooFilter(X, bitnum, maxkick)
            obj.X = X;
            obj.bitnum = bitnum;
            obj.arrsize = 2^bitnum;
            obj.bucketarr = strings([1, obj.arrsize]);% initialize the bucket array. **the array has no value yet.
            obj.maxkick = maxkick;
            obj.fullyadd = false;
        end % end function.
        
        function obj = addelement(obj) % add all element of X into the cuckoo filter
            for i = 1:length(obj.X) 
                [obj,success] = obj.cuckooadd(obj.X(i)); % add element into bucket
                if ~success % it can't add in anymore item so return false ;
                    fprintf("Bucket full. No more add. Already add %d element\n", i-1);
                    break
                end % end if.
            end
            obj.fullyadd = success; % loop through all element success!
        end % end function

        function hashindex = hashcuckoo(obj, element)% it hash the item 'element' into n-bits string for index . EX:'00101010'. And it return a 8-bits code with item 's'
            % input: element(String) is the element we want to hash, bitnum(int) is the number of bit the result index will be.
            % return : hashindex(char) is a n-bits binary value. EX: '11101101'
            import java.lang.*;
            import java.security.*;
            messaged = MessageDigest.getInstance('MD5');
            hashvalue = abs(messaged.digest(double(char(element))));
            if(obj.bitnum == 8)
                hashvalue = uint8(hashvalue(1)) + uint8(hashvalue(2)); %for 8-bits
                hashindex = dec2bin(hashvalue,obj.bitnum); % turn the number(<256) into bits EX: 11110011
            else
                hashindex = strcat(char(dec2bin(hashvalue(1),8)), char(dec2bin(hashvalue(1),8))); % hash the number into 16-bits EX: 0111111101110100
            end
        end %end function

        function newXORindex= xorhashIndex(obj, kickedfingerprint, hashindex)% (collideIndex) XOR hash(fingerprinted of the kicked object)  %return the new index 
            % input: kickedfinger(string) is the fgp need to be relocated, hashindex(int) is the index where the collision happend,
            % bitnum(int) is the number of bit of the index.
            % return: integer of new index for "kickedfingerprint".
            newInBeforeXOR = obj.hashcuckoo(kickedfingerprint); % get the new index calculate with the kicked element's fingerprint
            newInBeforeXOR = logical(newInBeforeXOR(:)'-'0'); % turn it into bit
            collideBitIndex = dec2bin(hashindex+1, obj.bitnum); %turn the collide index  to binary bit.
            collideBitIndex = logical(collideBitIndex(:)'-'0'); % turn it into bit
            newXORindex = bin2dec(char(xor(newInBeforeXOR,collideBitIndex)+'0')); % turn the binary bit to integer
            if(obj.bitnum ~= 8)
                newXORindex = newXORindex + randi([1,100],1);
            end
        end %end function

        function [obj,success] = cuckooadd(obj, element)% add one element into the bucket
            % input : element(String) is the element we want to put into the cuckoo filter
            fgp = mlreportgen.utils.hash(element);% get the fingerprint for item

            hashindex = bin2dec(obj.hashcuckoo(element)); % get the index of hashing and turn the n-bit to actual number 
            %fprintf('element %s fingerprint %s at index %d\n', element, fgp, hashindex+1)
            
            %check if the index is taken
            if obj.bucketarr(hashindex+1) == "" % the site is not taken
                obj.bucketarr(hashindex+1) = fgp;
                success = true;
                return;

            else % site is taken, so find other site(new index) for the moved item. 
                collisionIndex = hashindex; % the index to focus on
                movedfingerp = obj.bucketarr(hashindex+1); % the fingerpritn to be kicked out
                obj.bucketarr(hashindex+1) = fgp; % the move-in fgp
                %fprintf("collide at %d and %s be kicked \n", hashindex + 1, movedfingerp)
                
                for kick = 1:obj.maxkick
                    % get the new index for the moved item. ***new index = (old index) XOR (hash(fingerprint))
                    newindex = obj.xorhashIndex(movedfingerp, hashindex); %hashindex don't need to +1 we'll do that in function.
                    if obj.bucketarr(newindex + 1) == "" % the new site isnot taken
                        obj.bucketarr(newindex + 1) = movedfingerp;
                        %fprintf("kick element %s to new index %d\n", movedfingerp, newindex+1)
                        success = true;
                        return;
                    else % the index is "still" taken so we need the swap the "movedfinger" - the victim is changed
                        %fprintf("new index %d taken. Move %s away\n", newindex+1, obj.bucketarr(newindex+1));
                        tempstorefingerp = obj.bucketarr(newindex + 1); % temp store the kicked fingerprint
                        obj.bucketarr(newindex+1) = movedfingerp;% bring in the move-in fingerprint
                        movedfingerp = tempstorefingerp; % assign the new victim.
                        collisionIndex = newindex + 1; % update the new collided index.
                    end % end if
                end % end for
                success = false;% can't find any index after we reach the maxkick time of iteration.
            end % end if       
        end % end function 

        function found = search(obj, lookup) % lookup(char) the element we want to search in the bucket with binary search.
                lookfp = mlreportgen.utils.hash(lookup); % get the fingerprint of the lookup item
                found = false; % whether found 
                %delete the empty cell and sort the bucket for efficiently lookup
                temp_bucketarr = obj.bucketarr(~cellfun('isempty', obj.bucketarr));
                temp_bucketarr = sort(temp_bucketarr); % sort for the binary search
                found = obj.binarysearch(char(lookfp), temp_bucketarr); % turn lookfp into char for the binary search
        end %end function 

        % binary search function %return[(true/false), (index)] 
        function found = binarysearch(obj, lookup, sortedarr)
            %input: lookup(char) is the fingerprint of item we want to search, sortedarr(arr) the 'sorted' array.
            upper = length(sortedarr);
            lower = 1;
            found = false; % whether found 
            % searching 
            while lower<=upper
                middle = ceil((upper + lower)/2);
                if sortedarr(middle) == lookup
                    found = true;
                    return;
                elseif sortedarr(middle) <= lookup
                    lower = middle + 1;
                else 
                    upper = middle - 1;
                end
            end
            found = false;
        end

    end % end methods
end % end class