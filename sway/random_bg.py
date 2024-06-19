#!/usr/bin/env python3

import glob
import random
from pathlib import Path

walls = glob.glob(str(Path.home()) + "/documents/wallpapers/*")
print(random.choice(walls))
