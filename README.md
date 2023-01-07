# Main task

The main task is to check whether certain element exist in the data structure, so the searching of the data structure should be efficiently. That's to say, the goal here is to find whether an element is already existed efficiently. Imagine that you might want to check if the account is already taken or notwhen a user is creating an account.

In this repositroy, I implementation five data structures, including three basic data structures, list, sorted array and hash table, and two advanced data structues, bloom filters and Cuckoo filter. The unit test for the implementation is also included.


## Three basic data structures
First, we simply created a list and used linear search to find the element. Second, we store all the information in a sorted array and look for the element with binary search. In the third approach, we put all the information in a hash table and find the element through hashing.

## Bloom filter
Bloom filter is a memoery-efficiently data structure that can rapidly tell you whether a element is present in a dataset. However, the data structure can only tell us that the element either definitely is not in the set or *maybe* in the dataset. 
Each empty cell in the table represent a bit with the number as index. To add an element ot the bloom filter, we hash it a few times and set the bit in the bit vector at the index of those hashes to 1. The number of the hash function is recommended to be 
$$k = m/n*log(2)$$ , where $m$ is the length of bits vector, and $n$ is the number of elements.

To tes tfor existence of an element, you simply hash the element with the same hash function, then see if those values are set in the bit vector. If all bits are set, then the element probably already exists. However, the tricky part of this data structue is that you can conclude that the element *might* exists, becuase another element or some combination of other element could have set the same bits.

Here are some features 
* It never generate false negative result, i.e., telling you that a element doesn't exist while it exists.
* Adding the element never fail. The false positive rate increase as elements are added until all bits are set to 1.
* Deletion is not possible.

## Cuckoo filter


