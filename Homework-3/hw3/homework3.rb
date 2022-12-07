
# ----------------------- Question 1---------------------------

def reverseStr(str)
  len = str.length
  (0..(len/2)-1).each do |i|
    x=str[i]
    str[i]=str[len-1-i]
    str[len-1-i]=x 
  end
end

# ------------------------Question 2---------------------------------

def longest_ap(arr)
  n = arr.length
  ans=Array.new
  dp=Array.new(n){{}}     #Create a dp table whose dp[i][j] refers to longest ap sequence of difference j which ends at ith term of array 
  max_len=1
  last_term=-1
  diff=-1
  j=1
  while j<n                         # Consider each element as last element of ap 
    i=0
    while i<j                       # for that element, loop over the terms before it to find the term preciding it
      gap=arr[j]-arr[i]        
      if dp[i].has_key?(gap)
        dp[j][gap]=dp[i][gap]+1     #if found, increase the length 
      else
        dp[j][gap]=2                # otherwise, create one ap sequence 
      end
      if max_len < dp[j][gap]
        max_len=dp[j][gap]
        diff=gap                    # store the diff and last term to generate the ap sequence
        last_term=arr[j]
      end
      i=i+1
    end
    j=j+1
  end
  if n==1
    ans<<arr[0]                     # if length of array is 1, then only ap is of length 1
  else
    i=0
    while i<max_len
      ans<<last_term-(i*diff)       # else, generate the ap using saved last term and diff
      i=i+1
    end
    reverseStr(ans)                 # as elements are in reverse order, re reverse it.

  end
  puts ans
  ans

end

# -------------------------------Question 3 ----------------------------------------

class Array
  def rest                     # This gives the list after dropping the first term
    self[1..-1]
  end

  def foldl (id,&func)         # takes func(block) and id(start value) 
    if self.empty?             # base condition
      id
    else
      func.call(self.rest.foldl(id,&func),self.first) # recursively calculate using foldl
    end
  end
end

# arr = Array[1,3,4,5,2,6,10,14,2,4,6,7,9,18,11,22,26]
# longest_ap(arr)

# arr1=Array[20,10,2]

# puts arr1.foldl(1000) {|a, b| a / b}
# s="abcde"
# reverseStr(s)
# puts s
