x = "Global"   # global variable
 
def outer():
    x = "Enclosing"  # enclosing variable
   
    def inner():
        nonlocal x  # we will access the encosing vafiable here with the keyword non ocal
       
        x = "Local"     # local variable
        print(" inside the inner function ", x)
       
        x = "Modiying the enclosing variable x"
        print(" after modification in inner function ", x)
   
    inner()
    print("inside the outer function ", x)   # enclosing after modification
   
outer()
print("Outside all the functions...", x)   # Global
 
print(" the lenght function built in is ", len([90,80,45,34,29])) # built in function
