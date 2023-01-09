var sourceData3 = {"FileName":"/Users/hongweixiang/Desktop/GitHub_Repo/Data_structure_comparison/Datastructure_class/hashTable.m","RawFileContents":["classdef hashTable ","    properties","        X % the sorted array","        found; % whether we found the lookup item","        ht; % the hashtable ","    end % end properties","    methods","        function obj = hashTable(X) %constructor","            obj.X = X;","            obj.ht = javaObject('java.util.Hashtable');% initialize the hashTable object","        end","","        function Xtohashtable(obj) % hash the array 'X' of the obj into the hashtable","            for i = 1:length(obj.X)","                obj.ht.put(obj.hashingfun(obj.X(i)), obj.X(i));","            end","        end","        ","        function found = search(obj, lookup) % the method to search the lookup item in hashtable %input: lookup(char) is the item to lookup ","            found = false;","            hashlookup = obj.hashingfun(lookup);% 'Hashing' to get key ","            ","            % return whether found result","            if ischar(obj.ht.get(hashlookup))","                found = true; % found the item.","            end","        end","","        function hashvalue = hashingfun(obj, key) % the hashing function %input: key(string) is the key we want to hash.","            import java.lang.*;","            import java.security.*;","            messaged = MessageDigest.getInstance('SHA'); % initialized the java object with SHA-1 for hashing ","            hashk = messaged.digest(double(char(key))); % complet the hash computation","            hashk = string(abs(hashk));","            hashvalue = [hashk{:}];","        end","    end % end methods","","end"],"CoverageDisplayDataPerLine":{"Statement":[{"LineNumber":9,"Hits":4,"StartColumnNumbers":12,"EndColumnNumbers":22,"ContinuedLine":false},{"LineNumber":10,"Hits":4,"StartColumnNumbers":12,"EndColumnNumbers":55,"ContinuedLine":false},{"LineNumber":14,"Hits":2,"StartColumnNumbers":12,"EndColumnNumbers":35,"ContinuedLine":false},{"LineNumber":15,"Hits":20,"StartColumnNumbers":16,"EndColumnNumbers":63,"ContinuedLine":false},{"LineNumber":20,"Hits":2,"StartColumnNumbers":12,"EndColumnNumbers":26,"ContinuedLine":false},{"LineNumber":21,"Hits":2,"StartColumnNumbers":12,"EndColumnNumbers":48,"ContinuedLine":false},{"LineNumber":24,"Hits":2,"StartColumnNumbers":12,"EndColumnNumbers":45,"ContinuedLine":false},{"LineNumber":25,"Hits":1,"StartColumnNumbers":16,"EndColumnNumbers":29,"ContinuedLine":false},{"LineNumber":32,"Hits":23,"StartColumnNumbers":12,"EndColumnNumbers":56,"ContinuedLine":false},{"LineNumber":33,"Hits":23,"StartColumnNumbers":12,"EndColumnNumbers":55,"ContinuedLine":false},{"LineNumber":34,"Hits":23,"StartColumnNumbers":12,"EndColumnNumbers":39,"ContinuedLine":false},{"LineNumber":35,"Hits":23,"StartColumnNumbers":12,"EndColumnNumbers":35,"ContinuedLine":false}],"Function":[{"LineNumber":8,"Hits":4,"StartColumnNumbers":8,"EndColumnNumbers":35,"ContinuedLine":false},{"LineNumber":13,"Hits":2,"StartColumnNumbers":8,"EndColumnNumbers":34,"ContinuedLine":false},{"LineNumber":19,"Hits":2,"StartColumnNumbers":8,"EndColumnNumbers":44,"ContinuedLine":false},{"LineNumber":29,"Hits":23,"StartColumnNumbers":8,"EndColumnNumbers":49,"ContinuedLine":false}]}}