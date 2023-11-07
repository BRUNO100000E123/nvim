import sys
import re

print(re.search(r'\w*(\.)?\w*$', sys.argv[1]).group())
