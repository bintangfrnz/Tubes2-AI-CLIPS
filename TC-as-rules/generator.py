import random

# Jika ada field yang duplicate, array ini menyipan jumlah 2 treshold tsb
treshold_times_2 = [
    0.1, 
    33.66, 228.3,
    1.26, 44.98, 55.8,
    0.18, 0.02, 0.34, 3.12,
    1283.2, 26.79
]

for i in range(30):
    f = open("TC" + str(i) + ".txt", 'w')
    for j in range (12):
        f.write(str(round(random.uniform(0.0, treshold_times_2[j]), 2)))
        f.write("\n")
    f.close()