import math

def check_equation(n):
    left_side = math.factorial(n+1) * math.factorial(n+2)
    
    right_side = math.factorial(2*n)

    return left_side == right_side

count = 0
for n in range(0, 2000000):
    if check_equation(n):
        count += 1
        print(f"n = {n}")
print(count)