import re

with open(r'c:\Users\DEEPAK\Desktop\DanceWebsite\viewer_fixed.html', 'r', encoding='utf-8') as f:
    text = f.read()

index = text.find('view-culture-detail')
if index != -1:
    print('Found in viewer_fixed at', index)
else:
    print('Not found in viewer_fixed')

with open(r'c:\Users\DEEPAK\Desktop\DanceWebsite\viewer.html', 'r', encoding='utf-8') as f:
    text2 = f.read()

index2 = text2.find('view-culture-detail')
if index2 != -1:
    print('Found in viewer at', index2)
else:
    print('Not found in viewer')
