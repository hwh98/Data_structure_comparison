classdef hashTable 
    properties
        X % the sorted array
        found; % whether we found the lookup item
        ht; % the hashtable 
    end % end properties
    methods
        function obj = hashTable(X) %constructor
            obj.X = X;
            obj.ht = javaObject('java.util.Hashtable');% initialize the hashTable object
        end

        function Xtohashtable(obj) % hash the array 'X' of the obj into the hashtable
            for i = 1:length(obj.X)
                obj.ht.put(obj.hashingfun(obj.X(i)), obj.X(i));
            end
        end
        
        function found = search(obj, lookup) % the method to search the lookup item in hashtable %input: lookup(char) is the item to lookup 
            found = false;
            hashlookup = obj.hashingfun(lookup);% 'Hashing' to get key 
            
            % return whether found result
            if ischar(obj.ht.get(hashlookup))
                found = true; % found the item.
            end
        end

        function hashvalue = hashingfun(obj, key) % the hashing function %input: key(string) is the key we want to hash.
            import java.lang.*;
            import java.security.*;
            messaged = MessageDigest.getInstance('SHA'); % initialized the java object with SHA-1 for hashing 
            hashk = messaged.digest(double(char(key))); % complet the hash computation
            hashk = string(abs(hashk));
            hashvalue = [hashk{:}];
        end
    end % end methods

end