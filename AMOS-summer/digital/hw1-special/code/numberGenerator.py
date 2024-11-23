import random

# 常數定義
NUM_COUNT = 20
RANGE_MIN = 0
RANGE_MAX = 65535
LINE_LENGTH = 5

# 生成符合條件的隨機數字
def generate_numbers():
    while True:
        numbers = [random.randint(RANGE_MIN, RANGE_MAX) for _ in range(NUM_COUNT)]
        sum_decimal = sum(numbers)
        if sum_decimal % 10 in [0, 5]:
            return numbers, sum_decimal

# 生成符合條件的數字和計算累加總和
numbers, sum_decimal = generate_numbers()

# 將這些數字轉換為16進位制
hex_numbers = [hex(num) for num in numbers]

# 計算累加總和（16進位）
sum_hex = hex(sum_decimal)

# 定義每行輸出5個數字的格式化函數
def print_aligned(numbers, title):
    print(title)
    for i in range(0, len(numbers), LINE_LENGTH):
        # 格式化輸出每行5個數字，用[]包住並以逗號區隔
        formatted_numbers = ", ".join(f"{str(num):>6}" for num in numbers[i:i+LINE_LENGTH])
        print(f"[{formatted_numbers}]")
    print()

# 將十進位數字和16進位制數字分別列印，每行5個
print_aligned(numbers, "產生的20個十進位數字:")
print_aligned(hex_numbers, "轉換為16進位制的數字:")

# 列印累加總和
print(f"累加總和（十進位）: {sum_decimal}")
print(f"累加總和（16進位）: {sum_hex}")

# output the generated numbers to a text file
print("[+] Decimal numbers are successfully exported to test_dec.txt")
with open("test_dec.txt", "w") as text_file:
    for i in numbers:
        print(f"{i}",file = text_file)


print("[+] Hexadecimal numbers are successfully exported to test_hex.txt")
with open("test_hex.txt", "w") as text_file:
    for i in hex_numbers:
        print(f"{i}",file = text_file)
